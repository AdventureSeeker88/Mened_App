import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String uid;
  final String text;
  final List like;
  final String id;
  final String refid;
  final int status;
  final Timestamp dateTime;
  const CommentModel({
    required this.uid,
    required this.text,
    required this.like,
    required this.id,
    required this.refid,
    required this.status,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'text': text,
        'like': like,
        'id': id,
        'refid': refid,
        'status': status,
        'dateTime': dateTime,
      };
  static CommentModel fromJson(Map<String, dynamic> json) => CommentModel(
        uid: json['uid'] ?? '',
        text: json['text'] ?? '',
        like: json['like'] ?? '',
        id: json['id'] ?? '',
        refid: json['refid'] ?? '',
        status: json['status'] ?? '',
        dateTime: json['dateTime'] ?? '',
      );
  static CommentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
      uid: snapshot["uid"],
      text: snapshot["text"],
      like: snapshot["like"],
      id: snapshot["id"],
      refid: snapshot["refid"],
      status: snapshot["e"],
      dateTime: snapshot["dateTime"],
    );
  }
}
