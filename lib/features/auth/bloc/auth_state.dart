import 'package:book_im/features/auth/data/model/fb_profile.dart';
import 'package:book_im/features/auth/data/model/login_response.dart';
import 'package:book_im/features/auth/data/model/signUpResponse.dart';
import 'package:flutter/foundation.dart';

abstract class AuthState {}

class LoginInitialState extends AuthState {}

class LoginProcessingState extends AuthState {}

class LoginSuccessState extends AuthState {
  LoginResponse loginResponse;

  LoginSuccessState({@required this.loginResponse});
}


class SignUpProcessingState extends AuthState {
  SignUpProcessingState();
}

class AuthErrorState extends AuthState {
  String message;

  AuthErrorState({this.message});
}
class SignUpSuccessState extends AuthState {
  SignUpResponse response;

  SignUpSuccessState({this.response});
}
class FetchFbProfileSuccessState extends AuthState {
  FBProfile profile;

  FetchFbProfileSuccessState({this.profile});
}

class ForgotPwdSuccessState extends AuthState {
  SignUpResponse response;

  ForgotPwdSuccessState({this.response});
}
