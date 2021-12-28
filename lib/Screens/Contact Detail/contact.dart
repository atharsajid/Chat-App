import 'package:chat_app/Components/components.dart';
import 'package:chat_app/Screens/Messages/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contact extends StatelessWidget {
  Contact({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Users').snapshots();
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: primary,
          title: Text(
            "Contact",
            style: TextStyle(color: white),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.call),
            ),
            popup(),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        Message(
                          name: data["Name"],
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data["PhotUrl"]),
                        radius: 18,
                      ),
                      title: Text(
                        data["Name"],
                        style: TextStyle(
                          color: white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                }).toList());
          },
        ),
      ),
    );
  }

  //PopMenu Item
  PopupMenuButton<String> popup() {
    return PopupMenuButton<String>(
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text("Add Contact"),
          ),
          PopupMenuItem(
            child: Text("Select all"),
          ),
          PopupMenuItem(
            child: Text("Setting"),
          ),
          PopupMenuItem(
            child: Text("Profile"),
          ),
          PopupMenuItem(
            child: TextButton(
              onPressed: () {},
              child: Text("Log out"),
            ),
          ),
        ];
      },
    );
  }
}
