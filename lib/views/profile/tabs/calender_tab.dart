import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mended/model/session_model.dart';
import 'package:mended/provider/call_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/utils/future_methods.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class CalenderTab extends StatefulWidget {
  const CalenderTab({Key? key}) : super(key: key);

  @override
  State<CalenderTab> createState() => _CalenderTabState();
}

class _CalenderTabState extends State<CalenderTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "07 September, 2023",
                style: TextStyle(
                  color: themegreycolor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<List<SessionModel>>(
                stream: sessionStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!;

                    return ListView.separated(
                      itemCount: data.length,
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final model = data[index];

                        log("Date Time:${Timestamp.now()}");
                        log("${model.sessionDate.toDate()}");
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: themewhitecolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: themelightgreenshade2color,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.calendar_today,
                                  color: themewhitecolor,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<String>(
                                      future: userNameGet(
                                        model.uid,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          String getD = snapshot.data!;
                                          return Text(
                                            getD,
                                            style: const TextStyle(
                                              color: themelightgreencolor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        } else {
                                          return const Text(
                                            "",
                                            style: TextStyle(
                                              color: themelightgreencolor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        }
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.time,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          "${model.startTime} - ${model.endTime}"),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),

                              SessionButtonWidget(model: model)
                              // CustomSimpleRoundedButton(
                              //   onTap: () {},
                              //   height: 40,
                              //   width: size.width / 100 * 22,
                              //   buttoncolor:
                              //       themelightgreencolor.withOpacity(0.1),
                              //   borderRadius: BorderRadius.circular(30),
                              //   child: const Text(
                              //     "Join",
                              //     style: TextStyle(
                              //       color: themelightgreencolor,
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: themegreycolor,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<List<SessionModel>> sessionStream() => FirebaseFirestore.instance
      .collection(Database.session)
      .where("cleintId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy("sessionDate", descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => SessionModel.fromJson(doc.data()))
          .toList());
}

class SessionButtonWidget extends StatefulWidget {
  final SessionModel model;
  const SessionButtonWidget({super.key, required this.model});

  @override
  State<SessionButtonWidget> createState() => _SessionButtonWidgetState();
}

class _SessionButtonWidgetState extends State<SessionButtonWidget> {
  bool buttonShow = false;
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (Timer) {
      sessionTimeCheckFunc();
    });
    super.initState();
  }

  sessionTimeCheckFunc() {
    final currentTime = Timestamp.now();

    if (currentTime.seconds >= widget.model.sessionDate.seconds &&
        currentTime.seconds <= widget.model.sessionEndDate.seconds) {
      setState(() {
        buttonShow = true;
      });

      log("showJoinButton: true");
    } else {
      setState(() {
        buttonShow = false;
      });
      log("showJoinButton: false");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomSimpleRoundedButton(
      onTap: () {
        if (buttonShow) {
          log("Uid: ${FirebaseAuth.instance.currentUser!.uid}");
          FirebaseFirestore.instance
              .collection(Database.callColl)
              .where('receiverId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where("status", isEqualTo: 0)
              .get()
              .then((value) {
            log(value.docs.toString());
            // log("value.docs[0].data(): ${value.docs[0].data()['callData']!['channelId']}");
            final post = Provider.of<CallPro>(context, listen: false);
            if (value.docs.isEmpty) {
              log("createCall"); 
        
               post.createCall(10, "Hello world", 5,
                 widget.model.cleintId, context);

            } else {
              log("value.docs[0].data(): ${value.docs[0].data()['callData']}");
              log("joinCall");
              post.joinCall(value.docs[0].data()['callData'], context);

              // post.joinCall(value.docs[0]['callData'],
              //     FirebaseAuth.instance.currentUser!.uid, 5, context);
            }
          });
        } else {
          log("elseeee");
        }
      },
      height: 40,
      width: size.width / 100 * 22,
      buttoncolor: Palette.themecolor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
      child: Text(
        "Join Call",
        style: TextStyle(
          color: buttonShow
              ? Palette.themecolor
              : Palette.themecolor.withOpacity(0.5),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
