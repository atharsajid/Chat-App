import 'package:chat_app/Screens/Account%20Detail/account_detail.dart';
import 'package:chat_app/Screens/Contact%20Detail/contact.dart';
import 'package:chat_app/Screens/Home%20Screen/controller.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20In/controller.dart';
import 'package:chat_app/Screens/Messages/controller.dart';
import 'package:chat_app/Screens/Messages/message.dart';
import 'package:chat_app/Theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final googlecontroller = Get.find<GoogleSignInController>();

  final groupcontroller = Get.put(ContactListController());
  final messagecontroller = Get.put(MessageController());
  int isSelected = 0;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Users')
      .doc("athersajid820@gmail.com")
      .collection("NewMessage")
      .snapshots();

  // @override
  // void initState() {
  //   super.initState();
  //   messagecontroller.getnewmessage(
  //     googlecontroller.email,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("images/1.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              margin: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Messages,",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
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
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Column(
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                Get.dialog(
                                  AlertDialog(
                                    title: Text("Delete Message"),
                                    content: Text("Are you sure to delete?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          document.reference.delete();
                                          Get.back();
                                        },
                                        child: Text("Confirm"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              onTap: () {
                                Get.to(
                                  Message(
                                    name: data["Name"],
                                    email: data["Email"],
                                    photUrl: data["PhotUrl"],
                                  ),
                                );
                                document.reference.update({"Bool": false});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data["PhotUrl"]),
                                    radius: 26,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data["Name"],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          data["Message"],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      data["Bool"]
                                          ? Icon(
                                              Icons.circle,
                                              color: Colors.green,
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                      Text(
                                        data["Time"],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 15,
                              indent: 10,
                              endIndent: 10,
                              color: Colors.black,
                            )
                          ],
                        );
                      }).toList());
                },
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

//PopUp menu Button
  PopupMenuButton<String> popup() {
    return PopupMenuButton<String>(
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: GestureDetector(
                onTap: () => Get.to(Contact()), child: Text("New Message")),
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
