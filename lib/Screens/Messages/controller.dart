import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageController extends GetxController {
  received(String message, String email, String email2) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("Message")
        .doc(email2)
        .collection("ChatRoom")
        .add({
      "Message": message,
      "Type": "received",
      "Time": DateTime.now(),
    });
  }

  send(String message, String email, String email2) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("Message")
        .doc(email2)
        .collection("ChatRoom")
        .add({
      "Message": message,
      "Type": "Send",
      "Time": DateTime.now(),
    });
  }

  dynamic userStream;
  getmessage(String email1, String email2) {
    userStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(email1)
        .collection("Message")
        .doc(email2)
        .collection("ChatRoom")
        .orderBy("Time", descending: true)
        .snapshots();
  }

  newMessage(
    String email,
    String email2,
    String message,
    String photourl,
    String name,
  ) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("NewMessage")
        .doc(email2)
        .set({
      "Message": message,
      "Type": "Received",
      "Time": DateFormat.jm().format(DateTime.now()),
      "PhotUrl": photourl,
      "Name": name,
      "Email": email,
      "Bool":true,
    });
  }

  dynamic getNewMessage;
  getnewmessage(String email1) {
    userStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(email1)
        .collection("NewMessage")
        .orderBy("Time", descending: true)
        .snapshots();
  }
}


  // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc("athersajid820@gmail.com")
  //     .collection("Message")
  //     .doc("makemoney3656@gmail.com")
  //     .collection("ChatRoom")
  //     .orderBy("Time", descending: true)
  //     .snapshots();