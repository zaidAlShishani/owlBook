import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homepage/nav/myDrawer.dart';
import 'package:homepage/pages/auth.dart';
import 'package:homepage/pages/fireBaseDb.dart';



class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  UserDetails? user;

  Future<void> fetchUserData() async {
    String userid = Auth().auth.currentUser!.uid;
    UserDetails? usr = await FirebaseService().getUserDetails(userid);
    if (usr != null) {
      setState(() {
        user = usr;
      });
    } else {
      print("User not Available!");
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchUserData();
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Color(0xffEBF3E8),
      appBar: AppBar(
        title: new Center(
            child: Text(
          "Profile page",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        )),
        backgroundColor: Color(0xff86A789),
        actions: [
            IconButton(onPressed:(){}, icon: Icon(Icons.alarm_add_rounded)),
          ],
      ),
      body: user == null
          ? Text("Data not Found!")
          : Center(
            child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xffB2C8BA),
                    radius: 40.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user!.photoUrl),
                      radius: 70,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("The email is: ${user!.email}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2),
                  SizedBox(
                    height: 10,
                  ),                
                  Divider(
                   height: 10,
                   thickness: 2,
                  color: Color(0xffB2C8BA),
                  ),
                  Text("The username is: ${user!.username}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2),                                 
                  Divider(
                   height: 10,
                   thickness: 2,
                  color: Color(0xffB2C8BA),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "The name is: ${user!.name}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2,
                  ),
                  //_signOutButton(),
                ],
              ),
          ),
    );
  }
}