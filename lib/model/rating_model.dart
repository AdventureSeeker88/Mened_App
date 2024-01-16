import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String id;
  final String senderId;
  final double rating;
  final String receiverId;
  final String title;
  final int status;
  final Timestamp dateTime;

  const RatingModel({
    required this.id,
    required this.senderId,
    required this.rating,
    required this.receiverId,
    required this.title,
    required this.status,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'senderId': senderId,
        'rating': rating,
        'receiverId': receiverId,
        'title': title,
        'status': status,
        'dateTime': dateTime,
      };
  static RatingModel fromJson(Map<String, dynamic> json) => RatingModel(
        id: json['id'] ?? '',
        senderId: json['senderId'] ?? '',
        rating: json['rating'] ?? '',
        receiverId: json['receiverId'] ?? '',
        title: json['title'] ?? '',
        status: json['status'] ?? '',
        dateTime: json['dateTime'] ?? '',
      );
  static RatingModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return RatingModel(
      id: snapshot["id"],
      senderId: snapshot["senderId"],
      rating: snapshot["rating"],
      receiverId: snapshot["receiverId"],
      title: snapshot["title"],
      status: snapshot["status"],
      dateTime: snapshot["dateTime"],
    );
  }
}
