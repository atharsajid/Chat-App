import 'package:chat_app/Screens/Login%20Screen/Sign%20In/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDetail extends StatelessWidget {
  AccountDetail({Key? key}) : super(key: key);
  TextEditingController namecontroller = TextEditingController();
  final currentUserController = Get.find<Login>();
  final googleController = Get.find<GoogleSignInController>();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Column(
              children: [
                ListTile(
                  title: Text(data["Name"]),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ),
                ListTile(
                  title: Text(data["Email"]),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ),
                ListTile(
                  title: Text(data["PhotUrl"]),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ),
              ],
            );
          }).toList());
        },
      ),
    );
  }
}
