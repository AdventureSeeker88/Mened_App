import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mended/helper/storage_methods.dart';
import 'package:mended/provider/notification_pro.dart';
import 'package:mended/views/chat/model/InnerMessageModel.dart';
import 'package:mended/views/chat/model/chatting_model.dart';
import 'package:mended/views/chat/use_full/id.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatPro with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  // void send_text_message(oppister_uid, text, context) {
  //   var message_id = const Uuid().v4();
  //   general_message_model _model = general_message_model(
  //     sender_id: FirebaseAuth.instance.currentUser!.uid,
  //     reciver_id: oppister_uid,
  //     date_time: Timestamp.now(),
  //     uid_list: [
  //       FirebaseAuth.instance.currentUser!.uid,
  //       oppister_uid,
  //     ],
  //     chat_id: get_chat_id(
  //       FirebaseAuth.instance.currentUser!.uid,
  //       oppister_uid,
  //     ),
  //     last_message: text,
  //     block: [],
  //   );
  //   inner_message_model _model_inner = inner_message_model(
  //     sender_id: FirebaseAuth.instance.currentUser!.uid,
  //     message_id: message_id,
  //     receiver_id: oppister_uid,
  //     msg: text,
  //     date_time: Timestamp.now(),
  //     type: 0,
  //     file_name: "",
  //     delete_type: 0,
  //     seen: [FirebaseAuth.instance.currentUser!.uid],
  //   );

  //   _firestore
  //       .collection("chats")
  //       .doc(
  //         get_chat_id(
  //           FirebaseAuth.instance.currentUser!.uid,
  //           oppister_uid,
  //         ),
  //       )
  //       .set(_model.toJson());
  //   _firestore
  //       .collection("chats")
  //       .doc(
  //         get_chat_id(
  //           FirebaseAuth.instance.currentUser!.uid,
  //           oppister_uid,
  //         ),
  //       )
  //       .collection("messages")
  //       .doc(message_id)
  //       .set(_model_inner.toJson());
  // }

  void send_text_message(oppister_uid, text, context) async {
    var message_id = const Uuid().v4();
    bool exists = await _firestore
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            oppister_uid,
          ),
        )
        .get()
        .then((value) {
      return value.exists;
    });
    var _model;
    if (exists) {
      print("exists");
      _model = {
        'sender_id': FirebaseAuth.instance.currentUser!.uid,
        'reciver_id': oppister_uid,
        'date_time': Timestamp.now(),
        'last_message': text,
        'availableUser':
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
      };
      _firestore
          .collection("chats")
          .doc(
            get_chat_id(
              FirebaseAuth.instance.currentUser!.uid,
              oppister_uid,
            ),
          )
          .update(_model);
    } else {
      print("Not exists");

      _model = general_message_model(
        sender_id: FirebaseAuth.instance.currentUser!.uid,
        reciver_id: oppister_uid,
        date_time: Timestamp.now(),
        uid_list: [
          FirebaseAuth.instance.currentUser!.uid,
          oppister_uid,
        ],
        chat_id: get_chat_id(
          FirebaseAuth.instance.currentUser!.uid,
          oppister_uid,
        ),
        last_message: text,
        block: [],
        availableUser: [FirebaseAuth.instance.currentUser!.uid],
      );
      _firestore
          .collection("chats")
          .doc(
            get_chat_id(
              FirebaseAuth.instance.currentUser!.uid,
              oppister_uid,
            ),
          )
          .set(_model.toJson());
    }

    inner_message_model _model_inner = inner_message_model(
      sender_id: FirebaseAuth.instance.currentUser!.uid,
      message_id: message_id,
      receiver_id: oppister_uid,
      msg: text,
      date_time: Timestamp.now(),
      type: 0,
      file_name: "",
      delete_type: 0,
      seen: [FirebaseAuth.instance.currentUser!.uid],
    );

    _firestore
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            oppister_uid,
          ),
        )
        .collection("messages")
        .doc(message_id)
        .set(_model_inner.toJson());

    List notify = await _firestore
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            oppister_uid,
          ),
        )
        .get()
        .then((value) {
      return value.data()!['availableUser'];
    });
    if (notify.contains(oppister_uid)) {
    } else {
      sendNotification(oppister_uid, text, context);
    }
  }

  void sendNotification(opisterid, message, context) async {
    String token =
        await _firestore.collection("auth").doc(opisterid).get().then((value) {
      return value.data()!['token'];
    });
    String senderName = await _firestore
        .collection("auth")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      return value.data()!['name'];
    });
    final post = Provider.of<NotificationPro>(context, listen: false);
    print("sendNotification");
    post.sendNotification(
        senderName,
        message,
        {
          'senderId': FirebaseAuth.instance.currentUser!.uid,
          'receiverId': opisterid,
          'location': 'RouteConstants.chattingScreen',
          'type': 'chat'
        },
        token);
  }

  void send_image(oppister_uid, Uint8List image, context) async {
    print("images");
    String url = await StorageMethods()
        .uploadImageToStoragee('chats/images/', image, true);

    var message_id = const Uuid().v4();
    general_message_model _model = general_message_model(
      sender_id: FirebaseAuth.instance.currentUser!.uid,
      reciver_id: oppister_uid,
      date_time: Timestamp.now(),
      uid_list: [
        FirebaseAuth.instance.currentUser!.uid,
        oppister_uid,
      ],
      chat_id: get_chat_id(
        FirebaseAuth.instance.currentUser!.uid,
        oppister_uid,
      ),
      last_message: '',
      block: [],
      availableUser: [],
    );
    inner_message_model _model_inner = inner_message_model(
      sender_id: FirebaseAuth.instance.currentUser!.uid,
      message_id: message_id,
      receiver_id: oppister_uid,
      msg: url,
      date_time: Timestamp.now(),
      type: 1,
      file_name: "",
      delete_type: 0,
      seen: [FirebaseAuth.instance.currentUser!.uid],
    );

    _firestore
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            oppister_uid,
          ),
        )
        .set(_model.toJson());
    _firestore
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            oppister_uid,
          ),
        )
        .collection("messages")
        .doc(message_id)
        .set(_model_inner.toJson());
  }

  void addseen(
    oppister_uid,
    message_id,
  ) {
    _firestore
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            oppister_uid,
          ),
        )
        .collection("messages")
        .doc(message_id)
        .update({
      'seen': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
  }

  void blockchat(oppister_uid) {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            oppister_uid,
          ),
        )
        .update({
      'block': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
  }

  Stream<List<general_message_model>> filter_chats() =>
      FirebaseFirestore.instance
          .collection("chats")
          .where('uid_list',
              arrayContainsAny: [FirebaseAuth.instance.currentUser!.uid])
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => general_message_model.fromJson(doc.data()))
              .toList());



//mender messaaging
void send_text_message_to_mender(mender_uid, text, context) async {
    var message_id = const Uuid().v4();
    bool exists = await _firestore
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            mender_uid,
          ),
        )
        .get()
        .then((value) {
      return value.exists;
    });
    var _model;
    if (exists) {
      print("exists");
      _model = {
        'sender_id': FirebaseAuth.instance.currentUser!.uid,
        'reciver_id': mender_uid,
        'date_time': Timestamp.now(),
        'last_message': text,
        'availableUser':
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
      };
      _firestore
          .collection("chats")
          .doc(
            get_chat_id(
              FirebaseAuth.instance.currentUser!.uid,
              mender_uid,
            ),
          )
          .update(_model);
    } else {
      print("Not exists");

      _model = general_message_model(
        sender_id: FirebaseAuth.instance.currentUser!.uid,
        reciver_id: mender_uid,
        date_time: Timestamp.now(),
        uid_list: [
          FirebaseAuth.instance.currentUser!.uid,
          mender_uid,
        ],
        chat_id: get_chat_id(
          FirebaseAuth.instance.currentUser!.uid,
          mender_uid,
        ),
        last_message: text,
        block: [],
        availableUser: [FirebaseAuth.instance.currentUser!.uid],
      );
      _firestore
          .collection("chats")
          .doc(
            get_chat_id(
              FirebaseAuth.instance.currentUser!.uid,
              mender_uid,
            ),
          )
          .set(_model.toJson());
    }

    inner_message_model _model_inner = inner_message_model(
      sender_id: FirebaseAuth.instance.currentUser!.uid,
      message_id: message_id,
      receiver_id: mender_uid,
      msg: text,
      date_time: Timestamp.now(),
      type: 0,
      file_name: "",
      delete_type: 0,
      seen: [FirebaseAuth.instance.currentUser!.uid],
    );

    _firestore
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            mender_uid,
          ),
        )
        .collection("messages")
        .doc(message_id)
        .set(_model_inner.toJson());

    List notify = await _firestore
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            mender_uid,
          ),
        )
        .get()
        .then((value) {
      return value.data()!['availableUser'];
    });
    if (notify.contains(mender_uid)) {
    } else {
      sendNotification(mender_uid, text, context);
    }
  }
}
