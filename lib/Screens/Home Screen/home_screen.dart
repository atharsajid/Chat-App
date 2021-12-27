import 'package:chat_app/Components/components.dart';
import 'package:chat_app/Screens/Account%20Detail/account_detail.dart';
import 'package:chat_app/Screens/Home%20Screen/controller.dart';
import 'package:chat_app/Screens/Login%20Screen/Sign%20In/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                        onPressed: () {
                          Get.to(AccountDetail());
                        },
                        icon: Icon(
                          Icons.search,
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(googlecontroller.photoUrl),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // categoryList(),
                  StreamBuilder<QuerySnapshot>(
                    stream: _usersStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Container(
                                margin: EdgeInsets.only(left: 10),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(data["PhotUrl"]),
                                  radius: 25,
                                ),
                              );
                            }).toList()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Text(""),
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.message,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

//groupList

  Container categoryList() {
    return Container(
      height: 35,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: groupcontroller.groupList.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                isSelected = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              width: 130,
              height: 35,
              decoration: BoxDecoration(
                color:
                    isSelected == index ? white : Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  groupcontroller.groupList[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected == index ? Colors.black : white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
