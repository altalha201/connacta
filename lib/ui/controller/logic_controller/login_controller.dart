import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../utils/pop_messages.dart';
import '../data_controller/user_preferences.dart';

class LoginController extends GetxController{
  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  Future<bool> login(String email, String password) async {
    var returnBool = false;
    _loginInProgress = true;
    update();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (credential.user != null) {
        Get.find<UserPreferences>().saveUserID(credential.user!.uid);
        returnBool = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        PopMessages.showAlertMessage(title: "Login Failed", message: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        PopMessages.showAlertMessage(title: "Login Failed", message: "Wrong password provided for that user.");
      }
    } catch (e) {
      log(e.toString());
    }
    _loginInProgress = false;
    update();
    return returnBool;
  }
}
