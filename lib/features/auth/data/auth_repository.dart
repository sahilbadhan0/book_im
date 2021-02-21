
import 'dart:convert';

import 'package:book_im/features/auth/data/model/fb_profile.dart';
import 'package:book_im/features/auth/data/model/forgot_password_request.dart';
import 'package:book_im/features/auth/data/model/login_request.dart';
import 'package:book_im/features/auth/data/model/login_response.dart';
import 'package:book_im/features/auth/data/model/signup_request.dart';
import 'package:book_im/features/auth/data/model/signUpResponse.dart';
import 'package:book_im/features/auth/data/model/forgot_response.dart';


import 'package:book_im/network/apiError.dart';
import 'package:book_im/network/api_urls.dart';
import 'package:book_im/network/api_handler.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthRepository {

  Future<LoginResponse> login({@required LoginRequest request}) async {
    try {
      print("requset${request?.toJson()}");
/*      var response = await RestClient.dio.post(
          ApiURL.login, data: request?.toJson());
      if (response.statusCode == 200) {
        var data = response.data;
        LoginResponse loginResponse = LoginResponse.fromJson(data);
        print("Response got ${loginResponse?.toJson()}");
        return loginResponse;


      }else {
        throw Exception();
      }*/
      return LoginResponse();
    }  catch (e,st) {
      print("Exception $e,$st");

      if(e is DioError && e.type== DioErrorType.RESPONSE){
        print("got api Eorror");
        var data = e.response.data;
        throw ApiException(message:data['message']);

      }else{
        throw e;
      }

    }
  }

  // signup
  Future<SignUpResponse> signUp({@required SignUpRequest request}) async {
    try {
      var response =
      await RestClient.dio.post(ApiURL.signUp, data: request.toJson());
      if (response.statusCode == 200) {
        var data = response.data;
        SignUpResponse users = SignUpResponse.fromJson(data);
        return users;
      } else {
        throw Exception();
      }
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.RESPONSE) {
        var data = e.response.data;
        throw ApiException(message: data['message']);
      } else {
        throw e;
      }
    }
  }


  Future<ForgotPwdResponse> forgotPwd({@required String email }) async {
    try {
      var body={
        "kind": "forgotpass",
        "email": email??""
      };
      var response = await RestClient.dio.post(
          ApiURL.forgotPwd, data: body);
      if (response.statusCode == 200) {
        var data = response.data;
//        ForgotPwdResponse _response = ForgotPwdResponse.fromJson(data);
//        print("Response got ${_response?.toJson()}");
        return ForgotPwdResponse();
      }else {
        throw Exception();
      }
    }  catch (e,st) {
      print("Exception $e,$st");

      if(e is DioError && e.type== DioErrorType.RESPONSE){
        print("got api Eorror");
        var data = e.response.data;
        throw ApiException(message:data['message']);

      }else{
        throw e;
      }

    }
  }

  //mew

  // signup
  Future<FBProfile> getFBUserDetail({@required token}) async {
    try {
      var graphResponse = await RestClient.dio.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${token}');
      FBProfile profile = FBProfile.fromJson(jsonDecode(graphResponse?.data));
      return profile;

    } catch (e,st) {
      print("$e,$st");
      if (e is DioError && e.type == DioErrorType.RESPONSE) {
        var data = e.response.data;
        throw ApiException(message: data['message']);
      } else {
        throw e;
      }
    }
  }
}