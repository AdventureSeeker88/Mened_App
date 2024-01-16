import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mended/helper/helper.dart';
import 'package:mended/model/call_model.dart';
import 'package:mended/model/cleint_model.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/views/call/new_call_screen.dart';
import 'package:mended/widgets/dailog.dart';

class CallPro with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  void createCall(int duration, String message, int deductCoins, receiverId,
      context) async {
    showCircularLoadDialog(context);
    await addCleint(auth.currentUser!.uid, receiverId);
    Map callData = await generateToken();
    if (duration == 5) {
      callData['hour'] = 0;
      callData['minute'] = 5;
      callData['seconds'] = 0;
    } else if (duration == 30) {
      callData['hour'] = 0;
      callData['minute'] = 30;
      callData['seconds'] = 0;
    } else if (duration == 45) {
      callData['hour'] = 0;
      callData['minute'] = 45;
      callData['seconds'] = 0;
    } else {
      callData['hour'] = 0;
      callData['minute'] = 0;
      callData['seconds'] = 0;
    }
    callData['minute-per-coin'] = deductCoins;
    callData['receiverId'] = receiverId;
    CallModel model = CallModel(
      duration: duration,
      message: message,
      deductCoins: deductCoins, // these are the coins we'll charge
      callerId: auth.currentUser!.uid,
      receiverId: receiverId,
      callData: callData,
      join: [auth.currentUser!.uid],
      dateTime: Timestamp.now(),
      status: 0,
      channelId: callData['channelId'],
      audio: [],
      camera: [],
    );
    log("callData");
    log(callData.toString());

    FirebaseFirestore.instance
        .collection(Database.callColl)
        .doc(callData['channelId'])
        .set(model.toJson())
        .then((value) {
      log("then");
      log(callData.toString());
      Navigator.pop(context);
      Go.route(context, NewCallScreen(callData: callData));
    }).onError((error, stackTrace) {
      Navigator.pop(context);
    });
  }

  void joinCall(Map callData, context) {
    log("joinCall");
    FirebaseFirestore.instance
        .collection("call-coll")
        .doc(callData['channelId'])
        .update({
      'join': FieldValue.arrayUnion([auth.currentUser!.uid])
    }).then((value) {
      Go.route(context, NewCallScreen(callData: callData));
    });
  }

  void enableCamera(bool type, Map callData) {
    FirebaseFirestore.instance
        .collection("call-coll")
        .doc(callData['channelId'])
        .update({
      'camera': type
          ? FieldValue.arrayUnion([auth.currentUser!.uid])
          : FieldValue.arrayRemove([auth.currentUser!.uid]),
    }).then((value) {});
  }

  void setCallStatus(Map callData) {
    FirebaseFirestore.instance
        .collection("call-coll")
        .doc(callData['channelId'])
        .update({
      'status': 1,
    }).then((value) {});
  }

  generateToken() async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://us-central1-my-kashmir-7c12f.cloudfunctions.net/createCallsWithTokens"),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode({'data': {}}),
      );
      log("response ${response.statusCode}");

      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body.toString());
      log("decodedData $decodedData");

        Map callData = decodedData["result"]['data'];
        return callData;
      }
    } catch (e) {
      log("exception $e");
      return {'error': '$e'};
    }

    notifyListeners();
  }

  addCleint(uid, receiverId) async {
    var coll = FirebaseFirestore.instance.collection(Database.cleint);
    var id = Helper.generateIdByCodeUnit(uid, receiverId);
    log("id $id");
    final result = await coll.doc(id).get().then((value) {
      return value.exists;
    });
    if (result == false) {
      await coll.doc(id).set(
            CleintModel(
              uid: uid,
              id: id,
              receiverId: receiverId,
              status: 0,
            ).toJson(),
          );
    }
  }
}
