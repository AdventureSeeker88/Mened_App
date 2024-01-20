import 'package:cloud_firestore/cloud_firestore.dart';

import 'database.dart';

String username = "";
Future<String> userNameGet(String userid) async {
  var collection = FirebaseFirestore.instance.collection(Database.auth);
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    username = data['name'];
  } else {}
  return username;
}

String email = "";
Future<String> email_get(String userid) async {
  var collection = FirebaseFirestore.instance.collection(Database.auth);
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    email = data['email'];
  } else {}
  return email;
}

String user_image = "";
Future<String> userImageGet(String userid) async {
  var collection = FirebaseFirestore.instance.collection(Database.auth);
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    user_image = data['image'];
  } else {}
  return user_image;
}
