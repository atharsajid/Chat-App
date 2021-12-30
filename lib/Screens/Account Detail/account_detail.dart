import 'package:chat_app/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDetail extends StatelessWidget {
  final String name;
  final String email;
  final String photoUrl;
  AccountDetail({
    Key? key,
    required this.name,
    required this.email,
    required this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/3.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: primary,
          title: Text(
            "Contact Detail",
            style: TextStyle(color: white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              height: 50,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
              radius: 55,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 32,
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              email,
              style: TextStyle(
                fontSize: 22,
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
