import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/views/chat/model/InnerMessageModel.dart';
import 'package:mended/views/chat/model/chatting_model.dart';
import 'package:mended/views/chat/pro/ChatPro.dart';
import 'package:mended/views/chat/use_full/id.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/shimer.dart';

import 'package:provider/provider.dart';


class chating_screen extends StatefulWidget {
  // final Color color;
  final String id;

  const chating_screen({
    super.key,
    required this.id,
    // required this.color,
  });

  @override
  State<chating_screen> createState() => _chating_screenState();
}

class _chating_screenState extends State<chating_screen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    availableChatUser(widget.id, true);
    super.initState();
  }

  @override
  void dispose() {
    availableChatUser(widget.id, false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      availableChatUser(widget.id, true);
    } else {
      availableChatUser(widget.id, false);
    }
  }

  void availableChatUser(oppisterUid, bool condition) {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(
          get_chat_id(
            FirebaseAuth.instance.currentUser!.uid,
            oppisterUid,
          ),
        )
        .update({
      'availableUser': condition
          ? FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
          : FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
    });
  }

  TextEditingController _msg_controller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Uint8List? _image;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              themewhitecolor,
              themewhitecolor,
              themewhitecolor,
              themebackgroundbottomcolor,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    StreamBuilder<List<AuthM>>(
                        stream: Provider.of<AuthPro>(context)
                            .get_my_profile(widget.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                                'Something went wrong! ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final datamodel = snapshot.data!;
                            final model = datamodel[0];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  CustomIconButton(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CustomCircleAvtar(
                                    url: model.image,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Text(
                                      //   "Online",
                                      //   style: TextStyle(
                                      //     color: Palette.themecolor,
                                      //     fontSize: 12,
                                      //     fontWeight: FontWeight.w500,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // CustomIconButton(
                                  //   onTap: () {},
                                  //   child: const Icon(
                                  //     CupertinoIcons.phone,
                                  //     color: Palette.themecolor,
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   width: 25,
                                  // ),
                                  // CustomIconButton(
                                  //   onTap: () async {
                                  //     // FirebaseFirestore.instance
                                  //     //     .collection("call-coll")
                                  //     //     .where('callerId',
                                  //     //         isEqualTo: widget.id)
                                  //     //     .where("status", isEqualTo: 1)
                                  //     //     .get()
                                  //     //     .then((value) {
                                  //     //   final post = Provider.of<CallPro>(
                                  //     //       context,
                                  //     //       listen: false);
                                  //     //   if (value.docs.isEmpty) {
                                  //     //     post.createCall(
                                  //     //         widget.id, context);
                                  //     //   } else {
                                  //     //     post.joinCall(
                                  //     //         value.docs[0]['callData'],
                                  //     //         context);
                                  //     //   }
                                  //     // });
                                  //   },
                                  //   child: const Icon(
                                  //     CupertinoIcons.video_camera,
                                  //     color: Palette.themecolor,
                                  //     size: 35,
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 80.0),
                          child: messages(),
                        ),
                      ),
                    ),
                  ],
                ),
                BottomWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget BottomWidget() {
    return Form(
      key: _formkey,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextFormField(
          controller: _msg_controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: themewhitecolor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            alignLabelWithHint: true,
            label: IntrinsicHeight(
              child: Row(
                children: [
                  CustomIconButton(
                    onTap: () {},
                    child: const Icon(
                      Icons.add,
                      color: Palette.themecolor,
                    ),
                  ),
                  const VerticalDivider(
                    width: 25,
                  ),
                  const Text(
                    "Write your message here..",
                  ),
                ],
              ),
            ),
            hintText: "Write your message here..",
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomIconButton(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    final post = Provider.of<ChatPro>(context, listen: false);
                    // ignore: use_build_context_synchronously
                    post.send_text_message(
                        widget.id, _msg_controller.text, context);
                    _msg_controller.clear();
                  }
                  // print(widget.id);
                  // print(FirebaseAuth.instance.currentUser!.uid);

                  // FirebaseFirestore.instance
                  //     .collection("chats")
                  //     .get()
                  //     .then((value) {
                  //   value.docs.forEach((element) {
                  //     FirebaseFirestore.instance
                  //         .collection("chats")
                  //         .doc(element.id)
                  //         .collection('messages')
                  //         .get()
                  //         .then((value) {
                  //       value.docs.forEach((element1) {
                  //         FirebaseFirestore.instance
                  //             .collection("chats")
                  //             .doc(element.id)
                  //             .collection('messages')
                  //             .doc(element1.id)
                  //             .delete();
                  //       });
                  //     });
                  //   });
                  // });
                },
                child: const CircleAvatar(
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    Icons.send,
                    color: themewhitecolor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
      ),
    );
    // Align(
    //   alignment: Alignment.bottomCenter,
    //   child: Form(
    //       key: _formkey,
    //       child: Row(
    //         children: [
    //           Expanded(
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: TextFormField(
    //                 controller: _msg_controller,
    //                 decoration: InputDecoration(
    //                   filled: true,
    //                   suffixIcon: IconButton(
    //                     onPressed: () {
    //                       showCupertinoModalPopup(
    //                         context: context,
    //                         builder: (context) => CupertinoActionSheet(
    //                           actions: [
    //                             CupertinoActionSheetAction(
    //                               isDefaultAction: true,
    //                               onPressed: () async {
    //                                 Uint8List file =
    //                                     await pickImage(ImageSource.gallery);
    //                                 _image = file;
    //                                 if (_image != null) {
    //                                   // ignore: use_build_context_synchronously
    //                                   final post = Provider.of<ChatPro>(context,
    //                                       listen: false);
    //                                   // ignore: use_build_context_synchronously
    //                                   post.send_image(
    //                                     widget.id,
    //                                     _image!,
    //                                     context,
    //                                   );
    //                                   Navigator.pop(context);
    //                                 }
    //                               },
    //                               child: Row(
    //                                 children: const [
    //                                   Icon(
    //                                     CupertinoIcons.photo,
    //                                     color: themeblackcolor,
    //                                   ),
    //                                   SizedBox(
    //                                     width: 10,
    //                                   ),
    //                                   Text(
    //                                     "Gallery",
    //                                     style: TextStyle(
    //                                       color: themeblackcolor,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             CupertinoActionSheetAction(
    //                               isDefaultAction: true,
    //                               onPressed: () async {
    //                                 Navigator.pop(context);
    //                                 Uint8List file =
    //                                     await pickImage(ImageSource.camera);
    //                                 _image = file;
    //                                 if (_image != null) {
    //                                   // ignore: use_build_context_synchronously
    //                                   final post =
    //                                       // ignore: use_build_context_synchronously
    //                                       Provider.of<ChatPro>(context,
    //                                           listen: false);
    //                                   // ignore: use_build_context_synchronously
    //                                   post.send_image(
    //                                     widget.id,
    //                                     _image!,
    //                                     context,
    //                                   );
    //                                 }
    //                               },
    //                               child: Row(
    //                                 children: const [
    //                                   Icon(
    //                                     CupertinoIcons.camera_fill,
    //                                     color: themeblackcolor,
    //                                   ),
    //                                   SizedBox(
    //                                     width: 10,
    //                                   ),
    //                                   Text(
    //                                     "Camera",
    //                                     style: TextStyle(
    //                                       color: themeblackcolor,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                           cancelButton: CupertinoActionSheetAction(
    //                             isDestructiveAction: true,
    //                             onPressed: () {
    //                               Navigator.pop(context);
    //                             },
    //                             child: const Text("Cancel"),
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                     icon: const Icon(
    //                       Icons.attach_file,
    //                       color: themedarkgreycolor,
    //                     ),
    //                   ),
    //                   fillColor: themewhitecolor,
    //                   border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(30),
    //                   ),
    //                   focusedBorder: OutlineInputBorder(
    //                     borderSide: const BorderSide(color: themeblackcolor),
    //                     borderRadius: BorderRadius.circular(30),
    //                   ),
    //                   hintText: "Write a Message...",
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: InkWell(
    //               onTap: () {
    //                 if (_formkey.currentState!.validate()) {
    //                   final post = Provider.of<ChatPro>(context, listen: false);
    //                   // ignore: use_build_context_synchronously
    //                   post.send_text_message(
    //                       widget.id, _msg_controller.text, context);
    //                   _msg_controller.clear();
    //                 }
    //               },
    //               child: CircleAvatar(
    //                 backgroundColor: widget.color,
    //                 child: const Icon(
    //                   Icons.send,
    //                   color: themewhitecolor,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       )),
    // );
  }

  Widget messages() {
    return StreamBuilder<List<inner_message_model>>(
        stream: filter_chats(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final model = snapshot.data!;
            return ListView.builder(
                primary: false,
                shrinkWrap: true,
                reverse: true,
                itemCount: model.length,
                itemBuilder: ((context, index) {
                  final _model = model[index];
                  return _model.type == 0
                      ? text_messages(
                          _model.sender_id ==
                              FirebaseAuth.instance.currentUser!.uid,
                          _model.msg,
                          _model.date_time,
                          _model.seen,
                          _model.message_id,
                          model.length,
                          index,
                        )
                      : _model.type == 1
                          ? image_widget(
                              _model.sender_id ==
                                  FirebaseAuth.instance.currentUser!.uid,
                              _model.msg,
                              index)
                          : Container();
                }));
          } else {
            return Container();
          }
        });
  }

  Widget text_messages(
    bool isMe,
    text,
    Timestamp datetime,
    List seen,
    message_id,
    int length,
    int index,
  ) {
    if (seen.length == 1) {
      final post = Provider.of<ChatPro>(context, listen: false);
      post.addseen(widget.id, message_id);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: isMe
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                //   decoration: BoxDecoration(
                //     color: widget.color,
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(12),
                //       bottomLeft: Radius.circular(12),
                //       bottomRight: Radius.circular(12),
                //     ),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(2.0),
                //     child: Stack(
                //       alignment: Alignment.bottomRight,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(right: 20.0),
                //           child: Text(
                //             DateFormat.jm().format(datetime.toDate()),
                //             style: const TextStyle(
                //                 color: themewhitecolor, fontSize: 12),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(right: 80.0),
                //           child: Text(
                //             text,
                //             style: const TextStyle(
                //               color: themewhitecolor,
                //               fontSize: 16,
                //             ),
                //           ),
                //         ),
                //         seen.length == 1
                //             ? const Icon(
                //                 Icons.check,
                //                 color: themewhitecolor,
                //                 size: 16,
                //               )
                //             : Stack(
                //                 children: const [
                //                   Icon(
                //                     Icons.check,
                //                     color: themebluecolor,
                //                     size: 20,
                //                   ),
                //                   Icon(
                //                     Icons.check,
                //                     color: themebluecolor,
                //                     size: 16,
                //                   )
                //                 ],
                //               ),
                //       ],
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Palette.themecolor.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: themeblackcolor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                //   decoration: BoxDecoration(
                //     color: themelightgreencolor.withOpacity(0.2),
                //     borderRadius: const BorderRadius.only(
                //       topRight: Radius.circular(12),
                //       bottomLeft: Radius.circular(12),
                //       bottomRight: Radius.circular(12),
                //     ),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(2.0),
                //     child: Stack(
                //       alignment: Alignment.bottomRight,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(right: 20.0),
                //           child: Text(
                //             DateFormat.jm().format(datetime.toDate()),
                //             style: const TextStyle(
                //                 color: themeblackcolor, fontSize: 12),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(right: 80.0),
                //           child: Text(
                //             text,
                //             style: const TextStyle(
                //               color: themeblackcolor,
                //               fontSize: 16,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: themegreycolor.withOpacity(0.4),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: themeblackcolor,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget image_widget(bool isMe, text, index) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          // RouteNavigator.route(
          //     context,
          //     Image.network(
          //       text,
          //       fit: BoxFit.contain,
          //     ));
        },
        child: isMe
            ? Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: size.width / 100 * 50,
                  padding: const EdgeInsets.symmetric(
                    vertical: 120,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(text),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width / 100 * 50,
                    padding: const EdgeInsets.symmetric(
                      vertical: 150,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(text),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  index == (0)
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        widget.id, "🧡", context);
                                  },
                                  child: const Text(
                                    "🧡",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        widget.id, "👍", context);
                                  },
                                  child: const Text(
                                    "👍",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        widget.id, "😂", context);
                                  },
                                  child: const Text(
                                    "😂",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        widget.id, "😍", context);
                                  },
                                  child: const Text(
                                    "😍",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final post = Provider.of<ChatPro>(context,
                                        listen: false);

                                    post.send_text_message(
                                        widget.id, "😡", context);
                                  },
                                  child: const Text(
                                    "😡",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
      ),
    );
  }

  Stream<List<inner_message_model>> filter_chats() => FirebaseFirestore.instance
      .collection("chats")
      .doc(get_chat_id(widget.id, FirebaseAuth.instance.currentUser!.uid))
      .collection("messages")
      .orderBy('date_time', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => inner_message_model.fromJson(doc.data()))
          .toList());

  Stream<List<general_message_model>> filtergeneralchats() => FirebaseFirestore
      .instance
      .collection("chats")
      .where('chat_id',
          isEqualTo:
              get_chat_id(widget.id, FirebaseAuth.instance.currentUser!.uid))
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => general_message_model.fromJson(doc.data()))
          .toList());
}
