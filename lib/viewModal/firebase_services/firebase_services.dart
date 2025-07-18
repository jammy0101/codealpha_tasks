import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  // Future<UserCredential?>  loginWithGoogle()async{
  //   try{
  //     final googleUser = await GoogleSignIn().signIn();
  //
  //     final googleAuth = await googleUser?.authentication;
  //
  //     final cred = GoogleAuthProvider.credential(idToken: googleAuth?.idToken,accessToken: googleAuth?.accessToken,);
  //
  //     return auth.signInWithCredential(cred);
  //
  //   }catch(e){
  //     SnackBar(content: Text('Google authentication error'));
  //     print(e.toString());
  //   }
  //   return null;
  // }

  // Future<void> loginWithGoogle({required String role}) async {
  //   loadingGoogleRegistration.value = true;
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       Utils.toastMessage("Google sign-in cancelled");
  //       return;
  //     }
  //
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     UserCredential userCredential = await auth.signInWithCredential(credential);
  //     User user = userCredential.user!;
  //
  //     // 🔍 Save user data (with role)
  //     await saveUserData(user, role, () {
  //       print("Google user profile saved");
  //     });
  //
  //     // ✅ Navigate based on role
  //     if (role == "Seller") {
  //       Get.offAllNamed(RoutesName.sellerDashboard);
  //     } else {
  //       Get.offAllNamed(RoutesName.buyerDashboard);
  //     }
  //
  //     print("Google sign-in successful: ${user.uid}");
  //   } catch (e) {
  //     Utils.toastMessage("Google sign-in error: $e");
  //     print("Google Sign-in error: $e");
  //   } finally {
  //     loadingGoogleRegistration.value = false;
  //   }
  // }

  Future<void> loginWithGoogle({required String role}) async {
    loadingGoogleRegistration.value = true;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // 🔁 Always sign out first to show the account picker
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Utils.toastMessage("Google sign-in cancelled");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(credential);
      User user = userCredential.user!;

      // 🔍 Save user data (with role)
      await saveUserData(user, role, () {
        print("Google user profile saved");
      });

      // ✅ Navigate based on role
      if (role == "Seller") {
        Get.offAllNamed(RoutesName.sellerDashboard);
      } else {
        Get.offAllNamed(RoutesName.buyerDashboard);
      }

      print("Google sign-in successful: ${user.uid}");
    } catch (e) {
      Utils.toastMessage("Google sign-in error: $e");
      print("Google Sign-in error: $e");
    } finally {
      loadingGoogleRegistration.value = false;
    }
  }


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