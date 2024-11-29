import 'package:demo_app/authentication/login_screen.dart';
import 'package:demo_app/model/auth_model.dart';
import 'package:demo_app/view%20model/register_viewmodel.dart';
import 'package:demo_app/widgets/custom_elevated_button.dart';
import 'package:demo_app/widgets/custom_textfield.dart';
import 'package:demo_app/widgets/custom_textfield_label.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late RegisterModel register;
  @override
  void initState() {
    super.initState();
    register = RegisterModel(); // Initialize register variable here
  }

  RegisterViewModel registerViewModel = RegisterViewModel();
  //passwword controller for email and password
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactnoController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    contactnoController.dispose();
    fullnameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(24.0.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                30.verticalSpace,
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 25.sp,
                        width: 25.sp,
                      ),
                      10.horizontalSpace,
                      Text(
                        "D Commerce",
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontFamily: "DancingScript",
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: "RobotoCondensed",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "to continue",
                    style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: "RobotoCondensed",
                    ),
                  ),
                ),
                10.verticalSpace,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Enter your personal details to sign up.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontFamily: "RobotoCondensed",
                    ),
                  ),
                ),
                20.verticalSpace,
                const CustomTextFieldLabel(
                  labelText: "Full Name*",
                  fontColor: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                CustomStyledTextField(
                  controller: fullnameController,
                  keyboardType: TextInputType.name,
                  hintText: "Ex: John Doe",
                  prefixIcon: const Icon(Icons.person),
                  validator: (val) =>
                      val != null && val.isNotEmpty && isValidEmail(val)
                          ? null
                          : 'Please enter a valid email address',
                ),
                20.verticalSpace,
                const CustomTextFieldLabel(
                  labelText: "Email*",
                  fontColor: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                CustomStyledTextField(
                  controller: emailController,
                  prefixIcon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
                  hintText: "someone@example.com",
                  validator: (val) =>
                      val != null && val.isNotEmpty && isValidEmail(val)
                          ? null
                          : 'Please enter a valid email address',
                ),
                20.verticalSpace,
                const CustomTextFieldLabel(
                  labelText: "Contact Number*",
                  fontColor: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                CustomStyledTextField(
                  controller: contactnoController,
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.emailAddress,
                  hintText: "your contact number",
                  validator: (val) =>
                      val != null && val.isNotEmpty && isValidEmail(val)
                          ? null
                          : 'Please enter a valid email address',
                ),
                20.verticalSpace,
                const CustomTextFieldLabel(
                  labelText: "Password*",
                  fontColor: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                CustomStyledTextField(
                  prefixIcon: const Icon(Icons.key),
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Password is Required Field',
                  obscureText: true,
                  hintText: "anything@123",
                  controller: passwordController,
                ),
                30.verticalSpace,
                CustomElevatedButtonWithIcon(
                    backgroundColor: Colors.black,
                    height: 50.0.sp,
                    width: 350.0.sp,
                    icon: Icons.how_to_reg,
                    text: "Register",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        register.fullname = fullnameController.text;
                        register.email = emailController.text;
                        register.contactNumber = contactnoController.text;
                        register.password = passwordController.text;

                        registerViewModel.registerUser(context, register).then(
                              (value) {},
                            );
                      }
                    }),
                ElevatedButton.icon(
                  onPressed: () async {
                    // Directly call the signInWithGoogle function
                    await registerViewModel.signInWithGoogle(context);
                  },
                  icon: const Icon(Icons.login), // Icon for the button
                  label:
                      const Text('Sign in with Google'), // Text for the button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set button color
                    foregroundColor: Colors.white, // Set text/icon color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "RobotoCondensed",
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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
