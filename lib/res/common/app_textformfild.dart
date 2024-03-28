import 'package:flutter/material.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(
      r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)",
    ).hasMatch(this);
  }
}

extension MobileValidator on String {
  bool isValidMobile() {
    return RegExp(
      r'(^(?:[+0]9)?[0-9]{10,12}$)',
    ).hasMatch(this);
  }
}

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controllers;
  final bool? obscuretext;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function? onFieldSunmitted;
  final IconButton? sufixIcon;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final GestureTapCallback? onTap;
  const AppTextFormField({
    Key? key,
    this.validator,
    this.controllers,
    this.hintText,
    this.keyboardType,
    this.onFieldSunmitted,
    this.sufixIcon,
    this.obscuretext,
    this.onTap,
    this.prefixIcon,
    this.textInputAction,
    TextEditingController? controller,
    InputDecoration? decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      textInputAction: textInputAction,
      validator: validator,
      obscureText: obscuretext ?? false,
      controller: controllers,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        focusColor: const Color(0xFF78AEE8),
        suffixIcon: sufixIcon,
        prefixIcon: prefixIcon,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xff0026c2)),
        ),
        fillColor: const Color(0xFFF1F1FC),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
