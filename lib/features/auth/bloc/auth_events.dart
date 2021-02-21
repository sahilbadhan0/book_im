import 'package:book_im/features/auth/data/model/login_request.dart';
import 'package:book_im/features/auth/data/model/signup_request.dart';
import 'package:flutter/foundation.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final LoginRequest loginRequest;

  const LoginEvent({@required this.loginRequest});

  @override
  List<Object> get props => [loginRequest];
}

class signupEvent extends AuthEvent {
  final SignUpRequest request;

  signupEvent({this.request});
}

class LoginWithFBEvent extends AuthEvent {
  LoginWithFBEvent();
}

class LoginWithGoogleEvent extends AuthEvent {
  LoginWithGoogleEvent();
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({this.email});
}
