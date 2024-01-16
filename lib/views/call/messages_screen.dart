import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/helper/time.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/views/chat/Future/future.dart';
import 'package:mended/views/chat/model/chatting_model.dart';
import 'package:mended/views/chat/screen/chating_screen.dart';
import 'package:mended/widgets/custom_icon_button.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CustomIconButton(
                        onTap: () {
                          // Navigator.pop(context);
                          context.pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: themewhitecolor,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Messages",
                          style: TextStyle(
                            color: themewhitecolor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      controller: searchcontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: themegreycolor.withOpacity(0.5),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: themewhitecolor,
                        ),
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          color: themewhitecolor,
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          filterUsers(searchcontroller.text);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            searchcontroller.text.isEmpty
                ? StreamBuilder<List<general_message_model>>(
                    stream: filter_chats(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final chatModel = snapshot.data!;
                        return chatModel.isEmpty
                            ? Center(
                                child: Image.asset(
                                  "assets/images/png/no_message.png",
                                  height: 350,
                                  // width: 250,
                                ),
                              )
                            : ListView.separated(
                                itemCount: chatModel.length,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final _model = chatModel[index];
                                  return ListTile(
                                    minVerticalPadding: 0,
                                    leading: FutureBuilder<String>(
                                        future: user_image_get(
                                          FirebaseAuth.instance.currentUser!
                                                      .uid ==
                                                  _model.sender_id
                                              ? _model.reciver_id
                                              : _model.sender_id,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            String Datara = snapshot.data!;
                                            return CircleAvatar(
                                              backgroundColor:
                                                  themelightgreencolor,
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                (Datara != "")
                                                    ? Datara
                                                    : "https://img.freepik.com/free-vector/cute-rabbit-holding-carrot-cartoon-vector-icon-illustration-animal-nature-icon-isolated-flat_138676-7315.jpg?w=2000",
                                              ),
                                            );
                                          } else {
                                            return const CircleAvatar(
                                              backgroundColor:
                                                  themelightgreencolor,
                                              radius: 30,
                                            );
                                          }
                                        }),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FutureBuilder<String>(
                                            future: user_name_get(
                                              FirebaseAuth.instance.currentUser!
                                                          .uid ==
                                                      _model.sender_id
                                                  ? _model.reciver_id
                                                  : _model.sender_id,
                                            ),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                String Datara = snapshot.data!;
                                                return Text(
                                                  Datara,
                                                  style: const TextStyle(
                                                    color: themewhitecolor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                        Text(
                                          timeAgo(_model.date_time),
                                          style: const TextStyle(
                                            color: themegreycolor,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        _model.last_message,
                                        style: const TextStyle(
                                          color: themegreycolor,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                        Go.route(
                                                                context,
                                                                chating_screen(
                                                                  id: FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .uid ==
                                                                          _model
                                                                              .sender_id
                                                                      ? _model
                                                                          .reciver_id
                                                                      : _model
                                                                          .sender_id,
                                                                ),
                                                              );
                                      // context.pushNamed('inner-chatting',
                                      //     queryParams: {
                                      //       'opposite_user_uid': FirebaseAuth
                                      //                   .instance
                                      //                   .currentUser!
                                      //                   .uid ==
                                      //               _model.sender_id
                                      //           ? _model.reciver_id
                                      //           : _model.sender_id,
                                      //     });
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                    color: themewhitecolor,
                                    height: 40,
                                  );
                                },
                              );
                      } else {
                        return Container();
                      }
                    })
                : StreamBuilder<List<AuthM>>(
                    stream: filterUsers(searchcontroller.text),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final userModel = snapshot.data!;
                        return userModel.isEmpty
                            ? Container()
                            : ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: userModel.length,
                                itemBuilder: (context, index) {
                                  final model = userModel[index];
                                  return StreamBuilder<
                                          List<general_message_model>>(
                                      stream: filterchatssearch(model.uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final chatModel = snapshot.data!;
                                          return chatModel.isEmpty
                                              ? Container()
                                              : Column(
                                                  children: List.generate(
                                                      chatModel.length,
                                                      (index) {
                                                    final _model =
                                                        chatModel[index];
                                                    return _model.uid_list
                                                                .contains(model
                                                                    .uid) &&
                                                            _model.uid_list.contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                        ? ListTile(
                                                            minVerticalPadding:
                                                                0,
                                                            leading: FutureBuilder<
                                                                    String>(
                                                                future:
                                                                    user_image_get(
                                                                  FirebaseAuth.instance.currentUser!
                                                                              .uid ==
                                                                          _model
                                                                              .sender_id
                                                                      ? _model
                                                                          .reciver_id
                                                                      : _model
                                                                          .sender_id,
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    String
                                                                        Datara =
                                                                        snapshot
                                                                            .data!;
                                                                    return CircleAvatar(
                                                                      backgroundColor:
                                                                          themelightgreencolor,
                                                                      radius:
                                                                          30,
                                                                      backgroundImage:
                                                                          NetworkImage(
                                                                        Datara,
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return const CircleAvatar(
                                                                      backgroundColor:
                                                                          themelightgreencolor,
                                                                      radius:
                                                                          30,
                                                                    );
                                                                  }
                                                                }),
                                                            title: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                FutureBuilder<
                                                                        String>(
                                                                    future:
                                                                        user_name_get(
                                                                      FirebaseAuth.instance.currentUser!.uid ==
                                                                              _model
                                                                                  .sender_id
                                                                          ? _model
                                                                              .reciver_id
                                                                          : _model
                                                                              .sender_id,
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasData) {
                                                                        String
                                                                            Datara =
                                                                            snapshot.data!;
                                                                        return Text(
                                                                          Datara,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                themewhitecolor,
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Container();
                                                                      }
                                                                    }),
                                                                Text(
                                                                  timeAgo(_model
                                                                      .date_time),
                                                                  style:
                                                                      const TextStyle(
                                                                    color:
                                                                        themegreycolor,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            subtitle: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child: Text(
                                                                _model
                                                                    .last_message,
                                                                style:
                                                                    const TextStyle(
                                                                  color:
                                                                      themegreycolor,
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              Go.route(
                                                                context,
                                                                chating_screen(
                                                                  id: FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .uid ==
                                                                          _model
                                                                              .sender_id
                                                                      ? _model
                                                                          .reciver_id
                                                                      : _model
                                                                          .sender_id,
                                                                ),
                                                              );

                                                              // RouteNavigator
                                                              //     .route(
                                                              //   context,
                                                              //   chating_screen(
                                                              //     oppister_uid: FirebaseAuth
                                                              //                 .instance
                                                              //                 .currentUser!
                                                              //                 .uid ==
                                                              //             _model
                                                              //                 .sender_id
                                                              //         ? _model
                                                              //             .reciver_id
                                                              //         : _model
                                                              //             .sender_id,
                                                              //   ),
                                                              // );
                                                            },
                                                          )
                                                        : Container();
                                                  }),
                                                );
                                        } else {
                                          return Container();
                                        }
                                      });
                                },
                              );
                      } else {
                        return Container();
                      }
                    }),
          ],
        ),
      ),
    );
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
  Stream<List<general_message_model>> filterchatssearch(uid) =>
      FirebaseFirestore.instance
          .collection("chats")
          .where('uid_list', arrayContains: [
            FirebaseAuth.instance.currentUser!.uid,
          ])
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => general_message_model.fromJson(doc.data()))
              .toList());
  Stream<List<AuthM>> filterUsers(search) => FirebaseFirestore.instance
      .collection('auth')
      .where('user_name', isGreaterThanOrEqualTo: search)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => AuthM.fromJson(document.data()))
          .toList());
}
