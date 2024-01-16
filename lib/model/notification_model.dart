import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationM {
  final String senderId;
  final String notifyId;

  final String title;
  final String description;

  final Map data;
  final List receiverId;
  final List seenId;

  final int status;
  final Timestamp dateTime;
  const NotificationM({
    required this.senderId,
    required this.notifyId,
    required this.title,
    required this.description,
    required this.data,
    required this.receiverId,
    required this.seenId,
    required this.status,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'notifyId': notifyId,
        'title': title,
        'description': description,
        'data': data,
        'receiverId': receiverId,
        'seenId': seenId,
        'status': status,
        'dateTime': dateTime,
      };
  static NotificationM fromJson(Map<String, dynamic> json) => NotificationM(
        senderId: json['senderId'] ?? '',
        notifyId: json['notifyId'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        data: json['data'] ?? '',
        receiverId: json['receiverId'] ?? '',
        seenId: json['seenId'] ?? '',
        status: json['status'] ?? '',
        dateTime: json['dateTime'] ?? '',
      );
  static NotificationM fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return NotificationM(
      senderId: snapshot["senderId"],
      notifyId: snapshot["notifyId"],
      title: snapshot["title"],
      description: snapshot["description"],
      data: snapshot["data"],
      receiverId: snapshot["receiverId"],
      seenId: snapshot["seenId"],
      status: snapshot["status"],
      dateTime: snapshot["dateTime"],
    );
  }
}
