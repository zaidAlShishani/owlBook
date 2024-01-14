import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homepage/nav/myDrawer.dart';
import 'package:homepage/pages/myListViewState.dart';
import 'package:homepage/pages/myLogin.dart';

class MyFirstPage extends StatelessWidget {
  const MyFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:MyDrawer(),
      backgroundColor: Color(0xffEBF3E8),
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return MyListView();
            } else {
              return MyLogin();
            }
          })),
    );
  }
}
