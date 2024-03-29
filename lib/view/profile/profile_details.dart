import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smart_parking_system/model/remotely_model.dart';
import 'package:smart_parking_system/utils/utils.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  UserModel userModel = UserModel();
  Utils utils = Utils();

  getUser() {
    CollectionReference users = firebaseFirestore.collection("user");
    users.doc(firebaseAuth.currentUser!.uid).get().then((value) {
      debugPrint("User Details  --------> ${jsonEncode(value.data())}");
      userModel = userModelFromJson(jsonEncode(value.data()));
      setState(() {});
    }).catchError((error) {
      debugPrint("Failed to get user  : $error");
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  profileImage() {
    String profileImage = "assets/images/profile/person.png"; // Default profile image

    // Check user's gender and update profile image accordingly
    if (userModel.gender == "male") {
      profileImage = "assets/images/profile/person.png";
    } else if (userModel.gender == "female") {
      profileImage = "assets/images/profile/avatarGirl.png";
    }
    return profileImage;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) {
        return Scaffold(
          backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
            ),
            backgroundColor: AdaptiveTheme.of(context).mode.isDark ? const Color(0xFFB4B4B4) : const Color(0xffd5d5ff),
            title: Text(
              "Profile Details",
              style: TextStyle(
                color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AdaptiveTheme.of(context).mode.isDark ? const Color(0xFFB4B4B4) : const Color(0xffd5d5ff),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white, // Background color
                                borderRadius: BorderRadius.circular(100), // Border radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), // Shadow color
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10), // Clip the image inside the container
                                child: Image.asset(
                                  profileImage(), // Use the updated profile image here
                                  height: 180,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                      color: AdaptiveTheme.of(context).mode.isDark ? const Color(0xFFB4B4B4) : const Color(0xffd5d5ff),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Icon(
                            LineAwesome.pen_fancy_solid,
                            color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            userModel.name ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                      color: AdaptiveTheme.of(context).mode.isDark ? const Color(0xFFB4B4B4) : const Color(0xffd5d5ff),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Icon(
                            EvaIcons.email_outline,
                            color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            userModel.email ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                      color: AdaptiveTheme.of(context).mode.isDark ? const Color(0xFFB4B4B4) : const Color(0xffd5d5ff),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Icon(
                            LineAwesome.car_solid,
                            color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            userModel.carNumberPlate ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                      color: AdaptiveTheme.of(context).mode.isDark ? const Color(0xFFB4B4B4) : const Color(0xffd5d5ff),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Icon(
                            AntDesign.mobile_outline,
                            color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            userModel.phoneNumber ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                      color: AdaptiveTheme.of(context).mode.isDark ? const Color(0xFFB4B4B4) : const Color(0xffd5d5ff),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          userModel.gender == "male"
                              ? Icon(
                                  Icons.male,
                                  color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                                )
                              : Icon(
                                  Icons.female,
                                  color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                                ),
                          const SizedBox(width: 10),
                          Text(
                            userModel.gender ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                      color: AdaptiveTheme.of(context).mode.isDark ? const Color(0xFFB4B4B4) : const Color(0xffd5d5ff),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            userModel.city ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
