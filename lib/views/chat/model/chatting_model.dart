import 'package:cloud_firestore/cloud_firestore.dart';

class general_message_model {
  final String sender_id;
  final String reciver_id;
  final Timestamp date_time;
  final List uid_list;
  final String chat_id;
  final String last_message;
  final List block;
  final List availableUser;

  const general_message_model({
    required this.sender_id,
    required this.reciver_id,
    required this.date_time,
    required this.uid_list,
    required this.chat_id,
    required this.last_message,
    required this.block,
    required this.availableUser,
  });

  Map<String, dynamic> toJson() => {
        'sender_id': sender_id,
        'reciver_id': reciver_id,
        'chat_id': chat_id,
        'date_time': date_time,
        'uid_list': uid_list,
        'last_message': last_message,
        'block': block,
        'availableUser': availableUser,
      };
  static general_message_model fromJson(Map<String, dynamic> json) =>
      general_message_model(
        sender_id: json['sender_id'] ?? '',
        reciver_id: json['reciver_id'] ?? '',
        date_time: json['date_time'] ?? '',
        uid_list: json['uid_list'] ?? '',
        chat_id: json['chat_id'] ?? '',
        last_message: json['last_message'] ?? '',
        block: json['block'] ?? '',
        availableUser: json['availableUser'] ?? '',
      );
  static general_message_model fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return general_message_model(
      sender_id: snapshot["sender_id"],
      reciver_id: snapshot["reciver_id"],
      date_time: snapshot["date_time"],
      uid_list: snapshot["uid_list"],
      chat_id: snapshot["chat_id"],
      last_message: snapshot["last_message"],
      block: snapshot["block"],
      availableUser: snapshot["availableUser"],
    );
  }
}
