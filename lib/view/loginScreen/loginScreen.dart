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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final FirebaseServices firebaseServices = Get.find<FirebaseServices>();


class _LoginScreenState extends State<LoginScreen> {
  final  formKey2 = GlobalKey<FormState>();

  //For Login
  final TextEditingController emailControllerL = TextEditingController();
  final TextEditingController passwordControllerL = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    emailControllerL.dispose();
    passwordControllerL.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login.png',
              fit: BoxFit.cover, // Makes image cover the entire area
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'WEL',
                        style: TextStyle(color: AppColor.blackColor, fontSize: 36),
                      ),
                      Text(
                        'COME BACK!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.wow2,
                          fontSize: 36,
                          fontFamily: 'SourceSans3',
                          wordSpacing: 2,
                          letterSpacing: 2.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFieldEmail(
                        controller: emailControllerL,
                        hintText: 'Enter the email..',
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Obx(() {
                          return CustomTextField(
                            controller: passwordControllerL,
                            obscureText: !firebaseServices.isPasswordVisibleL.value,
                            hintText: 'Enter the Password',
                            suffixIcon: IconButton(
                              onPressed: firebaseServices.togglePasswordVisibilityL,
                              icon: Icon(
                                firebaseServices.isPasswordVisibleL.value
                                    ? Icons.visibility
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                            validator: validatePassword,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        //About forgot password
                      },
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6,),
                Obx(() {
                  return RoundButton(
                    width: 377,
                    height: 60,
                    title: 'Login',
                    loading: firebaseServices.loadingLoginL.value,
                    onPress: (){
                      if(formKey2.currentState!.validate()){
                        firebaseServices.login(
                          email: emailControllerL.text.trim(),
                          password: passwordControllerL.text.trim(),
                        );
                      }
                    },
                    roundButton: AppColor.blackColor,
                    textColor: AppColor.blackColor,
                  );
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text('or continue'),
                ),
                Obx(() {
                  return  RoundButton2(
                    width: 377,
                    height: 60,
                    loading: firebaseServices.loadingGoogleL.value,
                    title: 'Google',
                    onPress: (){
                      //Google integration
                    },
                    textColor: AppColor.blackColor,
                    buttonColor2: AppColor.wow2,
                  );
                }),
                TextButton(
                  onPressed: () {
                    Get.toNamed(RoutesName.registrationScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppColor.blackColor,
                        ),
                      ),
                      Text(
                        'Registration',
                        style: TextStyle(
                          color: AppColor.wow1,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
