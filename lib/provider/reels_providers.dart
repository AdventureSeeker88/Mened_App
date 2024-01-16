// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:mended/model/comment_model.dart';
// import 'package:mended/model/reels_model.dart';
// import 'package:mended/widgets/dailog.dart';
// import 'package:uuid/uuid.dart';

// class ReelPro with ChangeNotifier {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;

//   void add_new_reels(descripton, hashtags, file_video, context) async {
//     try {
//       showCircularLoadDialog(context);
//       String id = const Uuid().v1();
//       var imagefile = FirebaseStorage.instance
//           .ref()
//           .child("reels/video/")
//           .child(FirebaseAuth.instance.currentUser!.uid)
//           .child(id);
//       UploadTask task = imagefile.putFile(file_video!);
//       TaskSnapshot snapshot = await task;
//       String url = await snapshot.ref.getDownloadURL();
     
//       var reels_id = Uuid().v4();
//       reels_model _model = reels_model(
//           reels_id: reels_id,
//           uid: _auth.currentUser!.uid,
//           video: url,
//           description: descripton,
//           hashtags: hashtags,
//           like: [],
//           views: [],
//           comment: 0,
//           type: 0,
//           status: 0,
//           date_time: Timestamp.now(),
//           shares: 0);

//       _firestore
//           .collection("reels")
//           .doc(reels_id)
//           .set(_model.toJson())
//           .then((value) {
//         Navigator.pop(context);
//         Navigator.pop(context);
//       }).onError((error, stackTrace) {
//         Navigator.pop(context);
//       });
//     } catch (e) {
//       Navigator.pop(context);
//     }
//   }

//   void reel_view_add_func(reels_id) {
//     _firestore.collection("reels").doc(reels_id).update({
//       'views': FieldValue.arrayUnion([_auth.currentUser!.uid])
//     });
//     notifyListeners();
//   }

//   void reels_like_remove(int value, reels_id) {
//     if (value == 0) {
//       _firestore.collection("reels").doc(reels_id).update({
//         'like': FieldValue.arrayUnion([_auth.currentUser!.uid])
//       });
//     } else {
//       _firestore.collection("reels").doc(reels_id).update({
//         'like': FieldValue.arrayRemove([_auth.currentUser!.uid])
//       });
//     }
//   } 

//   void reels_share_func(String reels_id) {
//     try {
//       _firestore
//           .collection("reels")
//           .doc(reels_id)
//           .update({'shares': FieldValue.increment(1)});
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void comments_like_remove(int value, reels_id, comment_id) {
//     if (value == 0) {
//       _firestore
//           .collection("reels")
//           .doc(reels_id)
//           .collection("comment")
//           .doc(comment_id)
//           .update({
//         'like': FieldValue.arrayUnion([_auth.currentUser!.uid])
//       });
//     } else {
//       _firestore
//           .collection("reels")
//           .doc(reels_id)
//           .collection("comment")
//           .doc(comment_id)
//           .update({
//         'like': FieldValue.arrayRemove([_auth.currentUser!.uid])
//       });
//     }
//   }

//   void post_comment(
//     String text,
//     String reels_id,
//     int type,
//   ) async {
//     var comment_id = const Uuid().v1();
//     CommentModel _model = CommentModel(
//       uid: _auth.currentUser!.uid,
//       comment_id: comment_id,
//       text: text,
//       like: [],
//       reels_id: reels_id,
//       type: type,
//       status: 0,
//       date_time: Timestamp.now(),
//     );

//     _firestore
//         .collection("reels")
//         .doc(reels_id)
//         .collection('comment')
//         .doc(comment_id)
//         .set(_model.toJson());

//     FirebaseFirestore.instance.collection("reels").doc(reels_id).update({
//       'comment': FieldValue.increment(1),
//     });
//   }
// }
