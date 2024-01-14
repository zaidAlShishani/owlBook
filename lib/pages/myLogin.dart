import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:homepage/nav/myDrawer.dart';
import 'package:homepage/pages/auth.dart';
import 'fireBaseDb.dart';




class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _loginFormKey  = GlobalKey<FormState>();
  String? errorMessage = '';
  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Umm! $errorMessage.',
      style: TextStyle(
        color: Colors.red[400],
      ),
    );
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Color(0xffEBF3E8),
      appBar: AppBar(
        title: new Center(
            child: Text(
          "Login page",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        )),
        backgroundColor: Color(0xff86A789),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _loginFormKey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: TextFormField(
                    controller: _controllerEmail,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: "Enter your username",
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: TextFormField(
                    obscureText: true,
                    controller: _controllerPassword,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      hintText: "Enter your password",
                      labelText: "password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    // Implement your forget password logic
                  },
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'A password reset email has been sent to your email address.',
                        ),
                      ));
                    },
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child:
                          Text('*Forgot Password', textAlign: TextAlign.left),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_loginFormKey .currentState!.validate()) {
                              _handleSignin();
                            }
                          },
                          child: const Text(
                            'Sign In',
                            textScaleFactor: 1.5,
                            style: TextStyle(letterSpacing: 4),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff86A789),
                            shape: StadiumBorder(),
                            fixedSize: Size(250, 50),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/Signup");
                          },
                          child: Text(
                            "Sign Up",
                            textScaleFactor: 1.5,
                            style: TextStyle(letterSpacing: 4),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff86A789),
                            shape: StadiumBorder(),
                            fixedSize: Size(250, 50),
                          ),
                        ),
                      ),               
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future<void> _handleSignin() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      print("Login Successful");
      Navigator.pushNamed(context, "/books");
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}

