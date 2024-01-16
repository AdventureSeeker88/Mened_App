import 'package:cloud_firestore/cloud_firestore.dart';

class CallModel {
  final int duration;
  final String message;
  final int deductCoins;
  final String callerId;
  final String receiverId;
 final String channelId;
  final Map callData;
  final List join;
  final List camera;
  final List audio;
  final Timestamp dateTime;
  final int status;

  const CallModel({
    required this.duration,
    required this.message,
    required this.deductCoins,
    required this.callerId,
    required this.receiverId,
    required this.channelId,
    required this.callData,
    required this.camera,
    required this.audio,
    required this.join,
    required this.dateTime,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'duration': duration,
        'message': message,
        'deductCoins': deductCoins,
        'callerId': callerId,
        'receiverId': receiverId,
        'channelId': channelId,
        'callData': callData,
        'camera': camera,
        'audio': audio,
        'join': join,
        'dateTime': dateTime,
        'status': status,
      };
  static CallModel fromJson(Map<String, dynamic> json) => CallModel(
        duration: json['duration'] ?? '',
        message: json['message'] ?? '',
        deductCoins: json['deductCoins'] ?? '',
        callerId: json['callerId'] ?? '',
        receiverId: json['receiverId'] ?? '',
        channelId: json['channelId'] ?? '',
        callData: json['callData'] ?? '',
        camera: json['camera'] ?? '',
        audio: json['audio'] ?? '',
        join: json['join'] ?? '',
        dateTime: json['dateTime'] ?? '',
        status: json['status'] ?? '',
      );
  static CallModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CallModel(
      duration: snapshot["duration"],
      message: snapshot["message"],
      deductCoins: snapshot["deductCoins"],
      callerId: snapshot["callerId"],
      receiverId: snapshot["receiverId"],
      channelId: snapshot["channelId"],
      callData: snapshot["callData"],
      camera: snapshot["camera"],
      audio: snapshot["audio"],
      join: snapshot["join"],
      dateTime: snapshot["dateTime"],
      status: snapshot["status"],
    );
  }
}
