import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mended/model/group_model.dart';
import 'package:mended/utils/database.dart';

class FutureFun {

  
  int views = 0;
  Future<int> flickTotalViews(String userId) async {
    var collection = FirebaseFirestore.instance.collection(Database.flicks);
    var querySnapshot = await collection.where("uid", isEqualTo: userId).get();

    int totalViews = 0;
    print(userId);
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        List views = doc['views'];

        totalViews += views.length;
      }
      views = totalViews;
    } else {
      views = 0;
    }

    return views;
  }

  Future<GroupMemberM> getGroupMemberByid(String groupid, id) async {
    log("member id: $id");
    return await FirebaseFirestore.instance
        .collection(Database.group)
        .doc(groupid)
        .collection(Database.groupMember)
        .doc(id)
        .get()
        .then((value) {
      return GroupMemberM.fromSnap(value);
    });
  }
}
