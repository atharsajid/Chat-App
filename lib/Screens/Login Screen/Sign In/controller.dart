
import 'package:chat_app/Screens/Home%20Screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';


class Login extends GetxController {
  signin(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.off(HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Get.snackbar(
          "No User Found",
          "No user found for that email.",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        return Get.snackbar(
          "Wrong Password",
          "Wrong password provided for that user.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  RxBool isVisible = true.obs;
}