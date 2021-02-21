import 'package:book_im/features/auth/bloc/auth_bloc.dart';
import 'package:book_im/features/auth/bloc/auth_events.dart';
import 'package:book_im/features/auth/bloc/auth_state.dart';
import 'package:book_im/features/auth/data/model/fb_profile.dart';
import 'package:book_im/features/auth/data/model/login_response.dart';
import 'package:book_im/features/auth/data/model/user.dart';
import 'package:book_im/features/auth/data/social_auth.dart';
import 'package:book_im/features/dashboard/dashboard.dart';
import 'package:book_im/features/reader/custom_reader.dart';
import 'package:book_im/features/reader/epub_custom_view.dart';
import 'package:book_im/utils/AssetStrings.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:book_im/utils/reusableWidgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //props

  AuthBloc _authBloc;

  //getters

  //header
  Widget get getHeader {
    double height = getScreenSize(context: context).height;
    return Container(
      padding: EdgeInsets.only(
        bottom: height * 0.03,
      ),
      alignment: Alignment.bottomCenter,
      color: AppColors.primaryColor,
      height: height * 0.3,
      child: Text(
        "BOOKiM",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget get getLoginCard {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          getSocialMediaButton(
            onTap: () {
/*
             print("taped");
             Navigator.push(context,MaterialPageRoute(builder: (context){return
               BookView();
             }));*/
              _authBloc.add(LoginWithFBEvent());
            },
            title: "LOGIN WITH FACEBOOK",
            icon: Icons.face,
            asset: AssetStrings.facebook,
          ),
          getSpacer(height: getScreenSize(context: context).height * 0.04),
          getSocialMediaButton(
              onTap: () {
                _authBloc.add(LoginWithGoogleEvent());
              },
              title: "LOGIN WITH GOOGLE",
              icon: Icons.face,
              asset: AssetStrings.google,
              isActive: true)
        ],
      ),
    );
  }

  //State methds
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_authBloc == null) {
      _authBloc = BlocProvider.of<AuthBloc>(context);
    }
  }

  Widget get getLoginView {
    return Column(
      children: [
        getHeader,
        getSpacer(height: getScreenSize(context: context).height * 0.06),
        getLoginCard,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        getLoginView,
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Offstage(
              offstage: !(state is LoginProcessingState),
              child: CustomLoader(isTransparent: false),
            );
          },
        ),
        BlocListener<AuthBloc, AuthState>(
            child: Container(
              height: 0,
              width: 0,
            ),
            listener: (context, state) async {
              if (state is AuthErrorState) {
                showAlert(
                    context: context,
                    titleText: "Error",
                    message: state?.message ?? "",
                    actionCallbacks: {"Ok": () {}});
              }

              if (state is LoginSuccessState) {
                await onLoginSuccess(response: state.loginResponse);
              }
              if (state is FetchFbProfileSuccessState) {}
            })
      ],
    ));
  }

  Widget getSocialMediaButton(
      {Function onTap,
      String title,
      IconData icon,
      String asset,
      isActive: false}) {
    Color activeColor = AppColors.primaryColor;
    Color disabledColor = Colors.white;
    return Material(
      color: isActive ? activeColor : disabledColor,
      elevation: 0.4,
      clipBehavior: Clip.hardEdge,
      shape: StadiumBorder(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              border: Border.all(color: AppColors.primaryColor, width: 2)),
          child: Row(
            children: [
              // Icon(icon),
              Image.asset(
                asset,
                height: 20,
                width: 20,
                color: isActive ? disabledColor : activeColor,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title ?? "",
                        style: TextStyle(
                          color: isActive ? disabledColor : activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  onLoginSuccess({LoginResponse response}) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return Dashboard();
    }), (Route<dynamic> route) => false);
  }
}
// {token: EAADRBPC6UioBAJc1vXtKR6mN1edORD78ykgMRnbrZBlHvjgWWEbljeRLzHZCMXaBkb1JQrswziAvZCDAvJXqq2MyPcBZARHcgEfFK9O1BEBwctzseiXmB8ngecmQJ9XTTjFfPOZA62pudKRRXMTbEQjyf7lpedAb7ZCb4omoyGzCYvJJF2ZCZAKiZCFCrnIXjmJijn7GoRaJGW62cVOSd4hLwhNwZBQXg3ulcZD, email: sahilbadhan0@gmail.com, userId: 1589251674612103, name: Sahil Badhan, phone: null, profile_pic: https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=1589251674612103&height=50&width=50&ext=1612496339&hash=AeRb8Ly1hmfDOM2QjFg}

// {token: null, email: sahilbadhan0@gmail.com, userId: 106182044660887287541, name: Sahil Badhan, phone: null, profile_pic: https://lh3.googleusercontent.com/a-/AOh14GgnQbhnIs1I1cs1BD-DoG0AqnJBLzwKMc7pFs-f=s96-c}
