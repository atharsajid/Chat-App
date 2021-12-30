import 'package:chat_app/Components/components.dart';
import 'package:chat_app/Screens/Account%20Detail/account_detail.dart';
import 'package:chat_app/Screens/Contact%20Detail/contact.dart';
import 'package:chat_app/Screens/Home%20Screen/controller.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20In/controller.dart';
import 'package:chat_app/Screens/Messages/message.dart';
import 'package:chat_app/Theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final googlecontroller = Get.find<GoogleSignInController>();

  final groupcontroller = Get.put(ContactListController());
  int isSelected = 0;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/2.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Messages,",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(AccountDetail(
                            name: googlecontroller.name,
                            email: googlecontroller.email,
                            photoUrl: googlecontroller.photoUrl)),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(googlecontroller.photoUrl),
                        ),
                      ),
                      popup(),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height:55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                     
                        //   borderRadius: BorderRadius.circular(24),
                        //   color:white,
                        //   boxShadow:[
                        //     BoxShadow(

                        //       blurRadius: 8,
                        //       spreadRadius: 3,
                        //       color: Colors.grey.withOpacity(0.3)
                        //     )
                        //   ]
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(googlecontroller.photoUrl),
                          radius: 28,
                        ),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              googlecontroller.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "New Message",
                              style: TextStyle(
                                fontSize: 16,
                                color: black,
                              
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon( Icons.circle,color: Colors.green,),
                            Text(DateFormat.jm().format(DateTime.now()),style: TextStyle(color: Colors.black),),
                          ],
                        )
                      ],
                    ),
                  ),
                  
                  Divider(height: 15,indent: 10,endIndent: 10,color: Colors.black,)
                ],
              ),
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(Contact());
          },
          child: Icon(
            Icons.message,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
//Status bar
  // StreamBuilder<QuerySnapshot<Object?>> status() {
  //   return StreamBuilder<QuerySnapshot>(
  //                 stream: _usersStream,
  //                 builder: (BuildContext context,
  //                     AsyncSnapshot<QuerySnapshot> snapshot) {
  //                   if (snapshot.hasError) {
  //                     return Text('Something went wrong');
  //                   }

  //                   if (snapshot.connectionState == ConnectionState.waiting) {
  //                     return Text("Loading");
  //                   }

  //                   return Container(
  //                     alignment: Alignment.centerLeft,
  //                     height: 50,
  //                     child: ListView(
  //                         physics: BouncingScrollPhysics(),
  //                         shrinkWrap: true,
  //                         scrollDirection: Axis.horizontal,
  //                         children: snapshot.data!.docs
  //                             .map((DocumentSnapshot document) {
  //                           Map<String, dynamic> data =
  //                               document.data()! as Map<String, dynamic>;
  //                           return GestureDetector(
  //                             onTap: () {
  //                               Get.to(
  //                                 Message(
  //                                   name: data["Name"],
  //                                 ),
  //                               );
  //                             },
  //                             child: Container(
  //                               margin: EdgeInsets.only(left: 10),
  //                               child: CircleAvatar(
  //                                 backgroundImage:
  //                                     NetworkImage(data["PhotUrl"]),
  //                                 radius: 25,
  //                               ),
  //                             ),
  //                           );
  //                         }).toList()),
  //                   );
  //                 },
  //               );
  // }

//PopUp menu Button
  PopupMenuButton<String> popup() {
    return PopupMenuButton<String>(
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: GestureDetector(
              onTap: () => Get.to(Contact()),
              child: Text("New Message")),
          ),
          PopupMenuItem(
            child: Text("New Group"),
          ),
          PopupMenuItem(
            child: Text("Setting"),
          ),
          PopupMenuItem(
            child: Text("Profile"),
          ),
          PopupMenuItem(
            child: TextButton(
              onPressed: () {
                googlecontroller.logout();
              },
              child: Text("Log out"),
            ),
          ),
        ];
      },
    );
  }
}
