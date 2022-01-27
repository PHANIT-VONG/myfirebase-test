import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/controllers/user_controller.dart';
import 'package:firebase_test/models/user_model.dart';
import 'package:firebase_test/services/database.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late Rx<User?> _user;
  User? get user => _user.value;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    super.onInit();
  }

  // @override
  // void onReady() {
  //   _user = Rx<User?>(_auth.currentUser);
  //   _user.bindStream(_auth.userChanges());
  //   ever(_user, _initialScreen);
  //   super.onReady();
  // }

  // void _initialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(LoginPage());
  //   } else {
  //     Get.offAll(MainPage(user: user));
  //   }
  // }

  void createUser(String name, String email, String password) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      // create a user in firestore
      UserModel _user = UserModel(
        id: _userCredential.user!.uid,
        name: name,
        email: email,
      );
      if (await Database().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().user =
          await Database().getUser(_userCredential.user!.uid);
    } catch (e) {
      Get.snackbar(
        'Error Login Account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      print('SignOut Error $e');
      Get.snackbar(
        'Error Sign Out  Account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
