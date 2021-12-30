import 'package:chat_app/Screens/Account%20Detail/account_detail.dart';
import 'package:chat_app/Screens/Home%20Screen/home_screen.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20In/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class Login extends GetxController {
  var currentUserEmail;
  var user;
  signin(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      currentUserEmail = FirebaseAuth.instance.currentUser!.email;
      Stream _user = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserEmail)
          .snapshots();
      user = _user;

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

//Google sign in controller

class GoogleSignInController extends GetxController {
  var name;
  var email;
  var photoUrl;

  var googleSign = GoogleSignIn();
  var googleaccount = Rx<GoogleSignInAccount?>(null);
  login() async {
    googleaccount.value = await googleSign.signIn();
    name = googleaccount.value!.displayName;
    email = googleaccount.value!.email;
    photoUrl = googleaccount.value!.photoUrl;
    Get.snackbar("Congratulations", "Your Account has been created",
        snackPosition: SnackPosition.BOTTOM);
    saveUser();
    users();
    Get.off(HomeScreen());
  }

  logout() async {
    googleaccount.value = await googleSign.signOut();
    Get.off(SignIn());
  }

  saveUser() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("Data")
        .doc("Profile")
        .set({
      "Name": name,
      "Email": email,
      "PhotUrl": photoUrl,
    });
  }

  users() async {
    await FirebaseFirestore.instance.collection("Users").doc(email).set({
      "Name": name,
      "Email": email,
      "PhotUrl": photoUrl,
    });
  }
}
