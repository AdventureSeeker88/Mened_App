import 'package:cloud_firestore/cloud_firestore.dart';

class AuthM {
  final String uid;
  final int chargeCoins;
  final String image;
  final String name;
  final String bio;
  final String aboutDoctor;
  final String email;
  final Timestamp dateTime;
  final int type;
  final List buddyList;
  final List supporterList;
  final List blockList;
  final int views;
  final List category;
  final String onlineStatus;
  final String token;
  final int status;
  final int coin;

  const AuthM({
    required this.uid,
    required this.chargeCoins,
    required this.image,
    required this.name,
    required this.bio,
    required this.aboutDoctor,
    required this.email,
    required this.dateTime,
    required this.type,
    required this.buddyList,
    required this.supporterList,
    required this.blockList,
    required this.views,
    required this.category,
    required this.token,
    required this.status,
    required this.onlineStatus,
    required this.coin,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'chargeCoins': chargeCoins,
        'image': image,
        'name': name,
        'bio': bio,
        'aboutDoctor': aboutDoctor,
        'email': email,
        'dateTime': dateTime,
        'type': type,
        'buddyList': buddyList,
        'supporterList': supporterList,
        'blockList': blockList,
        'views': views,
        'category': category,
        'token': token,
        'status': status,
        'onlineStatus': onlineStatus,
        'coin': coin,
      };
  static AuthM fromJson(Map<String, dynamic> json) => AuthM(
        uid: json['uid'] ?? '',
        chargeCoins: json['chargeCoins'] ?? '',
        image: json['image'] ?? '',
        name: json['name'] ?? '',
        bio: json['bio'] ?? '',
        aboutDoctor: json['aboutDoctor'] ?? '',
        email: json['email'] ?? '',
        dateTime: json['dateTime'] ?? '',
        type: json['type'] ?? '',
        buddyList: json['buddyList'] ?? '',
        supporterList: json['supporterList'] ?? '',
        blockList: json['blockList'] ?? '',
        views: json['views'] ?? '',
        category: json['category'] ?? '',
        token: json['token'] ?? '',
        status: json['status'] ?? '',
        onlineStatus: json['onlineStatus'] ?? '',
        coin: json['coin'] ?? '',
      );
  static AuthM fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AuthM(
      uid: snapshot["uid"],
      chargeCoins: snapshot["chargeCoins"],
      image: snapshot["image"],
      name: snapshot["name"],
      bio: snapshot["bio"],
      aboutDoctor: snapshot["aboutDoctor"],
      email: snapshot["email"],
      dateTime: snapshot["dateTime"],
      type: snapshot["type"],
      buddyList: snapshot["buddyList"],
      supporterList: snapshot["supporterList"],
      blockList: snapshot["blockList"],
      views: snapshot["views"],
      category: snapshot["category"],
      token: snapshot["token"],
      status: snapshot["status"],
      onlineStatus: snapshot["onlineStatus"],
      coin: snapshot["coin"],
    );
  }
}
