
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Registration extends GetxController {
  signup(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("Congratulations", "Your account has been created",snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar(
            "Already Registered", "The account already exists for that email.",snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }
RxBool isVisible = true.obs;
  saveUser(String name, String email, String password) async {
    await FirebaseFirestore.instance.collection("Users").doc(name).set({
      "Name": name,
      "Email": email,
      "password": password,
    });
  }
}