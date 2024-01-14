import 'package:flutter/material.dart';
import 'package:homepage/nav/myDrawer.dart';
import 'package:homepage/pages/MyLogin.dart';
import 'package:homepage/pages/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:homepage/pages/fireBaseDb.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var _signupFormKey  = GlobalKey<FormState>();
  String? errorMessage = '';
  

  FilePickerResult? img;

  Future<void> pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        img = result;
      });
    } else {
      print("No File Selected!");
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController photoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBF3E8),
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/Login");
          },
          child: Icon(Icons.arrow_back),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff86A789)),
          ),
        ),
        title: new Center(
            child: Text(
          "Signup page",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        )),
        backgroundColor: Color(0xff86A789),
      ),
      body: Form(
          key: _signupFormKey ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              img == null? IconButton(
                      onPressed: () {
                        pickImage();
                      },
                      icon: Icon(Icons.person))
                  : IconButton(
                      onPressed: () {
                        pickImage();
                      },
                      icon: Image(
                        image: MemoryImage(img!.files.first.bytes!),
                      ),
                    ),
              SizedBox(
                height: 15,
              ),img == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Please select a profile picture.',
                      style: TextStyle(
                        color: Colors.red[300],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 15,
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: fullNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: emailController,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Enter a valid Email";
                    }
                  }),
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.mail_rounded),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: usernameController,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Enter username";
                    }
                  }),
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.abc_sharp),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: ((value) {
                    if (value!.length < 8) {
                      return "Enter your password > 8";
                    }
                  }),
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.password_sharp),
                  ),
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                    onPressed: () {
                      if (_signupFormKey .currentState!.validate()) {
                        _handleSignUp();
                      }
                    },
                    child: Text(
                      "Sign up",
                      textScaleFactor: 1.5,
                      style: TextStyle(letterSpacing: 4),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffB2C8BA),
                      shape: StadiumBorder(),
                      fixedSize: Size(150, 40),
                    )),
              )
            ],
          )),
    );
  }
  
  final DatabaseReference userRef = FirebaseDatabase.instance.ref();
  Future<void> _handleSignUp() async {
    if (img == null) {
      setState(() {
        errorMessage = 'Please select a profile picture.';
      });
      return;
    }
    final Reference userpicref = FirebaseStorage.instance
        .ref()
        .child("userImage")
        .child("${DateTime.now().millisecondsSinceEpoch}.jpg");
    UploadTask ut = userpicref.putData(img!.files.first.bytes!);
    String imgurl = await (await ut).ref.getDownloadURL();
    try {
      await Auth()
          .signUpWithEmailAndPassword(
              email: emailController.text, 
              password: passwordController.text)
          .whenComplete(() {
        UserDetails user= UserDetails(
          email: emailController.text,
          name: fullNameController.text,
          password: passwordController.text,
          username: usernameController.text,
          photoUrl: imgurl,
          );
        print("Sign up successful");
        var userid = Auth().auth.currentUser!.uid;
        userRef.child("users").child(userid).set(user.toMap()).whenComplete(() {
          print("User added to database");
        });
         Navigator.pushNamed(context, "/home");
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
      errorMessage = e.message; 
    });
      print(e.toString());
    }
  }

}
