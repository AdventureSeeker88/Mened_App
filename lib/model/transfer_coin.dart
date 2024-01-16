import 'package:cloud_firestore/cloud_firestore.dart';

class TransferCoinM {
  final String id;
  final String transferBy;
  final int coin;
  final String receiverId;
  final String transferId;
  final int status;
  final Timestamp dateTime;

  const TransferCoinM({
    required this.id,
    required this.transferBy,
    required this.coin,
    required this.receiverId,
    required this.transferId,
    required this.status,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'transferBy': transferBy,
        'coin': coin,
        'receiverId': receiverId,
        'transferId': transferId,
        'status': status,
        'dateTime': dateTime,
      };
  static TransferCoinM fromJson(Map<String, dynamic> json) => TransferCoinM(
        id: json['id'] ?? '',
        transferBy: json['transferBy'] ?? '',
        coin: json['coin'] ?? '',
        receiverId: json['receiverId'] ?? '',
        transferId: json['transferId'] ?? '',
        status: json['status'] ?? '',
        dateTime: json['dateTime'] ?? '',
      );
  static TransferCoinM fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TransferCoinM(
      id: snapshot["id"],
      transferBy: snapshot["transferBy"],
      coin: snapshot["coin"],
      receiverId: snapshot["receiverId"],
      transferId: snapshot["transferId"],
      status: snapshot["status"],
      dateTime: snapshot["dateTime"],
    );
  }
}
