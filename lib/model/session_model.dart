import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String id;
  final String uid;
  final String title;
  final String cleintId;
  final Timestamp sessionDate;
  final Timestamp sessionEndDate;
  final String startTime;
  final String endTime;
  final String sessionType;
  final Timestamp dateTime;

  const SessionModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.cleintId,
    required this.sessionDate,
    required this.sessionEndDate,
    required this.startTime,
    required this.endTime,
    required this.sessionType,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'title': title,
        'cleintId': cleintId,
        'sessionDate': sessionDate,
        'sessionEndDate': sessionEndDate,
        'startTime': startTime,
        'endTime': endTime,
        'sessionType': sessionType,
        'dateTime': dateTime,
      };
  static SessionModel fromJson(Map<String, dynamic> json) => SessionModel(
        id: json['id'] ?? '',
        uid: json['uid'] ?? '',
        title: json['title'] ?? '',
        cleintId: json['cleintId'] ?? '',
        sessionDate: json['sessionDate'] ?? '',
        sessionEndDate: json['sessionEndDate'] ?? '',
        startTime: json['startTime'] ?? '',
        endTime: json['endTime'] ?? '',
        sessionType: json['sessionType'] ?? '',
        dateTime: json['dateTime'] ?? '',
      );
  static SessionModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return SessionModel(
      id: snapshot["id"],
      uid: snapshot["uid"],
      title: snapshot["title"],
      cleintId: snapshot["cleintId"],
      sessionDate: snapshot["sessionDate"],
      sessionEndDate: snapshot["sessionEndDate"],
      startTime: snapshot["startTime"],
      endTime: snapshot["endTime"],
      sessionType: snapshot["sessionType"],
      dateTime: snapshot["dateTime"],
    );
  }
}
