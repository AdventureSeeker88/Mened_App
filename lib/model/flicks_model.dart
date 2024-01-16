import 'package:cloud_firestore/cloud_firestore.dart';

class FlicksModel {
  final String uid;
  final String video;
  final String caption;
  final String hashtags;
  final List like;
  final List views;
  final int comment;
  final String id;
  final int type;
  final int status;
  final Timestamp dateTime;
  final int shares;

  const FlicksModel({
    required this.uid,
    required this.video,
    required this.caption,
    required this.hashtags,
    required this.like,
    required this.views,
    required this.comment,
    required this.id,
    required this.type,
    required this.status,
    required this.dateTime,
    required this.shares,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'video': video,
        'caption': caption,
        'hashtags': hashtags,
        'like': like,
        'views': views,
        'comment': comment,
        'id': id,
        'type': type,
        'status': status,
        'dateTime': dateTime,
        'shares': shares,
      };
  static FlicksModel fromJson(Map<String, dynamic> json) => FlicksModel(
        uid: json['uid'] ?? '',
        video: json['video'] ?? '',
        caption: json['caption'] ?? '',
        hashtags: json['hashtags'] ?? '',
        like: json['like'] ?? '',
        views: json['views'] ?? '',
        comment: json['comment'] ?? '',
        id: json['id'] ?? '',
        type: json['type'] ?? '',
        status: json['status'] ?? '',
        dateTime: json['dateTime'] ?? '',
        shares: json['shares'] ?? '',
      );
  static FlicksModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return FlicksModel(
      uid: snapshot["uid"],
      video: snapshot["video"],
      caption: snapshot["caption"],
      hashtags: snapshot["hashtags"],
      like: snapshot["like"],
      views: snapshot["views"],
      comment: snapshot["comment"],
      id: snapshot["id"],
      type: snapshot["type"],
      status: snapshot["status"],
      dateTime: snapshot["dateTime"],
      shares: snapshot["shares"],
    );
  }
}
