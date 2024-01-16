import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String uid;
  final String id;
  final String image;
  final String title;
  final String des;

  final List member;
  final int status;
  final Timestamp dateTime;
  final String type;
  final List media;

  const GroupModel({
    required this.uid,
    required this.id,
    required this.image,
    required this.title,
    required this.des,
    required this.member,
    required this.type,
    required this.dateTime,
    required this.status,
    required this.media,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'id': id,
        'image': image,
        'title': title,
        'des': des,
        'member': member,
        'type': type,
        'dateTime': dateTime,
        'status': status,
        'media': media,
      };
  static GroupModel fromJson(Map<String, dynamic> json) => GroupModel(
        uid: json['uid'] ?? '',
        id: json['id'] ?? '',
        image: json['image'] ?? '',
        title: json['title'] ?? '',
        des: json['des'] ?? '',
        member: json['member'] ?? '',
        type: json['type'] ?? '',
        dateTime: json['dateTime'] ?? '',
        status: json['status'] ?? '',
        media: json['media'] ?? '',
      );
  static GroupModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return GroupModel(
      uid: snapshot["uid"],
      id: snapshot["id"],
      image: snapshot["image"],
      title: snapshot["title"],
      des: snapshot["des"],
      member: snapshot["member"],
      type: snapshot["type"],
      dateTime: snapshot["dateTime"],
      status: snapshot["status"],
      media: snapshot["media"],
    );
  }
}

class GroupMemberM {
  final String uid;
  final String image;
  final String name;
  final String bio;
  final int status;
  final Timestamp dateTime;

  const GroupMemberM({
    required this.uid,
    required this.image,
    required this.name,
    required this.bio,
    required this.status,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'image': image,
        'name': name,
        'bio': bio,
        'status': status,
        'dateTime': dateTime,
      };
  static GroupMemberM fromJson(Map<String, dynamic> json) => GroupMemberM(
        uid: json['uid'] ?? '',
        image: json['image'] ?? '',
        name: json['name'] ?? '',
        bio: json['bio'] ?? '',
        status: json['status'] ?? '',
        dateTime: json['dateTime'] ?? '',
      );
  static GroupMemberM fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return GroupMemberM(
      uid: snapshot["uid"],
      image: snapshot["image"],
      name: snapshot["name"],
      bio: snapshot["bio"],
      status: snapshot["status"],
      dateTime: snapshot["dateTime"],
    );
  }
}
