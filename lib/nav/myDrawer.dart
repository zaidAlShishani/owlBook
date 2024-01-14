import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homepage/pages/auth.dart';
import 'package:homepage/pages/fireBaseDb.dart';
import 'package:homepage/pages/myFirstPage.dart';
import 'package:homepage/pages/myFirstPage.dart';
import 'package:homepage/pages/MyProfile.dart';
import 'package:homepage/pages/MyLogin.dart';



class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState(){
    super.initState();

  }
  Future fetchUser()async {
    print("-----------");
    UserDetails usr = FirebaseService().getUserDetails(Auth().auth.currentUser!.uid) as UserDetails;
     print("-----------2");
    print(usr);

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.green[200]),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:  SizedBox.fromSize(
                  size: Size.fromRadius(30),
                  child: CircleAvatar(
                    backgroundColor: Color(0xffB2C8BA),
                    radius: 40.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnPe1NTKMxzFm1pvMH2vy7N6VUKOe--2pwYI-_Ch11xLj99GJk0iaKs99eHKqqtTjLH4M&usqp=CAU",
                      ),
                      radius: 25.0,
                    ),
                  ),
                ),
                 // title: Text("${usr.username}", textScaleFactor: 1,),
                  //subtitle: Text("${usr.email}",textScaleFactor: 0.8,),
                ),
             ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, "/home");
                
              },
            ),
            lineThing(5),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MyProfile()),
                );
              },
            ),
            lineThing(5),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text("Logout"),
              onTap: () {
                Auth().auth.signOut();
                Navigator.pushNamed(context, "/Login");
              },
            ),
          ],
        ));

       
      
  
  }
}

Widget lineThing(double thicc) {
  return Divider(
    height: 10,
    color: Colors.grey,
  );
}
