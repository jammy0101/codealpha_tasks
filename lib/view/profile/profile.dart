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
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  // Future<void> loadUserProfile() async {
  //   final uid = auth.currentUser?.uid;
  //   if (uid == null) return;
  //
  //   try {
  //     final doc = await firestore.collection('users_profile').doc(uid).get();
  //
  //     if (doc.exists && doc.data() != null) {
  //       final data = doc.data()!;
  //       displayName.text = data['displayName'] ?? '';
  //       phoneController.text = data['phoneNumber'] ?? '';
  //       selectedGender = data['gender'] ?? 'Male';
  //       addressController.text = data['address'] ?? '';
  //       final imageUrl = data['photoURL'] as String?;
  //       if (imageUrl != null && imageUrl.isNotEmpty) {
  //         setState(() {
  //           profileImageUrl = imageUrl;
  //         });
  //       }
  //
  //     }
  //   } catch (e) {
  //     print("Error loading user profile: $e");
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

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

          final imageUrl = data['photoURL'] as String?;
          if (imageUrl != null && imageUrl.isNotEmpty) {
            profileImageUrl = imageUrl;
          }

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
      'photoURL': profileImageUrl, // ✅ Save image URL here
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Profile updated")),
    );

    setState(() {});
  }

  // Future<void> _deleteAccount() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return;
  //
  //   final confirm = await showDialog<bool>(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text("Delete Account?"),
  //       content: const Text("This will permanently delete your profile and all related data."),
  //       actions: [
  //         TextButton(
  //           child: const Text("Cancel"),
  //           onPressed: () => Navigator.pop(ctx, false),
  //         ),
  //         ElevatedButton(
  //           child: const Text("Delete"),
  //           style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
  //           onPressed: () => Navigator.pop(ctx, true),
  //         ),
  //       ],
  //     ),
  //   );
  //
  //   if (confirm != true) return;
  //
  //   try {
  //     final uid = user.uid;
  //
  //     // Delete Firestore user document
  //     await FirebaseFirestore.instance.collection('users_profile').doc(uid).delete();
  //
  //     // Delete image from Firebase Storage
  //     final ref = FirebaseStorage.instance.ref().child('user_profiles/$uid.jpg');
  //     try {
  //       await ref.delete();
  //     } catch (_) {
  //       print("No image found to delete or already deleted.");
  //     }
  //
  //     // Try to delete Firebase user
  //     await user.delete();
  //     await FirebaseAuth.instance.signOut();
  //
  //     // If successful, navigate
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text(" Account deleted successfully")),
  //     );
  //     // ✅ Delay navigation slightly so snackbar shows
  //     await Future.delayed(const Duration(milliseconds: 1000));
  //     //
  //     // Navigator.pushNamedAndRemoveUntil(
  //     //   context,
  //     //   RoutesName.registrationScreen,
  //     //       (route) => false,
  //     // );
  //
  //     Get.offAllNamed(RoutesName.registrationScreen);
  //
  //
  //
  //
  //   } catch (e) {
  //     print("❌ Error deleting account: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("❌ Failed to delete account: $e")),
  //     );
  //   }
  // }



  // Future<void> pickImageFromGallery() async {
  //   PermissionStatus status;
  //
  //   if (Platform.isAndroid) {
  //     // Android 13+ uses READ_MEDIA_IMAGES, others use storage
  //     if (await Permission.photos.request().isGranted) {
  //       status = PermissionStatus.granted;
  //     } else if (await Permission.storage.request().isGranted) {
  //       status = PermissionStatus.granted;
  //     } else {
  //       status = PermissionStatus.denied;
  //     }
  //   } else {
  //     // iOS
  //     status = await Permission.photos.request();
  //   }
  //
  //   if (status.isGranted) {
  //     final picker = ImagePicker();
  //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       setState(() => _imageFile = File(pickedFile.path));
  //       await uploadImageToFirebase();
  //     } else {
  //       print("❌ No image selected.");
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("❌ Permission denied")),
  //     );
  //     openAppSettings(); // optional
  //   }
  // }



  // Future<void> uploadImageToFirebase() async {
  //   final uid = auth.currentUser?.uid;
  //   if (_imageFile == null || uid == null) return;
  //
  //   final ref = storage.ref().child('user_profiles').child('$uid.jpg');
  //
  //   await ref.putFile(_imageFile!);
  //   final imageUrl = await ref.getDownloadURL();
  //
  //   await firestore.collection('users_profile').doc(uid).update({
  //     'photoURL':
  //         imageUrl, // <-- You can remove this line if you don't want to save the URL at all
  //   });
  //
  //
  //   setState(() {
  //
  //   });
  //
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(const SnackBar(content: Text("✅ Profile picture updated")));
  // }
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


  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      await uploadImageToFirebase(); // this sets profileImageUrl & updates Firestore
    } else {
      print("❌ No image selected.");
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (_imageFile == null) return;
    final uid = auth.currentUser?.uid;
    if (uid == null) return;

    try {
      final ref = storage.ref().child('user_profiles/$uid.jpg');
      await ref.putFile(_imageFile!);

      final imageUrl = await ref.getDownloadURL();

      // Update profileImageUrl in Firestore
      await firestore.collection('users_profile').doc(uid).update({
        'photoURL': imageUrl,
      });

      setState(() {
        profileImageUrl = imageUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Profile picture uploaded")),
      );
    } catch (e) {
      print("❌ Error uploading image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to upload image")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      bottomNavigationBar: BottomNavigation(index: 3),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColor.wow2,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                    // backgroundImage: _imageFile != null
                                    //     ? FileImage(_imageFile!)
                                    //     : const AssetImage("assets/images/women.jpg") as ImageProvider,
                                    // backgroundImage: _imageFile != null
                                    //     ? FileImage(_imageFile!)
                                    //     : profileImageUrl != null
                                    //     ? NetworkImage(profileImageUrl!)
                                    //     : const AssetImage("assets/images/women.jpg") as ImageProvider,
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
                                      await pickImageFromGallery();
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
