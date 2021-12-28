import 'package:chat_app/Components/components.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20In/controller.dart';
import 'package:chat_app/Screens/Messages/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Message extends StatefulWidget {
  final String name;
  Message({Key? key, required this.name}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final googlecontroller = Get.find<GoogleSignInController>();

  TextEditingController msgcontroller = TextEditingController();

  final messagecontroller = Get.put(MessageController());

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
            widget.name,
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
        body: Column(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListView.builder(
               physics: NeverScrollableScrollPhysics(),
                    
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            width: 150,
                           
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                            ),
                            child: Text(
                              "${list[index]}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          );
                        })
                  ],
                ),
              ),
           
            messageField(context)
          ],
        ),
      ),
    );
  }

//MessageField
  Row messageField(BuildContext context) {
    return Row(
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
              list.add(msgcontroller.text);
              msgcontroller.clear();
            });
          },
          child: Icon(Icons.send),
        ),
      ],
    );
  }

  //PopMenu Item
  PopupMenuButton<String> popup() {
    return PopupMenuButton<String>(
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text("View Contact"),
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

var list = [];
