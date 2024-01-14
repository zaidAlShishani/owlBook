import 'package:flutter/material.dart';
import 'package:homepage/pages/myFirstPage.dart';
import 'package:homepage/pages/MyLogin.dart';
import 'package:homepage/pages/MyProfile.dart';
import 'package:homepage/pages/myListViewState.dart';
import 'package:homepage/pages/signup.dart';
import 'package:homepage/nav/myDrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Home",
        initialRoute: "/home",        
        routes: <String, WidgetBuilder>{
          "/home": (context) {return MyFirstPage();},
          "/books": (context) {return MyListView();},
          "/Signup": (context) {return Signup();},
          "/Login": (context) {return MyLogin();},
          "/Profile": (context) {return MyProfile();},
        }
      );
  }
}

