import 'package:book_im/features/auth/data/model/googleSignInResponse.dart';
import 'package:book_im/network/apiError.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuth {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  //login
  Future<FacebookAccessToken> loginWithFacebook() async {
    final FacebookLoginResult result =
        await facebookSignIn.logIn(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print("login succes --> ${accessToken?.toMap()}");
        return accessToken;

        break;
      case FacebookLoginStatus.error:
        throw (ApiException(
            message: 'Something went wrong with the login process.\n'
                'Here\'s the error Facebook gave us: ${result.errorMessage}'));
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw (ApiException(message: "Login cancelled by the user"));

        break;
    }
  }

  //login with google
  Future<GoogleSignInData> loginWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      print("google login ---> ${googleSignInAccount?.toString()}");

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      print("totken ---> ${googleSignInAuthentication?.accessToken}\n id ${googleSignInAuthentication?.idToken}");
/*      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );*/
      GoogleSignInData data = GoogleSignInData(
        googleSignInAuthentication:googleSignInAuthentication,
        googleSignInAccount:googleSignInAccount
      );

      return data;
    } catch (error) {
      throw (ApiException(
          message: 'Something went wrong with the login process.\n'));
    }
  }
  //login with google
}
