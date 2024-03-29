import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking_system/model/remotely_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth? firebaseAuth;
  FirebaseFirestore? firebaseFirestore;
  FirebaseStorage? firebaseStorage;

  UserModel userModel = UserModel();
  bool isLoading = true;

  String profileImage() {
    String profileImagePath = "assets/images/profile/person.png"; // Default profile image path

    // Check user's gender and update profile image path accordingly
    if (userModel.gender == "male") {
      profileImagePath = "assets/images/profile/person.png";
    } else if (userModel.gender == "female") {
      profileImagePath = "assets/images/profile/avatarGirl.png";
    }
    return profileImagePath;
  }

  @override
  void initState() {
    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;
    firebaseStorage = FirebaseStorage.instance;
    getUser();
    super.initState();
  }

  void getUser() {
    CollectionReference users = firebaseFirestore!.collection("user");
    users.doc(firebaseAuth!.currentUser!.uid).get().then((value) {
      debugPrint("User Home  --------> ${jsonEncode(value.data())}");
      userModel = userModelFromJson(jsonEncode(value.data()));
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      debugPrint("Failed to get user  : $error");
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
        title: const Text(
          'Automate Park',
          style: TextStyle(
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AdaptiveTheme(
              light: ThemeData.light(),
              dark: ThemeData.dark(),
              initial: AdaptiveThemeMode.light,
              builder: (theme, darkTheme) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xffececfd),
                              backgroundImage: AssetImage(
                                profileImage(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${userModel.name}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Theme.of(context).textTheme.headline1!.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${userModel.email}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).textTheme.headline1!.color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Your Recent Activity",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class PaymentAllData {
  final String selectedDate;
  final String startTime;
  final String endTime;
  final int totalHour;
  final int slotNumber;
  final double price;
  final double total;
  final String qrCodeUrl;

  PaymentAllData({
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
    required this.totalHour,
    required this.slotNumber,
    required this.price,
    required this.total,
    required this.qrCodeUrl,
  });

  factory PaymentAllData.fromMap(Map<String, dynamic> map) {
    return PaymentAllData(
      selectedDate: map['selectedDate'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      totalHour: map['totalHour'],
      slotNumber: map['slotNumber'],
      price: map['price'],
      total: map['total'],
      qrCodeUrl: map['qrCodeUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selectedDate': selectedDate,
      'startTime': startTime,
      'endTime': endTime,
      'totalHour': totalHour,
      'slotNumber': slotNumber,
      'price': price,
      'total': total,
      'qrCodeUrl': qrCodeUrl,
    };
  }
}
