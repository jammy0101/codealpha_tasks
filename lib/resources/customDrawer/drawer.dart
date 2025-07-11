import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../viewModal/firebase_services/firebase_services.dart';
import '../color/color.dart';
import '../routes/routes_name.dart';
import '../utils/utils.dart';

class CustomDrawer extends StatelessWidget {
  final FirebaseAuth auth;

  const CustomDrawer({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.wow3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: BoxDecoration(
                color: AppColor.wow2,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(140.0)),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  'MOBILE SHOP',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.wow1),
            ),
            onTap: () =>  Get.toNamed(RoutesName.homeScreen),
          ),
          ListTile(
            leading: const Icon(Icons.category, color: Colors.black),
            title: const Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.wow1),
            ),
            onTap: () =>  Get.toNamed(RoutesName.category),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.black),
            title: const Text(
              'cart',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.wow1),
            ),
            onTap: () =>  Get.toNamed(RoutesName.cartScreen),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.wow1),
            ),
            onTap: () => Get.toNamed(RoutesName.profile),
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.black),
            title: const Text(
              'Delete Account',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.wow1),
            ),
            onTap: () => _showDeleteAccountDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text(
              'Log Out',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.wow1),
            ),
            onTap: () => _signOut(),
          ),
        ],
      ),
    );
  }

  // void _signOut() async {
  //   try {
  //     await auth.signOut();
  //     Utils.toastMessage('Signed out successfully');
  //     Get.offAll(() => const SignIn());
  //   } catch (e) {
  //     Utils.toastMessage('Error signing out: ${e.toString()}');
  //   }
  // }
  void _signOut() async {
    try {
      await auth.signOut();
      Utils.toastMessage('Signed out successfully');
      //final FirebaseServices controller = Get.find();
      Get.offAllNamed(RoutesName.loginScreen);
    } catch (e) {
      Utils.toastMessage('Error signing out: ${e.toString()}');
    }
  }


  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _deleteAccount(); // Call the delete account function
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    try {
      await auth.currentUser?.delete();
      Utils.toastMessage('Account deleted successfully');
      Get.offAllNamed(RoutesName.loginScreen); // Navigate to sign-in screen
    } catch (e) {
      Utils.toastMessage('Error deleting account: ${e.toString()}');
    }
  }

}
