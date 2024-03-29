import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parking_system/model/remotely_model.dart';
import 'package:smart_parking_system/res/common/app_button/main_button.dart';
import 'package:smart_parking_system/res/common/app_button/text_button.dart';
import 'package:smart_parking_system/res/common/app_textformfild.dart';
import 'package:smart_parking_system/utils/utils.dart';
import 'package:smart_parking_system/view/bottom_navigation/bottom_nevigation.dart';
import 'package:smart_parking_system/view/login_signup_screen/forgot_password_page.dart';
import 'package:smart_parking_system/view/login_signup_screen/signup_page.dart';

import '../../res/constant/app_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserCredential? userCredential;
  User? user;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Utils utils = Utils();
  UserModel userModel = UserModel();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool password = true;

  void signUpTextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Padding(
              padding: EdgeInsets.all(height / 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.Hello,
                  AppText.welcomeBack,
                  SizedBox(
                    height: height / 40,
                  ),
                  Image.asset("assets/images/loginActivity/logins.jpg"),
                  SizedBox(
                    height: height / 50,
                  ),
                  AppText.email,
                  AppTextFormField(
                    validator: (value) => value!.isValidEmail() ? null : "Please Enter Correct E-mail",
                    hintText: "Eg. jamesburnes@gmail.com",
                    controllers: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  AppText.password,
                  AppTextFormField(
                    textInputAction: TextInputAction.done,
                    validator: (value) => value!.isValidPassword() ? null : "Please Enter Correct Password",
                    controllers: passwordController,
                    hintText: "Password",
                    obscuretext: password,
                    sufixIcon: IconButton(
                      icon: password
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        password = !password;
                        setState(
                          () {},
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButtons(
                        textButtonName: "Forgot password?",
                        fontSize: 16,
                        color: const Color(0xFF8A8B7A),
                        textOnPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 800,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MainButton(
                      textName: "Login",
                      mainOnPress: () {
                        loginUser();
                      },
                      backgroundColor: const Color(0xff2950e3),
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: height / 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "You don't have an account?",
                        style: TextStyle(
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Color(0xFF8A8B7A),
                        ),
                      ),
                      TextButtons(
                        textButtonName: "Sign Up",
                        fontSize: 18,
                        color: const Color(0xff2950e3),
                        textOnPress: signUpTextButton,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) async {
        debugPrint("value ----> ${value.user}");
        user = value.user;

        debugPrint("User is LogIn.");
        user = value.user;
        getUser();

        // Set isLoggedIn to true in SharedPreferences upon successful login
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        utils.showSnackBar(
          context,
          message: "No User Found For That Email",
        );
      } else if (e.code == 'wrong-password') {
        debugPrint("wrong password provided for that user.");

        utils.showSnackBar(
          context,
          message: "Your Password Is Incorrect. Please Try Again.",
        );
      }
    }
  }

  getUser() {
    CollectionReference users = firebaseFirestore.collection('user');
    users.doc(user!.uid).get().then((value) {
      debugPrint("User Added -------- > ${jsonEncode(value.data())} ");
      userModel = userModelFromJson(jsonEncode(value.data()));
      utils.showSnackBar(context, message: "LogIn SuccessFully");

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomScreen(),
          ),
          (route) => false);
      setState(() {});
    }).catchError((error) {
      debugPrint("Failed to Add User : $error");
    });
  }
}
