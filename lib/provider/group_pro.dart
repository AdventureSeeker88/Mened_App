import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mended/helper/storage_methods.dart';
import 'package:mended/model/comment_model.dart';
import 'package:mended/model/group_post_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/widgets/dailog.dart';
import 'package:mended/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../model/group_model.dart';

class GroupPro with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  createGroup(
    Uint8List groupimage,
    groupname,
    groupdescription,
    groupType,
    context,
  ) async {
    try {
      showCircularLoadDialog(context);
      String id = const Uuid().v4();

      String url = '';
      url = await StorageMethods()
          .uploadImageToStoragee('group/images/', groupimage, true);

      GroupModel model = GroupModel(
        uid: auth.currentUser!.uid,
        id: id,
        image: url,
        title: groupname,
        des: groupdescription,
        member: [
        
        ],
        status: 0,
        type: groupType,
        dateTime: Timestamp.now(),
        media: [],
      );

      firestore
          .collection(Database.group)
          .doc(
            id,
          )
          .set(model.toJson())
          .then((value) {});
    } catch (e) {
      debugPrint("Catch Exeption: $e");
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  deletePost(String groupId, String postId, context) async {
    try {
      // show_loading_dialog(context);

      await firestore
          .collection(Database.group)
          .doc(groupId)
          .collection(Database.groupPost)
          .doc(
            postId,
          )
          .delete()
          .then((value) async {})
          .onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    } catch (e) {
      debugPrint("Catch Exception: $e");
    }
  }

  postLike(
      int value, List userId, String groupId, String postId, context) async {
    try {
      // show_loading_dialog(context);

      await firestore
          .collection(Database.group)
          .doc(groupId)
          .collection(Database.groupPost)
          .doc(
            postId,
          )
          .update({
        "like": (value == 1)
            ? FieldValue.arrayUnion(userId)
            : FieldValue.arrayRemove(userId)
      }).then((value) async {
        notifyListeners();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    } catch (e) {
      debugPrint("Catch Exception: $e");
    }
  }

  postAdd(String groupId, String userId, Uint8List? postImage, postDocoument,
      String postTitle, String postDescription, context) async {
    try {
      showCircularLoadDialog(context);

      String postUniqueId = const Uuid().v1();

      String postImageUrl = "";
      if (postImage != null) {
        postImageUrl = await StorageMethods()
            .uploadImageOrPdfToStorage('group/posts/', postImage, false, false);
      }

      String postPdfUrl = "";
      if (postDocoument != null) {
        postPdfUrl = await StorageMethods().uploadImageOrPdfToStorage(
            'group/posts/', postDocoument, false, true);
      }

      int type = 0;
      if (postImage == null && postDocoument == null) {
        type = 0;
      } else if (postDocoument != null) {
        type = 2;
      } else if (postImage != null) {
        type = 1;
      }

      GroupPostModel model = GroupPostModel(
        groupId: groupId,
        uid: userId,
        id: postUniqueId,
        image: postImageUrl,
        doc: postPdfUrl,
        title: postTitle,
        description: postDescription,
        like: [],
        comment: 0,
        views: 0,
        posted_date: Timestamp.now(),
        type: type,
      );

      await firestore
          .collection(Database.group)
          .doc(groupId)
          .collection(Database.groupPost)
          .doc(
            postUniqueId,
          )
          .set(model.toJson())
          .then((value) async {
        await firestore.collection(Database.group).doc(groupId).update({
          "media": FieldValue.arrayUnion([postUniqueId])
        });

        notifyListeners();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    } catch (e) {
      debugPrint("Catch Exception: $e");
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  groupJoinFun(String groupId, BuildContext context) async {
    final pro = Provider.of<AuthPro>(context, listen: false);
    var coll = firestore.collection(Database.group).doc(groupId);
    try {
      await coll.update({
        "member": FieldValue.arrayUnion([
          FirebaseAuth.instance.currentUser!.uid,
        ])
      }).then((value) async {
        await coll
            .collection(Database.groupMember)
            .doc(
              FirebaseAuth.instance.currentUser!.uid,
            )
            .set(
              GroupMemberM(
                uid: FirebaseAuth.instance.currentUser!.uid,
                image: pro.myUserdata['image'],
                name: pro.myUserdata['name'],
                bio: pro.myUserdata['bio'],
                status: 0,
                dateTime: Timestamp.now(),
              ).toJson(),
            );
        // ignore: use_build_context_synchronously
        Go.named(context, Routes.groupPost, {
          'id': groupId,
        });

        notifyListeners();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    } catch (e) {
      debugPrint("Catch Exception: $e");
    }
  }

  void postComment(
    String text,
    String fId,
    String gId,
  ) async {
    var commentId = const Uuid().v1();
    CommentModel model = CommentModel(
      uid: auth.currentUser!.uid,
      text: text,
      like: [],
      id: commentId,
      refid: fId,
      status: 0,
      dateTime: Timestamp.now(),
    );

    firestore
        .collection(Database.group)
        .doc(gId)
        .collection(Database.groupPost)
        .doc(
          fId,
        )
        .collection(Database.comment)
        .doc(commentId)
        .set(model.toJson());
    updateGroupPost(gId, fId, {
      'comment': FieldValue.increment(1),
    });
  }

  updateGroupPost(gId, id, json) async {
    await firestore
        .collection(Database.group)
        .doc(gId)
        .collection(Database.groupPost)
        .doc(
          id,
        )
        .update(json);
  }

  void commentLike(int value, gId, id, commentId) {
    firestore
        .collection(Database.group)
        .doc(gId)
        .collection(Database.groupPost)
        .doc(id)
        .collection(Database.comment)
        .doc(commentId)
        .update({
      'like': value == 0
          ? FieldValue.arrayUnion([auth.currentUser!.uid])
          : FieldValue.arrayRemove([auth.currentUser!.uid])
    });
  }

  Map groupData = {};
  GroupModel? groupModelData;
  bool groupDataisLoading = true;
  getGroupId(id) async {
    log("id: $id");
    groupDataisLoading = true;
    await firestore.collection(Database.group).doc(id).get().then((value) {
      groupModelData = GroupModel.fromSnap(value);

      // groupData = value.data()!;
    });
    groupDataisLoading = false;
    notifyListeners();
  }

  Map profileForGroupData = {};
  bool profileGroupisLoading = false;
  getProfileForThisGroup(id) async {
    profileGroupisLoading = true;
    await firestore
        .collection(Database.group)
        .doc(id)
        .collection(Database.groupMember)
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      profileForGroupData = value.data()!;
      notifyListeners();
    });
    profileGroupisLoading = false;
    notifyListeners();
  }

  updateProfileForThisGroup(Uint8List? image, name, bio, id, context) async {
    showCircularLoadDialog(context);
    var coll = firestore
        .collection(Database.group)
        .doc(id)
        .collection(Database.groupMember)
        .doc(auth.currentUser!.uid);

    if (image != null) {
      String url = await StorageMethods()
          .uploadImageToStoragee("group/profile/", image, true);
      await coll.update({
        'image': url,
      });
    }
    await coll.update({'name': name, 'bio': bio});
    Navigator.pop(context);
    Navigator.pop(context);
    customToast("Profile Update Successfully", context);
  }
}
