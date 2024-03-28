// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_parking_system/res/common/app_button/main_button.dart';
// import 'package:smart_parking_system/res/common/app_button/text_button.dart';
// import 'package:smart_parking_system/res/common/app_textformfild.dart';
// import 'package:smart_parking_system/res/constant/app_text.dart';
// import 'package:smart_parking_system/utils/utils.dart';
// import 'package:smart_parking_system/view/login_signup_screen/login_screen.dart';
//
// class SignUpPage extends StatefulWidget {
//   const SignUpPage({Key? key}) : super(key: key);
//
//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }
//
// class _SignUpPageState extends State<SignUpPage> {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   User? user;
//
//   Utils utils = Utils();
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   bool password = false;
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     // double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Form(
//           key: formKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: SingleChildScrollView(
//             keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
//             child: Padding(
//               padding: EdgeInsets.all(height / 40),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: height / 50),
//                   AppText.Hello,
//                   RichText(
//                     text: const TextSpan(
//                       text: "Welcome To ",
//                       style: TextStyle(
//                         fontFamily: "Avenir",
//                         fontWeight: FontWeight.w900,
//                         fontSize: 22,
//                         color: Color(0xFF040B14),
//                       ),
//                       children: [
//                         TextSpan(
//                           text: "Automate Park",
//                           style: TextStyle(
//                             fontFamily: "Avenir",
//                             fontWeight: FontWeight.w900,
//                             fontSize: 22,
//                             color: Color(0xff2950e3),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Image.asset("assets/images/loginActivity/signIn.jpg"),
//                   AppText.name,
//                   AppTextFormField(
//                     // validator: (value) => value!.isValidEmail() ? null : "Please Enter Correct E-mail",
//                     hintText: "Enter Your Name",
//                     controllers: nameController,
//                     textInputAction: TextInputAction.next,
//                     keyboardType: TextInputType.name,
//                   ),
//                   AppText.email,
//                   AppTextFormField(
//                     validator: (value) => value!.isValidEmail() ? null : "Please Enter Correct E-mail",
//                     hintText: "Eg. jamesburnes@gmail.com",
//                     controllers: emailController,
//                     textInputAction: TextInputAction.next,
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   SizedBox(
//                     height: height / 60,
//                   ),
//                   AppText.phoneNumber,
//                   AppTextFormField(
//                     validator: (value) => value!.isValidMobile() ? null : "Please Enter Correct Phone Number",
//                     hintText: "00000 00000",
//                     controllers: phoneNumberController,
//                     keyboardType: TextInputType.phone,
//                     textInputAction: TextInputAction.next,
//                   ),
//                   SizedBox(
//                     height: height / 60,
//                   ),
//                   AppText.password,
//                   AppTextFormField(
//                     validator: (value) => value!.isValidPassword() ? null : "Please Enter Correct Password",
//                     keyboardType: TextInputType.visiblePassword,
//                     controllers: passwordController,
//                     hintText: "Password",
//                     textInputAction: TextInputAction.done,
//                     obscuretext: password,
//                     sufixIcon: IconButton(
//                       icon: password
//                           ? const Icon(
//                               Icons.visibility_off,
//                               color: Colors.black,
//                             )
//                           : const Icon(
//                               Icons.visibility,
//                               color: Colors.black,
//                             ),
//                       onPressed: () {
//                         password = !password;
//                         setState(
//                           () {},
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: height / 25,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: MainButton(
//                       textName: "Sign Up",
//                       backgroundColor: const Color(0xff2950e3),
//                       mainOnPress: () {
//                         creatUser();
//                         debugPrint("User ------->> $user");
//                       },
//                       textColor: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     height: height / 80,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButtons(
//                         textButtonName: "Already have an account?",
//                         fontSize: 18,
//                         color: const Color(0xbd8a8b7a),
//                         textOnPress: () {},
//                       ),
//                       TextButtons(
//                         textButtonName: "Login",
//                         fontSize: 18,
//                         color: const Color(0xFFBA5C3D),
//                         textOnPress: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const LoginPage()),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   phoneAuth() async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNumberController.text,
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException e) {},
//       codeSent: (String verificationId, int? resendToken) {},
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
//
//   creatUser() async {
//     try {
//       await firebaseAuth
//           .createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       )
//           .then((value) {
//         debugPrint("Value --> ${value.user}");
//         user = value.user;
//         user!.sendEmailVerification();
//         createUserData();
//       });
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         debugPrint('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         debugPrint('The account already exists for that email.');
//       } else if (e.code == 'strong-password') {
//         debugPrint('The Password provided is fully strong');
//       }
//     } catch (e) {
//       debugPrint("Error --->  $e");
//     }
//   }
//
//   createUserData() {
//     CollectionReference users = firebaseFirestore.collection('user');
//     users.doc(user!.uid).set(
//       {
//         'id': user!.uid,
//         'name': nameController.text,
//         'email': user!.email,
//         'number': phoneNumberController.text,
//       },
//     ).then((value) {
//       debugPrint("User added -------> $users ");
//       utils.showSnackBar(context, message: "SignUp Successfully, please verify Your Email.");
//       Navigator.pop(context);
//     }).catchError((error) {
//       debugPrint("Failed to add user : $error");
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking_system/res/common/app_button/main_button.dart';
import 'package:smart_parking_system/res/common/app_button/text_button.dart';
import 'package:smart_parking_system/res/common/app_textformfild.dart';
import 'package:smart_parking_system/res/constant/app_text.dart';
import 'package:smart_parking_system/utils/utils.dart';
import 'package:smart_parking_system/view/login_signup_screen/login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  bool isLoading = false;

  Utils utils = Utils();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController carNumberPlateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool password = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
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
                        SizedBox(height: height / 50),
                        AppText.Hello,
                        RichText(
                          text: const TextSpan(
                            text: "Welcome To ",
                            style: TextStyle(
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                              color: Color(0xFF040B14),
                            ),
                            children: [
                              TextSpan(
                                text: "Automate Park",
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22,
                                  color: Color(0xff2950e3),
                                ),
                              )
                            ],
                          ),
                        ),
                        Image.asset("assets/images/loginActivity/signIn.jpg"),
                        AppText.name,
                        AppTextFormField(
                          hintText: "Enter Your Name",
                          controllers: nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        AppText.email,
                        AppTextFormField(
                          validator: (value) => value!.isValidEmail() ? null : "Please Enter Correct E-mail",
                          hintText: "Eg. jamesburnes@gmail.com",
                          controllers: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: height / 60,
                        ),
                        AppText.phoneNumber,
                        AppTextFormField(
                          validator: (value) => value!.isValidMobile() ? null : "Please Enter Correct Phone Number",
                          hintText: "00000 00000",
                          controllers: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: height / 60,
                        ),
                        AppText.carNumberPlate,
                        AppTextFormField(
                          hintText: "GJ03 AY 1097",
                          controllers: carNumberPlateController,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: height / 60,
                        ),
                        AppText.gender,
                        AppTextFormField(
                          hintText: "Enter Your Gender",
                          controllers: genderController,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: height / 60,
                        ),
                        AppText.city,
                        AppTextFormField(
                          hintText: "Enter Your City",
                          controllers: cityController,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: height / 60,
                        ),
                        AppText.password,
                        AppTextFormField(
                          validator: (value) => value!.isValidPassword() ? null : "Please Enter Correct Password",
                          keyboardType: TextInputType.visiblePassword,
                          controllers: passwordController,
                          hintText: "Password",
                          textInputAction: TextInputAction.done,
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
                        SizedBox(
                          height: height / 25,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MainButton(
                            textName: "Sign Up",
                            backgroundColor: const Color(0xff2950e3),
                            mainOnPress: () {
                              createUser();
                              debugPrint("User ------->> $user");
                            },
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButtons(
                              textButtonName: "Already have an account?",
                              fontSize: 18,
                              color: const Color(0xbd8a8b7a),
                              textOnPress: () {},
                            ),
                            TextButtons(
                              textButtonName: "Login",
                              fontSize: 18,
                              color: const Color(0xff2950e3),
                              textOnPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                );
                              },
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

  createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // User successfully signed up
      user = userCredential.user;
      user!.sendEmailVerification();
      saveUserData();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint("Error --->  $e");
    }
  }

  void saveUserData() {
    CollectionReference users = firebaseFirestore.collection('user');
    users.doc(user!.uid).set({
      'name': nameController.text,
      'email': emailController.text,
      'phoneNumber': phoneNumberController.text,
      'carNumberPlate': carNumberPlateController.text,
      'gender': genderController.text,
      'city': cityController.text,
    }).then((value) {
      utils.showSnackBar(context, message: "Sign Up Successful, Login Your Account Here..");
      Navigator.pop(context);
    }).catchError((error) {
      debugPrint("Failed to add user: $error");
    });
  }
}
