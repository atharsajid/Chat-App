import 'package:chat_app/Components/components.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20In/controller.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20Up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final logincontroller = Get.put(Login());
  final googleCont = Get.put(GoogleSignInController());
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/2.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: double.infinity,
            ),
            Image.asset(
              "images/1.png",
              height: 85,
              color: white,
            ),
            Text(
              appname,
              style: TextStyle(
                color: white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              slogan,
              style: TextStyle(
                color: primary,
                fontSize: 18,
                letterSpacing: 4,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              height: 45,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: white, fontSize: 18),
                controller: emailcontroller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    label: Text("Email"),
                    hintText: "abc@gmail.com"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              height: 45,
              child: Obx(() {
                return TextField(
                  style: TextStyle(color: white, fontSize: 18),
                  controller: passcontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    label: Text("Password"),
                    hintText: "Enter your Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        logincontroller.isVisible.toggle();
                      },
                      icon: Icon(
                        logincontroller.isVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: logincontroller.isVisible.value,
                );
              }),
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<Login>(builder: (controller) {
              return OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  backgroundColor: primary,
                  side: BorderSide(color: Colors.transparent, width: 2),
                ),
                onPressed: () {
                  controller.signin(emailcontroller.text, passcontroller.text);
                  emailcontroller.clear();
                  passcontroller.clear();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 28,
                ),
                label: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(SignUp());
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: primary,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  color: Colors.white,
                  width: 75,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                ),
                Text(
                  "OR",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 1,
                  color: Colors.white,
                  width: 75,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "Login with Google",
              style: TextStyle(
                color: white,
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                // Get.to(HomeScreen());

                googleCont.login();
                if (googleCont.googleaccount.value == null) {
                  Get.dialog(Center(
                    child: CircularProgressIndicator(),
                  ));
                } else {}
              },
              child: Image.asset(
                "images/google.png",
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
