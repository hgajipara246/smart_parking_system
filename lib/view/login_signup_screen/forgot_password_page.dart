import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking_system/res/common/app_button/main_button.dart';
import 'package:smart_parking_system/res/common/app_textformfild.dart';
import 'package:smart_parking_system/res/constant/app_text.dart';
import 'package:smart_parking_system/utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Utils _utils = Utils();

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );

        _utils.showSnackBar(
          context,
          message: "Password reset email sent, please check your email.",
        );
      } catch (error) {
        _utils.showSnackBar(
          context,
          message: "Failed to send password reset email. Please try again later.",
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("assets/images/profile/forgot.png"),
                AppText.email,
                SizedBox(
                  height: 7,
                ),
                AppTextFormField(
                  validator: (value) => value!.isValidEmail() ? null : "Please Enter Correct E-mail",
                  hintText: "Eg. jamesburnes@gmail.com",
                  controllers: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 20.0),
                MainButton(
                  textName: 'Reset Password',
                  mainOnPress: _resetPassword,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  isLoading: _isLoading,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    AppText.note,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
