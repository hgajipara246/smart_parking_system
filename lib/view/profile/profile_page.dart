import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parking_system/model/parking_model.dart';
import 'package:smart_parking_system/utils/utils.dart';
import 'package:smart_parking_system/view/login_signup_screen/login_screen.dart';
import 'package:smart_parking_system/view/profile/profile_details.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  UserModel userModel = UserModel();
  Utils utils = Utils();

  getUser() {
    CollectionReference users = firebaseFirestore.collection("user");
    users.doc(firebaseAuth.currentUser!.uid).get().then((value) {
      debugPrint("User Profile  --------> ${jsonEncode(value.data())}");
      userModel = userModelFromJson(jsonEncode(value.data()));
      setState(() {});
    }).catchError((error) {
      debugPrint("Failed to get user  : $error");
    });
  }

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    getUser();

    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutQuart),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, -0.5), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuart,
      ),
    );

    // Start the animation when the widget is first built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onProfileDetailsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileDetails(),
      ),
    );
  }

  void onNotificationTap() {
    // Implement your logic for Notification here
    print('Notification tapped');
  }

  void onHelpTap() {
    // Implement your logic for Help here
    print('Help tapped');
  }

  void onDarkThemeToggle(bool value) {
    if (value) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
  }

  Future<void> onLogoutTap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Logout"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Are you sure you want to logout?"),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(false); // Dismiss the dialog and return false
              },
              child: Text("Cancel"),
              isDefaultAction: true,
            ),
            CupertinoDialogAction(
              onPressed: () async {
                await firebaseAuth.signOut();
                debugPrint("User is LogOut");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
                utils.showSnackBar(message: "You are now Logout..!", context);
              },
              child: Text("Logout"),
              isDestructiveAction: true,
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedRow({required String imageAsset, required String text, VoidCallback? onTap}) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          child: Row(
            children: [
              Image.asset(
                imageAsset,
                height: 30,
                color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 15),
              Text(
                text,
                style: const TextStyle(
                  fontFamily: "Lato",
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedProfileInfo() {
    String profileImage = "assets/images/profile/person.png"; // Default profile image

    // Check user's gender and update profile image accordingly
    if (userModel.gender == "male") {
      profileImage = "assets/images/profile/person.png";
    } else if (userModel.gender == "female") {
      profileImage = "assets/images/profile/avatarGirl.png";
    }

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Center(
          child: Column(
            children: [
              Image.asset(
                profileImage, // Use the updated profile image here
                height: 180,
              ),
              const SizedBox(height: 15),
              Text(
                "${userModel.name}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "${userModel.email}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AdaptiveTheme(
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnimatedProfileInfo(),
                  const SizedBox(height: 25),
                  _buildAnimatedRow(
                    imageAsset: "assets/images/profile/Profile.png",
                    text: "Profile Details",
                    onTap: onProfileDetailsTap,
                  ),
                  const SizedBox(height: 15),
                  _buildAnimatedRow(
                    imageAsset: "assets/images/profile/Notification.png",
                    text: "Notification",
                    onTap: onNotificationTap,
                  ),
                  const SizedBox(height: 15),
                  _buildAnimatedRow(
                    imageAsset: "assets/images/profile/Info_Square.png",
                    text: "Help",
                    onTap: onHelpTap,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      _buildAnimatedRow(
                        imageAsset: "assets/images/profile/Show.png",
                        text: "Dark Theme",
                      ),
                      const Spacer(),
                      Switch(
                        activeColor: Colors.white,
                        trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
                        thumbColor: const MaterialStatePropertyAll(Colors.white),
                        activeTrackColor: Colors.orangeAccent,
                        trackColor: const MaterialStatePropertyAll(Color(0xff032fd7)),
                        thumbIcon: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.selected)) {
                              return const Icon(
                                Icons.dark_mode,
                                color: Color(0xff6482f6),
                              );
                            } else {
                              return const Icon(
                                Icons.light_mode,
                                color: Color(0xff6482f6),
                              );
                            }
                          },
                        ),
                        value: AdaptiveTheme.of(context).mode.isDark,
                        onChanged: onDarkThemeToggle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    onTap: onLogoutTap,
                    child: Row(
                      children: [
                        _buildAnimatedRow(
                          imageAsset: "assets/images/profile/Logout.png",
                          text: "Logout",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
