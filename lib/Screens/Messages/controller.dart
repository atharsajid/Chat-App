import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  received(String message, String email,String email2) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email).collection("Message").doc(email2)
        .collection("ChatRoom")
        .add({
      "Message": message,
      "Type": "received",
      "Time": DateTime.now(),
    });
  }

  send(String message, String email,String email2) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("Message").doc(email2).collection("ChatRoom")
        .add({
      "Message": message,
      "Type": "Send",
      "Time": DateTime.now(),
    });
  }
}


class InitState extends StatefulWidget {
  const InitState({ Key? key }) : super(key: key);

  @override
  _InitStateState createState() => _InitStateState();
}

class _InitStateState extends State<InitState> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}