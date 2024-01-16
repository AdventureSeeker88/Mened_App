import 'package:cloud_firestore/cloud_firestore.dart';

class GroupPostModel {
  final String groupId;
  final String uid;
  final String id;
  final String image;
  final String doc;
  final String title;
  final String description;
  final List like;
  final int comment;
  final int views;
  final int type;

  final Timestamp posted_date;

  const GroupPostModel({
    required this.groupId,
    required this.uid,
    required this.id,
    required this.image,
    required this.doc,
    required this.title,
    required this.description,
    required this.like,
    required this.comment,
    required this.views,
    required this.posted_date,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'uid': uid,
        'id': id,
        'image': image,
        'doc': doc,
        'title': title,
        'description': description,
        'like': like,
        'comment': comment,
        'views': views,
        'posted_date': posted_date,
        'type': type,
      };
  static GroupPostModel fromJson(Map<String, dynamic> json) => GroupPostModel(
        groupId: json['groupId'] ?? '',
        uid: json['uid'] ?? '',
        id: json['id'] ?? '',
        image: json['image'] ?? '',
        doc: json['doc'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        like: json['like'] ?? '',
        comment: json['comment'] ?? '',
        views: json['views'] ?? '',
        posted_date: json['posted_date'] ?? '',
        type: json['type'] ?? '',
      );
  static GroupPostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return GroupPostModel(
      groupId: snapshot["groupId"],
      uid: snapshot["uid"],
      id: snapshot["id"],
      image: snapshot["image"],
      doc: snapshot["doc"],
      title: snapshot["title"],
      description: snapshot["description"],
      like: snapshot["like"],
      comment: snapshot["comment"],
      views: snapshot["views"],
      posted_date: snapshot["posted_date"],
      type: snapshot["type"],
    );
  }
}
