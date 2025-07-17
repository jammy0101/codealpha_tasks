import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../resources/routes/routes_name.dart';
import '../../resources/utils/utils.dart';

class FirebaseServices extends GetxController{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

//:::::::>> LOADING FUNCTIONALITY <<:::::::::

  final loadingLoginL = false.obs;
  final loadingGoogleL = false.obs;
  final loadingRegistration = false.obs;
  final loadingGoogleRegistration = false.obs;




//:::::::::::>> password visibility section <<::::::::::::::

//-------> For Registration <---------
  final isPasswordVisibleR = false.obs;
  final isPasswordVisibleRE = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisibleR.value = !isPasswordVisibleR.value;
  }
  void toggleConfirmPasswordVisibility() {
    isPasswordVisibleRE.value = !isPasswordVisibleRE.value;
  }
//-------> For Login <---------
  final isPasswordVisibleL = false.obs;
  void togglePasswordVisibilityL() {
    isPasswordVisibleL.value = !isPasswordVisibleL.value;
  }



  //:::::::::::>>LOGIN AND REGISTRATION FUNCTIONALITY<<::::::::::::

  Future<void>  registration({required String email, required String password ,required String role})async{
    loadingRegistration.value = true;
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );

      // Save profile immediately
      await saveUserData(auth.currentUser!, role ,() {
        print("User profile created");
      });
      Get.snackbar("Successfully", 'Registration Completed');
      print("User Register : ${userCredential.user!.uid}");
      Get.offAllNamed(RoutesName.buyerDashboard);
    }catch(e){
      Get.snackbar('Error', e.toString());
      print("error : $e");
    }finally{
      loadingRegistration.value = false;
    }
  }

  // Future<void>  login({required String email, required String password})async{
  //   loadingLoginL.value = true;
  //   try{
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     // Save profile immediately
  //     await saveUserData(auth.currentUser!, () {
  //       print("User profile created");
  //     });
  //     Get.snackbar("Successfully", 'Login Completed');
  //     print("User Login : ${userCredential.user!.uid}");
  //     Get.offAllNamed(RoutesName.homeScreen);
  //   }catch(e){
  //     Get.snackbar('Error', e.toString());
  //     print("error : $e");
  //   }finally{
  //     loadingLoginL.value = false;
  //   }
  // }



  // :::::::::::::>>> ABOUT USER PROFILE <<<::::::::::::

  Future<void> login({required String email, required String password}) async {
    loadingLoginL.value = true;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 🔍 Fetch user data (optional)
      final uid = auth.currentUser!.uid;
      final doc = await FirebaseFirestore.instance.collection('users_profile').doc(uid).get();

      if (doc.exists) {
        final role = doc.data()?['role'];
        print('User role: $role');

        // ✅ Redirect based on role
        if (role == 'Seller') {
          Get.offAllNamed(RoutesName.sellerDashboard);
        } else {
          Get.offAllNamed(RoutesName.buyerDashboard);
        }
      } else {
        Get.snackbar('Error', 'User data not found!');
      }

      print("User Login : ${userCredential.user!.uid}");
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print("error : $e");
    } finally {
      loadingLoginL.value = false;
    }
  }

  /// Save or Update User Data in Firestore
  // Future<void> saveUserData(User user, VoidCallback onSuccess) async {
  //   if (user.uid.isEmpty) {
  //     Utils.toastMessage('User ID is missing');
  //     return;
  //   }
  //
  //   try {
  //     final docRef = FirebaseFirestore.instance.collection('users_profile').doc(user.uid);
  //     final docSnapshot = await docRef.get();
  //
  //     if (!docSnapshot.exists) {
  //       // New user: save minimal data
  //       final Map<String, dynamic> userData = {
  //         'uid': user.uid,
  //         'email': user.email ?? '',
  //         'displayName': user.displayName ?? '',
  //         'photoURL': user.photoURL ?? '',
  //         //'rating': 0.0,
  //         'createdAt': FieldValue.serverTimestamp(),
  //       };
  //
  //       await docRef.set(userData);
  //     } else {
  //       // Existing user: update basic info if needed
  //       final Map<String, dynamic> updatedData = {
  //         'email': user.email ?? '',
  //         'displayName': user.displayName ?? '',
  //         'photoURL': user.photoURL ?? '',
  //       };
  //
  //       await docRef.update(updatedData);
  //     }
  //
  //     onSuccess();
  //     Utils.toastMessage('User data saved successfully');
  //   } catch (error) {
  //     Utils.toastMessage(error.toString());
  //   }
  // }

  Future<void> saveUserData(User user, String role, VoidCallback onSuccess) async {
    if (user.uid.isEmpty) {
      Utils.toastMessage('User ID is missing');
      return;
    }

    try {
      final docRef = FirebaseFirestore.instance.collection('users_profile').doc(user.uid);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        // New user: save data with role
        final Map<String, dynamic> userData = {
          'uid': user.uid,
          'email': user.email ?? '',
          'displayName': user.displayName ?? '',
          'photoURL': user.photoURL ?? '',
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        };

        await docRef.set(userData);
      } else {
        // Existing user: update basic info
        final Map<String, dynamic> updatedData = {
          'email': user.email ?? '',
          'displayName': user.displayName ?? '',
          'photoURL': user.photoURL ?? '',
        };

        await docRef.update(updatedData);
      }

      onSuccess();
      Utils.toastMessage('User data saved successfully');
    } catch (error) {
      Utils.toastMessage(error.toString());
    }
  }



}