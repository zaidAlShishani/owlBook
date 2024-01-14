
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:homepage/pages/auth.dart';

final DatabaseReference userRef=FirebaseDatabase.instance.ref().child("users");
final DatabaseReference bookRef=FirebaseDatabase.instance.ref().child("BookList");
final DatabaseReference wishlistRef = FirebaseDatabase.instance.ref().child("wishlist");
final FirebaseStorage firestore = FirebaseStorage.instance;

class FirebaseService{
  User? user = Auth().auth.currentUser;
Future<UserDetails?> getUserDetails(String useruid) async{
try{
   DatabaseEvent event= await userRef.child(useruid).once();
   if(event.snapshot.value !=null){
     Map<dynamic,dynamic> mp=event.snapshot.value as dynamic;
     return UserDetails.fromMap(mp as Map<dynamic,dynamic> );
   }else {
    return null;
   }
 
  } catch(e){
    print(e.toString());
  }
  return null;
}

    Future<List<BokkDetails>> getBokkDetails() async {
    DatabaseReference productsRef =
        FirebaseDatabase.instance.ref().child("BookList");
      

    try {
      DatabaseEvent event = await productsRef.once();

      if (event.snapshot.value != null) {
        print(event.snapshot.value.toString());

        List<BokkDetails> productList = [];
        Map<dynamic, dynamic> snapshotData = event.snapshot.value as dynamic;

        snapshotData.forEach((key, value) {
          productList.add(BokkDetails.fromMap(value as Map<dynamic, dynamic>));
        });

        print("BookList List: $productList");
        return productList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting product details: $e');
      return [];
    }
  }
}



class UserDetails{
  String email;
  String name;
  String password;
  String username;
  String photoUrl;
  UserDetails({
    required this.email,required this.name,required this.password,required this.username,required this.photoUrl});

 
 Map<dynamic,dynamic> toMap(){
  return {
   "email": email,
    "name":name,
    "password":password,
    "username":username,
    "photoUrl":photoUrl,
  };
 }
factory UserDetails.fromMap(Map<dynamic,dynamic> map){
  return UserDetails(email: map["email"], name: map["name"], password: map["password"], username: map["username"], photoUrl: map["photoUrl"]);
}
 
}


class BokkDetails{
  String title;
  String author;
  String description;
  String bookImage;
  BokkDetails({
    required this.title,required this.author,required this.description, required this.bookImage});
 
 Map<dynamic,dynamic> toMap(){
  return {
   "title": title,
    "author":author,
    "description":description,
    "bookImage":bookImage
  };
 }
factory BokkDetails.fromMap(Map<dynamic,dynamic> map){
  return BokkDetails(title: map["title"], author: map["author"], description: map["description"],bookImage: map["bookImage"]);
}
 
}