import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mended/helper/storage_methods.dart';
import 'package:mended/model/comment_model.dart';
import 'package:mended/model/memeland_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/widgets/dailog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MemelandPro with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  int pageIndex = 1;
  void onPageChanged(index) {
    pageIndex = index;
    notifyListeners();
  }

  void addMemeland(Uint8List image, caption, context) async {
    showCircularLoadDialog(context);
    String id = const Uuid().v4();
    String url =
        await StorageMethods().uploadImageToStoragee('memeland/', image, true);
    MemelandModel model = MemelandModel(
      uid: FirebaseAuth.instance.currentUser!.uid,
      image: url,
      like: [],
      caption: caption,
      id: id,
      comment: 0,
      share: 0,
      status: 0,
      download: false,
      hidelike: false,
      offComment: false,
      dateTime: Timestamp.now(),
    );

    FirebaseFirestore.instance
        .collection(Database.memeland)
        .doc(id)
        .set(model.toJson())
        .then((value) {
      if (pageIndex == 1) {
        pageIndex = 2;
        pageIndex = 1;
        notifyListeners();
      } else {
        pageIndex = 1;
        pageIndex = 2;
        notifyListeners();
      }
      Navigator.pop(context);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
    });
  }

  Future<List<DocumentSnapshot>> getMemeLandPopular() async {
    return await firestore
        .collection(Database.memeland)
        .orderBy('like', descending: true)
        .get()
        .then((value) {
      return value.docs;
    });
  }

  Future<List<DocumentSnapshot>> getMemeLand() async {
    return await firestore.collection(Database.memeland).get().then((value) {
      return value.docs..shuffle();
    });
  }

  Future<List<DocumentSnapshot>> getMemeLandByUserId(id) async {
    return await firestore
        .collection(Database.memeland)
        .where('uid', isEqualTo: id)
        .orderBy(
          'dateTime',
          descending: true,
        )
        .get()
        .then((value) {
      return value.docs;
    });
  }

  Future getMemeById(id, context) async {
    return await firestore
        .collection(Database.memeland)
        .doc(id)
        .get()
        .then((value) async {
      var auth = await firestore
          .collection(Database.auth)
          .doc(value.data()!['uid'])
          .get()
          .then((value) {
        return value.data();
      });

      return {'user': auth, 'memeland': value.data()};
    });
  }

  likeUpdate(id) async {
    bool exist = await firestore
        .collection(Database.memeland)
        .doc(id)
        .get()
        .then((value) {
      return value.data()!['like'].contains(auth.currentUser!.uid)
          ? true
          : false;
    });
    await updateMemeland(
      id,
      {
        'like': exist
            ? FieldValue.arrayRemove(
                [auth.currentUser!.uid],
              )
            : FieldValue.arrayUnion(
                [auth.currentUser!.uid],
              ),
      },
    );
  }

  updateMemeland(id, json) async {
    await firestore.collection(Database.memeland).doc(id).update(json);
  }

  void postComment(
    String text,
    String id,
  ) async {
    var commentId = const Uuid().v1();
    CommentModel model = CommentModel(
      uid: auth.currentUser!.uid,
      text: text,
      like: [],
      id: commentId,
      refid: id,
      status: 0,
      dateTime: Timestamp.now(),
    );

    firestore
        .collection(Database.memeland)
        .doc(id)
        .collection(Database.comment)
        .doc(commentId)
        .set(model.toJson());
    updateMemeland(id, {
      'comment': FieldValue.increment(1),
    });
  }

  void commentLike(int value, id, commentId) {
    print("update");
    firestore
        .collection(Database.memeland)
        .doc(id)
        .collection(Database.comment)
        .doc(commentId)
        .update({
      'like': value == 0
          ? FieldValue.arrayUnion([auth.currentUser!.uid])
          : FieldValue.arrayRemove([auth.currentUser!.uid])
    });
  }
}
