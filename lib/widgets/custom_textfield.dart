import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStyledTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;

  const CustomStyledTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconSize,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconSize,
    this.controller,
    this.keyboardType,
    this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.sp,
      width: 360.sp,
      child: TextFormField(
        // validator: validator ??
        //     (value) {
        //       if (value != null && value.isNotEmpty) {
        //         if (isValidEmail(value)) {
        //           return null;
        //         } else {
        //           return 'Please enter a valid email address';
        //         }
        //       } else {
        //         return 'Required Field';
        //       }
        //     },
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          fillColor: Colors.grey,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          prefixIcon: prefixIcon != null
              ? IconTheme(
                  data: IconThemeData(
                    color: prefixIconColor ?? Colors.grey,
                    size: prefixIconSize ?? 24.sp,
                  ),
                  child: prefixIcon!,
                )
              : null,
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: "RobotoCondensed",
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w200,
            fontSize: 18.sp,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: "RobotoCondensed",
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w200,
            fontSize: 18.sp,
          ),
          suffixIcon: suffixIcon != null
              ? IconTheme(
                  data: IconThemeData(
                    color: suffixIconColor ?? Colors.grey,
                    size: suffixIconSize ?? 24.sp,
                  ),
                  child: suffixIcon!,
                )
              : null,
        ),
      ),
    );
  }
}

bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}
