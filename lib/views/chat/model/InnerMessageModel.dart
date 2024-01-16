import 'package:cloud_firestore/cloud_firestore.dart';

class inner_message_model {
  final String sender_id;
  final String message_id;
  final String receiver_id;
  final String msg;
  final Timestamp date_time;
  final int type;
  final String file_name;
  final int delete_type;
  final List seen;

  const inner_message_model({
    required this.sender_id,
    required this.message_id,
    required this.receiver_id,
    required this.msg,
    required this.date_time,
    required this.type,
    required this.file_name,
    required this.delete_type,
    required this.seen,
  });

  Map<String, dynamic> toJson() => {
        'sender_id': sender_id,
        'message_id': message_id,
        'receiver_id': receiver_id,
        'msg': msg,
        'date_time': date_time,
        'type': type,
        'file_name': file_name,
        'delete_type': delete_type,
        'seen': seen,
      };
  static inner_message_model fromJson(Map<String, dynamic> json) =>
      inner_message_model(
        sender_id: json['sender_id'] ?? '',
        message_id: json['message_id'] ?? '',
        receiver_id: json['receiver_id'] ?? '',
        msg: json['msg'] ?? '',
        date_time: json['date_time'] ?? '',
        type: json['type'] ?? '',
        file_name: json['file_name'] ?? '',
        delete_type: json['delete_type'] ?? '',
        seen: json['seen'] ?? '',
      );
  static inner_message_model fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return inner_message_model(
      sender_id: snapshot["sender_id"],
      message_id: snapshot["message_id"],
      receiver_id: snapshot["receiver_id"],
      msg: snapshot["msg"],
      date_time: snapshot["date_time"],
      type: snapshot["type"],
      file_name: snapshot["file_name"],
      delete_type: snapshot["delete_type"],
      seen: snapshot["seen"],
    );
  }
}
