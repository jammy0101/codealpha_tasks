import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import '../../resources/color/color.dart';
import '../../resources/customDrawer/bottumNavigation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../resources/routes/routes_name.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;


  final TextEditingController displayName = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String selectedGender = 'Male'; // default value
  String? profileImageUrl;
  bool loading = true;


  bool isLoading = true;
  //File? _imageFile;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc = await firestore.collection('users_profile').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        setState(() {
          displayName.text = data['displayName'] ?? '';
          phoneController.text = data['phoneNumber'] ?? '';
          selectedGender = data['gender'] ?? 'Male';
          addressController.text = data['address'] ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("❌ Error loading user profile: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> saveUserProfile() async {
  //   final uid = auth.currentUser?.uid;
  //   if (uid == null) return;
  //
  //   final docRef = FirebaseFirestore.instance
  //       .collection('users_profile')
  //       .doc(uid);
  //   await docRef.set({
  //     'displayName': displayName.text.trim(), // keep using 'name' here
  //     'phoneNumber': phoneController.text.trim(),
  //     'gender': selectedGender,
  //     'address': addressController.text,
  //   }, SetOptions(merge: true)); // Prevents overwriting existing fields
  //
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(const SnackBar(content: Text("✅ Profile updated")));
  //
  //   setState(() {});
  // }
  Future<void> saveUserProfile() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return;

    final docRef = firestore.collection('users_profile').doc(uid);

    await docRef.set({
      'displayName': displayName.text.trim(),
      'phoneNumber': phoneController.text.trim(),
      'gender': selectedGender,
      'address': addressController.text,
      //'photoURL': profileImageUrl, // ✅ Save image URL here
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Profile updated")),
    );

    setState(() {});
  }

  Future<void> _deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;

    if (email == null) {
      Get.snackbar("Error", "No user logged in");
      return;
    }

    final passwordController = TextEditingController();

    final confirm = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Re-authenticate"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Please enter your password to continue."),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {'password': passwordController.text});
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );

    if (confirm != null && confirm.containsKey('password')) {
      final password = confirm['password']!;
      try {
        final cred = EmailAuthProvider.credential(email: email, password: password);
        await user!.reauthenticateWithCredential(cred);

        // ✅ Now delete Firestore data, image, and account
        await FirebaseFirestore.instance.collection('users_profile').doc(user.uid).delete();

        final ref = FirebaseStorage.instance.ref().child('user_profiles/${user.uid}.jpg');
        await ref.delete().catchError((_) {
          print("No image found to delete or already deleted.");
        });

        await user.delete();
        await FirebaseAuth.instance.signOut();

        Get.snackbar("Success", "Account deleted successfully");
        Get.offAllNamed(RoutesName.registrationScreen);
      } catch (e) {
        print("❌ Re-authentication error: $e");
        Get.snackbar("Error", "Failed to delete account: $e");
      }
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      bottomNavigationBar: BottomNavigation(index: 3),
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.wow2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        color: AppColor.wow3,
                      ),
                      Positioned(
                        top: 125,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: CircleAvatar(
                                    radius: 50,
                                      backgroundImage: profileImageUrl != null
                                          ? NetworkImage(profileImageUrl!)
                                          : const AssetImage('assets/images/women.jpg')
                                      as ImageProvider,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: InkWell(
                                    onTap: () async {
                                      print('Camera icon tapped');
                                      //await pickImageFromGallery();
                                    },
                                    child: const CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              displayName.text,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: displayName,
                          decoration: const InputDecoration(
                            labelText: 'Display Name',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                          ),
                        ),
                        SizedBox(height: 10),
                        // Inside your Column widget
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedGender,
                          items: ['Male', 'Female', 'Other'].map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedGender = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            // border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          label: const Text('Delete Account'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: _deleteAccount,
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: saveUserProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.wow2,
                          ),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    displayName.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
