import 'package:chat_app/Components/components.dart';
import 'package:chat_app/Screens/Account%20Detail/account_detail.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20In/controller.dart';
import 'package:chat_app/Screens/Messages/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Message extends StatefulWidget {
  final String name;
  final String email;
  final String photUrl;

  Message(
      {Key? key,
      required this.name,
      required this.email,
      required this.photUrl})
      : super(key: key);
  @override
  State<Message> createState() => _MessageState();
}

@override
class _MessageState extends State<Message> {
  final googlecontroller = Get.find<GoogleSignInController>();
  TextEditingController msgcontroller = TextEditingController();
  final messagecontroller = Get.put(MessageController());

  @override
  void initState() {
    super.initState();
    messagecontroller.getmessage(googlecontroller.email, widget.email);
  }

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
        appBar: appbar(),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: messagecontroller.userStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return GestureDetector(
                          onLongPress: () {
                            Get.dialog(AlertDialog(
                              title: Text("Delete"),
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
                            ));
                          },
                          child: Container(
                            margin: data["Type"] == "Send"
                                ? EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.3,
                                    top: 10,
                                    right: 10)
                                : EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width * 0.3,
                                    top: 10,
                                    left: 10),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: data["Type"] == "Send"
                                  ? white
                                  : Colors.blue.shade400,
                              borderRadius: data["Type"] == "Send"
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      bottomLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                    )
                                  : const BorderRadius.only(
                                      bottomRight: Radius.circular(32),
                                      bottomLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                    ),
                            ),
                            child: Text(
                              data["Message"],
                              style: TextStyle(
                                color: data["Type"] == "Send"
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        );
                      }).toList());
                },
              ),
            ),
            messageField(context)
          ],
        ),
      ),
    );
  }

//appbar
  AppBar appbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: primary,
      title: GestureDetector(
        onTap: () => Get.to(
          AccountDetail(
              name: widget.name, email: widget.email, photoUrl: widget.photUrl),
        ),
        child: Text(
          widget.name,
          style: TextStyle(color: white),
        ),
      ),
      actions: [
        GestureDetector(
            onTap: () {
              Get.to(AccountDetail(
                  name: widget.name,
                  email: widget.email,
                  photoUrl: widget.photUrl));
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.photUrl),
            )),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.call),
        ),
        popup(),
      ],
    );
  }

//MessageField
  Container messageField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: msgcontroller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Write your Message",
                  filled: true,
                  fillColor: Colors.blue.withOpacity(0.3),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),
              )),
          FloatingActionButton(
            backgroundColor: primary,
            onPressed: () {
              setState(() {
                if (msgcontroller.text.isNotEmpty) {
                  messagecontroller.send(
                      msgcontroller.text, googlecontroller.email, widget.email);
                  messagecontroller.received(
                      msgcontroller.text, widget.email, googlecontroller.email);
                  messagecontroller.newMessage(
                    widget.email,
                    googlecontroller.email,
                    msgcontroller.text,
                    widget.photUrl,
                    widget.name,
                  );
                  msgcontroller.clear();
                } else {
                  print("Empty");
                }
              });
            },
            child: Icon(Icons.send),
          ),
        ],
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
            child: GestureDetector(
                onTap: () {
                  Get.to(AccountDetail(
                      name: widget.name,
                      email: widget.email,
                      photoUrl: widget.photUrl));
                },
                child: Text("View Contact")),
          ),
          PopupMenuItem(
            child: Text("Block"),
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
