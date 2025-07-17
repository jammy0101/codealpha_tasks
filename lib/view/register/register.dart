import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../resources/color/color.dart';
import '../../resources/constants/customTextFormField.dart';
import '../../resources/constants/customTextFormPassword.dart';
import '../../resources/roundButton/roundButton.dart';
import '../../resources/roundButton/roundButton2.dart';
import '../../resources/routes/routes_name.dart';
import '../../viewModal/firebase_services/firebase_services.dart';




class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}


final FirebaseServices firebaseServices = Get.find<FirebaseServices>();


class _RegistrationScreenState extends State<RegistrationScreen> {
  final  formKey1 = GlobalKey<FormState>();
  final TextEditingController emailControllerR = TextEditingController();
  final TextEditingController passwordControllerR = TextEditingController();
  final TextEditingController confirmPasswordR = TextEditingController();
  String selectedRole = 'Buyer'; // Default

  @override
  void dispose() {
    emailControllerR.dispose();
    passwordControllerR.dispose();
    confirmPasswordR.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/register.png',
              fit: BoxFit.cover, // Makes image cover the entire area
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 70,horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Reg',style: TextStyle(color: AppColor.blackColor,fontSize: 36,fontFamily: 'SourceSans3',),),
                      Text('istration!',style: TextStyle(
                          wordSpacing: 2,
                          letterSpacing: 2.3,
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor,
                          fontSize: 36,fontFamily: 'SourceSans3',
                          shadows: [
                            Shadow(
                              color: Colors.purple,
                              offset: Offset(1, 2.3),
                            ),
                          ]),),
                    ],
                  ),
                ),
                Form(
                  key: formKey1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFieldEmail(
                        controller: emailControllerR,
                        hintText: 'Enter the email..',
                        validator: validateEmail,
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButtonFormField<String>(
                          value: selectedRole,
                          decoration: InputDecoration(
                            labelText: 'Select Role',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black), // optional
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black), // optional
                            ),
                          ),
                          items: ['Buyer', 'Seller'].map((role) {
                            return DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedRole = value!;
                          },
                        ),
                      ),

                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          child: Obx(() {
                            return CustomTextField(
                              controller: passwordControllerR,
                              obscureText: !firebaseServices.isPasswordVisibleR.value,
                              hintText: 'Enter the password..',
                              suffixIcon: IconButton(
                                onPressed: firebaseServices.togglePasswordVisibility,
                                icon: firebaseServices.isPasswordVisibleR.value ? Icon(Icons.visibility) : Icon(Icons.visibility_off_sharp),
                              ),
                              validator: validatePassword,
                            );
                          })
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Obx(() {
                          return CustomTextField(
                            controller: confirmPasswordR,
                            obscureText: !firebaseServices.isPasswordVisibleRE.value,
                            hintText: 'Enter Confirm Password..',
                            suffixIcon: IconButton(
                              onPressed: firebaseServices.toggleConfirmPasswordVisibility,
                              icon: firebaseServices.isPasswordVisibleRE.value
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off_sharp),
                            ),
                            validator: validateConfirmPassword,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Obx(() {
                  return RoundButton(
                    width: 377,
                    height: 60,
                    loading: firebaseServices.loadingRegistration.value,
                    title: 'Registration',
                    onPress: (){
                      if(formKey1.currentState!.validate()){
                        firebaseServices.registration(
                          email : emailControllerR.text.trim(),
                          password : passwordControllerR.text.toString(),
                          role: selectedRole.trim(),
                        );
                      }
                    },
                    roundButton: AppColor.blackColor,
                    textColor: AppColor.blackColor,
                  );
                }),
                SizedBox(height: 10,),
                TextButton(
                    onPressed: (){
                      Get.toNamed(RoutesName.loginScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an Account?',style: TextStyle(fontSize: 23,color: AppColor.blackColor),),
                        Text('Login',style: TextStyle(color: AppColor.wow1,fontSize: 23,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 2,color: AppColor.blackColor,)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Or Continue'),
                    ),
                    Expanded(child: Divider(thickness: 2,color: AppColor.blackColor,)),
                  ],
                ),
                SizedBox(height: 16,),
                Obx(() {
                  return  RoundButton2(
                    width: 377,
                    height: 60,
                    loading: firebaseServices.loadingGoogleRegistration.value,
                    title: 'Google',
                    onPress: (){
                      //Here Google integration
                    },
                    textColor: AppColor.blackColor,
                    buttonColor2: AppColor.wow2,
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
  String? validateConfirmPassword(String? value){
    String password = passwordControllerR.text.trim();
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != password) {
      // Show Snackbar for mismatch
      Future.delayed(Duration.zero, () {
        Get.snackbar(
            "Error",
            "Passwords do not match",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white
        );
      });
      return "Passwords do not match";
    }
    return null;
  }
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }
}
