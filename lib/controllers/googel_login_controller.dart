import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginController extends GetxController {
  final _googleSignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  void login() async {
    googleAccount.value = await _googleSignin.signIn();
  }

  void logout() async {
    googleAccount.value = await _googleSignin.signOut();
  }
}
