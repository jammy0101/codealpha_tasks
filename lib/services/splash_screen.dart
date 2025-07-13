import 'package:ecommerce/services/splash_services.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashScreen = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/mobile.jpeg', fit: BoxFit.cover),
          ),
          // Center(
          //   child: SizedBox(
          //     height: 80,
          //     width: 80,
          //     child: LoadingIndicator(
          //       indicatorType: Indicator.audioEqualizer,
          //       colors: [Colors.purple, Colors.blue, Colors.green],
          //       strokeWidth: 10,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
