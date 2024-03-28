import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parking_system/view/bottom_navigation/bottom_nevigation.dart';
import 'package:smart_parking_system/view/login_signup_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if user is logged in with Firebase
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    // Simulating a delay for demonstration purposes
    await Future.delayed(const Duration(seconds: 2));

    if (user != null) {
      // Set isLoggedIn to true in SharedPreferences
      prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomScreen()),
      );
    } else {
      // User is not logged in, navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );

      // -------------------------------------------------
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      // debugPrint('Is Logged In: $isLoggedIn');
      //
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      //
      // // Check if user is logged in with Firebase
      // FirebaseAuth auth = FirebaseAuth.instance;
      // User? user = auth.currentUser;
      // await Future.delayed(const Duration(seconds: 2));
      //
      // if (isLoggedIn) {
      //   debugPrint('User is logged in. Navigating to BottomScreen...');
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const BottomScreen()),
      //   );
      // } else {
      //   debugPrint('User is not logged in. Navigating to LoginPage...');
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const LoginPage()),
      //   );

      // -----------------------------------------------
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      //
      // await Future.delayed(const Duration(seconds: 5));
      //
      // if (isLoggedIn) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const BottomScreen()),
      //   );
      // } else {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const LoginPage()),
      //   );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 90.0, right: 8, left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/3dparking-edited.png",
                alignment: Alignment.center,
              ),
              const SizedBox(height: 15),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Lato',
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Automate Park',
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  isRepeatingAnimation: false,
                  onTap: () {
                    debugPrint("Tap Event");
                  },
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Version 1.0.0+1",
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
