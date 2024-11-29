// ignore_for_file: avoid_print

import 'dart:async';

import 'package:demo_app/constants/urls.dart';
import 'package:demo_app/model/auth_model.dart';
import 'package:demo_app/services/base%20service/base_service.dart';

class RegisterServices extends BaseApiProvider {
  Future<dynamic> registerUser(RegisterModel registerModel) async {
    var body = registerModel.toJson();

    try {
      final response = await postRequest(
          Uri.parse(UrlConstant.uatUrl + UrlConstant.register), body);
      // You can handle the response here according to your requirements
      return response;
    } catch (e) {
      // Handle errors such as network issues or server errors
      print('Error in registering the user: $e');
      rethrow; // Rethrow the error to be handled at the caller level if needed
    }
  }

  Future<dynamic> loginUser(RegisterModel loginUser) async {
    var body = loginUser.toJson();

    try {
      final response = await postRequest(
          Uri.parse(UrlConstant.uatUrl + UrlConstant.login), body);
      // You can handle the response here according to your requirements
      return response;
    } catch (e) {
      // Handle errors such as network issues or server errors
      print('Error in Logging in the user: $e');
      rethrow; // Rethrow the error to be handled at the caller level if needed
    }
  }
}
