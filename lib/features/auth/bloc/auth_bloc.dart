import 'package:book_im/features/auth/bloc/auth_events.dart';
import 'package:book_im/features/auth/bloc/auth_state.dart';
import 'package:book_im/features/auth/data/auth_repository.dart';
import 'package:book_im/features/auth/data/model/fb_profile.dart';
import 'package:book_im/features/auth/data/model/googleSignInResponse.dart';
import 'package:book_im/features/auth/data/model/login_request.dart';
import 'package:book_im/features/auth/data/model/login_response.dart';
import 'package:book_im/features/auth/data/model/signUpResponse.dart';
import 'package:book_im/features/auth/data/social_auth.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_messages.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  SocialAuth _socialAuth = SocialAuth();

  AuthBloc({this.repository}) : super(LoginInitialState());

  @override
  AuthState get initialState => LoginInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield LoginProcessingState();
      try {
        bool isConnected =
            await checkInternetForPostMethod(onSuccess: () {}, onFail: () {});
        if (!isConnected) {
          yield AuthErrorState(message: AppMessages.noInternet);
          return;
        }

        LoginResponse response =
            await repository.login(request: event?.loginRequest);
        yield LoginSuccessState(loginResponse: response);
      } catch (e) {
        print("Exception in login ${e}");
        yield AuthErrorState(message: e.toString());
      }
    }

    //login with fB
    if (event is LoginWithFBEvent) {
      try {
        bool isConnected =
            await checkInternetForPostMethod(onSuccess: () {}, onFail: () {});
        if (!isConnected) {
          yield AuthErrorState(message: AppMessages.noInternet);
          return;
        }

        var x = await _socialAuth.loginWithFacebook();
        yield LoginProcessingState();
        FBProfile response = await repository.getFBUserDetail(token: x.token);

        LoginRequest request = LoginRequest(
          token: x.token,
          profilePic: response.picture?.data?.url,
          userId: response.id,
          name: response?.name,
          email: response?.email,
          phone: response?.phone,
        );

        LoginResponse loginResponse = await repository.login(request: request);
        yield LoginSuccessState(loginResponse: loginResponse);
      } catch (e, st) {
        print("Exception in login ${e}${st}");
        yield AuthErrorState(message: e.toString());
      }
    }

    //login with Google
    if (event is LoginWithGoogleEvent) {
      try {
        bool isConnected =
            await checkInternetForPostMethod(onSuccess: () {}, onFail: () {});
        if (!isConnected) {
          yield AuthErrorState(message: AppMessages.noInternet);
          return;
        }

        GoogleSignInData data = await _socialAuth.loginWithGoogle();

        LoginRequest request = LoginRequest(
          profilePic: data.googleSignInAccount.photoUrl,
          userId: data.googleSignInAccount.id,
          name: data.googleSignInAccount.displayName,
          email: data.googleSignInAccount.email,
          token: data?.googleSignInAuthentication?.accessToken,
          // phone: data
        );
        yield LoginProcessingState();
        LoginResponse loginResponse = await repository.login(request: request);
        yield LoginSuccessState(loginResponse: loginResponse);

        yield LoginSuccessState(loginResponse: loginResponse);
      } catch (e) {
        print("Exception in login ${e}");
        yield AuthErrorState(message: e.toString());
      }
    }
    //Signup up
    if (event is signupEvent) {
      yield SignUpProcessingState();

      try {
        bool isConnected =
            await checkInternetForPostMethod(onSuccess: () {}, onFail: () {});
        if (!isConnected) {
          yield AuthErrorState(message: AppMessages.noInternet);
          return;
        }
        SignUpResponse response =
            await repository.signUp(request: event?.request);
        yield SignUpSuccessState(response: response);
      } catch (e) {
        print("Exception in login ${e}");
        yield AuthErrorState(message: e.toString());
      }
    } //Forgot password  up
    if (event is ForgotPasswordEvent) {
      yield LoginProcessingState();

      try {
        bool isConnected =
            await checkInternetForPostMethod(onSuccess: () {}, onFail: () {});
        if (!isConnected) {
          yield AuthErrorState(message: AppMessages.noInternet);
          return;
        }
        var response = await repository.forgotPwd(email: event?.email);
        yield ForgotPwdSuccessState();
      } catch (e) {
        print("Exception in login ${e}");
        yield AuthErrorState(message: e.toString());
      }
    }
  }
}
