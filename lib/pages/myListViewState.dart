import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homepage/Data/book_data.dart';
import 'package:homepage/nav/myDrawer.dart';
import 'package:homepage/Data/book_data.dart';
import 'package:homepage/pages/auth.dart';
import 'package:homepage/pages/fireBaseDb.dart';

class MyListView extends StatefulWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<BokkDetails>? book;


    Future<void> fetchBookData() async {
    try {
      List<BokkDetails>? ps = await FirebaseService().getBokkDetails();
      if (ps != null) {
        setState(() {
          book = ps;
        });
      } else {
        print("Product Data not Found not found");
      }
    } catch (e) {
      print(e.toString());
    }

  }
  @override
void initState() {
    // TODO: implement initState
    super.initState();
fetchBookData();
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        drawer:MyDrawer(),    
        appBar: AppBar(
        title: Center(
            child: Text(
          "OwlBooks",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        )),
        backgroundColor: Color(0xff86A789),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.alarm_add_rounded)),
        ],
      ),
      body:
      ListView.builder(
        itemCount: book!.length,
        itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Color(0xffEBF3E8),
                      content: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: MediaQuery.of(context).size.height - 32,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              book![index].bookImage,
                              width: 200,
                              height: 200,
                            ),
                            SizedBox(),
                            Text(
                              'Title: ${book![index].title}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Author: ${book![index].author}'),
                            SizedBox(height: 10),
                            Text('Description: ${book![index].description}'),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  leading: Image.network(
                    book![index].bookImage,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    "${book![index].title} by ${book![index].author}",
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    "${book![index].description}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
        }
        
      ),
    );
  }
}
