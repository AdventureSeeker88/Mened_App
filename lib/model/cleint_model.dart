import 'package:cloud_firestore/cloud_firestore.dart';

class CleintModel {
  final String uid;
  final String id;
  final String receiverId;
  final int status;
  const CleintModel({
    required this.uid,
    required this.id,
    required this.receiverId,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'id': id,
        'receiverId': receiverId,
        'status': status,
      };
  static CleintModel fromJson(Map<String, dynamic> json) => CleintModel(
        uid: json['uid'] ?? '',
        id: json['id'] ?? '',
        receiverId: json['receiverId'] ?? '',
        status: json['status'] ?? '',
      );
  static CleintModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CleintModel(
      uid: snapshot["uid"],
      id: snapshot["id"],
      receiverId: snapshot["receiverId"],
      status: snapshot["status"],
    );
  }
}
