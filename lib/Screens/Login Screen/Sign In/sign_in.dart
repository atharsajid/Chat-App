import 'package:chat_app/Components/components.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20In/controller.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20Up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final logincontroller = Get.put(Login());
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
              height: 100,
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
              height: 100,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              height: 50,
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
              height: 55,
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
              height: 20,
            ),
            GetBuilder<Login>(builder: (controller) {
              return OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
