import 'package:cloud_firestore/cloud_firestore.dart';

class MemelandModel {
  final String uid;
  final String image;
  final List like;
  final String caption;
  final String id;
  final int comment;
  final int share;
  final int status;
  final bool download;
  final bool hidelike;
  final bool offComment;
  final Timestamp dateTime;
  const MemelandModel({
    required this.uid,
    required this.image,
    required this.like,
    required this.caption,
    required this.id,
    required this.comment,
    required this.share,
    required this.status,
    required this.download,
    required this.hidelike,
    required this.offComment,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'image': image,
        'like': like,
        'caption': caption,
        'id': id,
        'comment': comment,
        'share': share,
        'status': status,
        'download': download,
        'hidelike': hidelike,
        'offComment': offComment,
        'dateTime': dateTime,
      };
  static MemelandModel fromJson(Map<String, dynamic> json) => MemelandModel(
        uid: json['uid'] ?? '',
        image: json['image'] ?? '',
        like: json['like'] ?? '',
        caption: json['caption'] ?? '',
        id: json['id'] ?? '',
        comment: json['comment'] ?? '',
        share: json['share'] ?? '',
        status: json['status'] ?? '',
        download: json['download'] ?? '',
        hidelike: json['hidelike'] ?? '',
        offComment: json['offComment'] ?? '',
        dateTime: json['dateTime'] ?? '',
      );
  static MemelandModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return MemelandModel(
      uid: snapshot["uid"],
      image: snapshot["image"],
      like: snapshot["like"],
      caption: snapshot["caption"],
      id: snapshot["id"],
      comment: snapshot["comment"],
      share: snapshot["share"],
      status: snapshot["status"],
      download: snapshot["download"],
      hidelike: snapshot["hidelike"],
      offComment: snapshot["offComment"],
      dateTime: snapshot["dateTime"],
    );
  }
}
