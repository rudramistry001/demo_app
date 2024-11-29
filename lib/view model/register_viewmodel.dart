// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:demo_app/authentication/login_screen.dart';
import 'package:demo_app/main.dart';
import 'package:demo_app/model/auth_model.dart';
import 'package:demo_app/repository/register_repository.dart';
import 'package:demo_app/screens/home_screen.dart';
import 'package:demo_app/utils/global_utils.dart';
import 'package:demo_app/utils/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterRepository registerRepository = RegisterRepository();

  Future registerUser(context, RegisterModel register) async {
    Loading loading = Loading(context);
    try {
      loading.startLoading();

      final response = await registerRepository.registerUser(register);

      if (response.statusCode == 200) {
        snackBarKey.currentState?.clearSnackBars();
        print("StatusCode for Register ------------");
        print(response.statusCode);

        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('message')) {
          snackBarKey.currentState?.showSnackBar(
            customSnackBar(
              message: jsonResponse['message'],
            ),
          );
        }
        snackBarKey.currentState?.showSnackBar(
            customSnackBar(message: 'User Created Successfully'));
        loading.stopLoading();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
        notifyListeners();
      } else {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey("error")) {
          snackBarKey.currentState?.showSnackBar(
            customSnackBar(
              message: jsonResponse["error"],
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception at CREATING NEW USER : $e");
      }
      snackBarKey.currentState
          ?.showSnackBar(customSnackBar(message: e.toString()));
      loading.stopLoading();
    }
  }

  Future loginUser(
      BuildContext context, RegisterModel loginUser, bool rememberMe) async {
    Loading loading = Loading(context);
    try {
      loading.startLoading();

      final response = await registerRepository.loginUser(loginUser);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final token = jsonResponse['token'];
        final id = jsonResponse['user']['id'];
        final fullname = jsonResponse['user']['fullname'];

        // Save the token and credentials if "Remember Me" is checked
        if (rememberMe) {
          await saveToken(token);
          await saveUserId(id);
          await saveUserId(fullname);
        }

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
        notifyListeners();
      } else {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey("error")) {
          snackBarKey.currentState?.showSnackBar(
            customSnackBar(
              message: jsonResponse["error"],
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception at Logging in The User : $e");
      }
      snackBarKey.currentState?.showSnackBar(
          customSnackBar(message: "Exception at Logging in The User : $e"));
    } finally {
      loading.stopLoading();
    }
  }

  Future<String> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print("TOKEN  SAVED _______");
    print(token);
    return token;
  }

  Future<String> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    print("USER ID SAVED----------");
    print(id);
    return id;
  }

  Future<String?> getUserAccessToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');

    return token;
  }

  Future<String?> getUserId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? id = localStorage.getString('id');
    print("USER ID IS GET USING SP");
    print(id);

    return id;
  }

//   Future logoutUser(context) async {
//     try {
//       // // final localStorage = await SharedPreferences.getInstance();
//       // await localStorage.clear();
//       // String? token = localStorage.getString('token');
//       // print("TOKEN _______");
//       // print(token);
//       // String? id = localStorage.getString('id');
//       // print("USER ID----------");
//       // print(id);
//       // Optionally, you can also navigate the user back to the login screen
//       // or perform any other necessary cleanup actions.
//       // For example:
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (route) => false);
//     } catch (e) {
//       // Handle any errors that might occur during logout process
//       if (kDebugMode) {
//         print("Exception at logging out the user: $e");
//       }
//       // You might want to notify the user or perform any other actions here
//     }
//   }

  Future<void> logoutUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved data
    print("ALL STORED CREDENTIALS DELETED");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  //firebase

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // User information (optional for tracking logged-in user in your app)
  User? _user;

  User? get user => _user;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        _user = userCredential.user;

        notifyListeners(); // Notify state changes

        // Navigate to Home Screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
