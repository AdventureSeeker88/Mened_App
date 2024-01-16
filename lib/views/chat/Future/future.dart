import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

String user_name = "";
Future<String> user_name_get(String userid) async {
  var collection = FirebaseFirestore.instance.collection("auth");
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    user_name = data['name'];
  } else {}
  return user_name;
}

String email = "";
Future<String> email_get(String userid) async {
  var collection = FirebaseFirestore.instance.collection("auth");
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    email = data['email'];
  } else {}
  return email;
}

String user_image = "";
Future<String> user_image_get(String userid) async {
  var collection = FirebaseFirestore.instance.collection("auth");
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    user_image = data['image'];
  } else {}
  return user_image;
}

int user_coin = 0;
Future<int> user_coins_get(String userid) async {
  print("userid: $userid");
  var collection = FirebaseFirestore.instance.collection("auth");
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    user_coin = data['coin'];
  } else {}
  return user_coin;
}

String profilepostlikefuture = "";

Future<String> profilepostlikefutureget(String uid) async {
  // firestore.collection('pine_app').doc("id").collection("feed").where('uid',isEqualTo: my_current_userid).get().then((value){
  //   value.docs.forEach((element) {

  //   });
  // });
  // var collection = FirebaseFirestore.instance.collection("auth");
  // var docSnapshot = await collection.doc(userid).get();
  // if (docSnapshot.exists) {
  //   Map<String, dynamic> data = docSnapshot.data()!;
  //   profilepostlikefuture = data['image'];
  // } else {}
  return profilepostlikefuture;
}

int user_total_reel_views = 0;
Future<int> user_total_reel_viewss(String userId) async {
  var collection = FirebaseFirestore.instance.collection("reels");
  var querySnapshot = await collection.where("uid", isEqualTo: userId).get();

  int totalViews = 0;

  if (querySnapshot.docs.isNotEmpty) {
    for (var doc in querySnapshot.docs) {
      List views = doc['views'];

      log("totalViews length: ${doc['views'].length}");
      totalViews += views.length;
    }
    user_total_reel_views = totalViews;
  } else {
    user_total_reel_views = 0;
  }

  return user_total_reel_views;
}
