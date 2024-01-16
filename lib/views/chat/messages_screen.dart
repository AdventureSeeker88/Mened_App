// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:mended_new/navigator.dart';
// import 'package:mended_new/theme/colors.dart';
// import 'package:provider/provider.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen> {
//   TextEditingController searchcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: themewhitecolor,
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(
//               "assets/images/png/home-background.jpg",
//             ),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: ListView(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Chats".toUpperCase(),
//                           style: const TextStyle(
//                             color: themelightgreencolor,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: TextField(
//                   controller: searchcontroller,
//                   decoration: InputDecoration(
//                     fillColor: themewhitecolor.withOpacity(0.3),
//                     filled: true,
//                     hintText: "Search Chat here..",
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     prefixIcon: const Icon(Icons.search),
//                   ),
//                   onChanged: (value) {
//                     print(value);
//                     setState(() {
//                       filterUsers(searchcontroller.text);
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20,
//                 ),
//                 child: Text(
//                   "Quick Chat",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
              
//               const SizedBox(
//                 height: 20,
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20,
//                 ),
//                 child: Text(
//                   "Messages",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               searchcontroller.text.isEmpty
//                   ? StreamBuilder<List<general_message_model>>(
//                       stream: Provider.of<pine_app_chat_pro>(context)
//                           .filter_chats(),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           final chatModel = snapshot.data!;
//                           return chatModel.isEmpty
//                               ? Container()
//                               : Padding(
//                                   padding: const EdgeInsets.only(bottom: 40.0),
//                                   child: ListView.separated(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20),
//                                     primary: false,
//                                     shrinkWrap: true,
//                                     itemCount: chatModel.length,
//                                     itemBuilder: (context, index) {
//                                       final _model = chatModel[index];
//                                       return Container(
//                                         decoration: BoxDecoration(
//                                           color:
//                                               themewhitecolor.withOpacity(0.3),
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                           // boxShadow: const [
//                                           //   BoxShadow(
//                                           //       color: themegreycolor,
//                                           //       blurRadius: 10,
//                                           //       offset: Offset(5, 5))
//                                           // ],
//                                         ),
//                                         child: ListTile(
//                                           onTap: () {
//                                             RouteNavigator.route(
//                                               context,
//                                               chating_screen(
//                                                 color: themeorangecolor,
//                                                 oppister_uid:
//                                                     my_current_userid ==
//                                                             _model.sender_id
//                                                         ? _model.reciver_id
//                                                         : _model.sender_id,
//                                               ),
//                                             );
//                                           },
//                                           leading: FutureBuilder<String>(
//                                               future: user_image_get(
//                                                 my_current_userid ==
//                                                         _model.sender_id
//                                                     ? _model.reciver_id
//                                                     : _model.sender_id,
//                                               ),
//                                               builder: (context, snapshot) {
//                                                 if (snapshot.hasData) {
//                                                   String Datara =
//                                                       snapshot.data!;
//                                                   return CircleAvatar(
//                                                     radius: 30,
//                                                     backgroundImage:
//                                                         NetworkImage(
//                                                       Datara,
//                                                     ),
//                                                   );
//                                                 } else {
//                                                   return const CircleAvatar(
//                                                     radius: 30,
//                                                   );
//                                                 }
//                                               }),
//                                           title: FutureBuilder<String>(
//                                               future: username_get(
//                                                 my_current_userid ==
//                                                         _model.sender_id
//                                                     ? _model.reciver_id
//                                                     : _model.sender_id,
//                                               ),
//                                               builder: (context, snapshot) {
//                                                 if (snapshot.hasData) {
//                                                   String Datara =
//                                                       snapshot.data!;
//                                                   return Text(
//                                                     Datara,
//                                                     style: const TextStyle(
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   );
//                                                 } else {
//                                                   return const Text(
//                                                     "",
//                                                     style: TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color:
//                                                             Palette.themecolor),
//                                                   );
//                                                 }
//                                               }),
//                                           subtitle: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 8.0),
//                                             child: Text(
//                                               _model.last_message,
//                                               style: const TextStyle(
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ),
//                                           trailing: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                 timeAgo(_model.date_time),
//                                                 style: const TextStyle(
//                                                   fontSize: 12,
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10,
//                                               ),
//                                               // CircleAvatar(
//                                               //   radius: 12,
//                                               //   backgroundColor: themelightgreencolor,
//                                               //   child: Text(
//                                               //     messagesmodel[index].messagescount,
//                                               //     style: TextStyle(
//                                               //       color: themewhitecolor,
//                                               //       fontSize: 12,
//                                               //     ),
//                                               //   ),
//                                               // ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     separatorBuilder:
//                                         (BuildContext context, int index) {
//                                       return const SizedBox(
//                                         height: 10,
//                                       );
//                                     },
//                                   ),
//                                 );
//                         } else {
//                           return Container();
//                         }
//                       })
//                   : StreamBuilder<List<auth_m>>(
//                       stream: filterUsers(searchcontroller.text),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           final userModel = snapshot.data!;
//                           return userModel.isEmpty
//                               ? Container()
//                               : ListView.builder(
//                                   primary: false,
//                                   shrinkWrap: true,
//                                   itemCount: userModel.length,
//                                   itemBuilder: (context, index) {
//                                     final model = userModel[index];
//                                     return StreamBuilder<
//                                             List<general_message_model>>(
//                                         stream: filterchatssearch(model.uid),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.hasData) {
//                                             final chatModel = snapshot.data!;
//                                             return chatModel.isEmpty
//                                                 ? Container()
//                                                 : Column(
//                                                     children: List.generate(
//                                                         chatModel.length,
//                                                         (index) {
//                                                       final _model =
//                                                           chatModel[index];
//                                                       return _model.uid_list
//                                                                   .contains(model
//                                                                       .uid) &&
//                                                               _model.uid_list
//                                                                   .contains(auth
//                                                                       .currentUser!
//                                                                       .uid)
//                                                           ? Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .symmetric(
//                                                                       vertical:
//                                                                           8.0),
//                                                               child: Container(
//                                                                 decoration:
//                                                                     BoxDecoration(
//                                                                   color: themewhitecolor
//                                                                       .withOpacity(
//                                                                           0.3),
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               12),
//                                                                   boxShadow: const [
//                                                                     BoxShadow(
//                                                                       color:
//                                                                           themegreycolor,
//                                                                       blurRadius:
//                                                                           10,
//                                                                       offset:
//                                                                           Offset(
//                                                                               5,
//                                                                               5),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                                 child: ListTile(
//                                                                   onTap: () {
//                                                                     RouteNavigator
//                                                                         .route(
//                                                                       context,
//                                                                       chating_screen(
//                                                                         color:
//                                                                             themeorangecolor,
//                                                                         oppister_uid: my_current_userid ==
//                                                                                 _model.sender_id
//                                                                             ? _model.reciver_id
//                                                                             : _model.sender_id,
//                                                                       ),
//                                                                     );
//                                                                   },
//                                                                   leading: FutureBuilder<
//                                                                           String>(
//                                                                       future:
//                                                                           user_image_get(
//                                                                         my_current_userid ==
//                                                                                 _model.sender_id
//                                                                             ? _model.reciver_id
//                                                                             : _model.sender_id,
//                                                                       ),
//                                                                       builder:
//                                                                           (context,
//                                                                               snapshot) {
//                                                                         if (snapshot
//                                                                             .hasData) {
//                                                                           String
//                                                                               Datara =
//                                                                               snapshot.data!;
//                                                                           return CircleAvatar(
//                                                                             radius:
//                                                                                 30,
//                                                                             backgroundImage:
//                                                                                 NetworkImage(
//                                                                               Datara,
//                                                                             ),
//                                                                           );
//                                                                         } else {
//                                                                           return const CircleAvatar(
//                                                                             radius:
//                                                                                 30,
//                                                                           );
//                                                                         }
//                                                                       }),
//                                                                   title: FutureBuilder<
//                                                                           String>(
//                                                                       future:
//                                                                           username_get(
//                                                                         my_current_userid ==
//                                                                                 _model.sender_id
//                                                                             ? _model.reciver_id
//                                                                             : _model.sender_id,
//                                                                       ),
//                                                                       builder:
//                                                                           (context,
//                                                                               snapshot) {
//                                                                         if (snapshot
//                                                                             .hasData) {
//                                                                           String
//                                                                               Datara =
//                                                                               snapshot.data!;
//                                                                           return Text(
//                                                                             Datara,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 14,
//                                                                               fontWeight: FontWeight.bold,
//                                                                             ),
//                                                                           );
//                                                                         } else {
//                                                                           return const Text(
//                                                                             "",
//                                                                             style: TextStyle(
//                                                                                 fontSize: 18,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Palette.themecolor),
//                                                                           );
//                                                                         }
//                                                                       }),
//                                                                   subtitle:
//                                                                       Padding(
//                                                                     padding: const EdgeInsets
//                                                                             .only(
//                                                                         top:
//                                                                             8.0),
//                                                                     child: Text(
//                                                                       _model
//                                                                           .last_message,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   trailing:
//                                                                       Column(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .center,
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .end,
//                                                                     children: [
//                                                                       Text(
//                                                                         timeAgo(
//                                                                           _model
//                                                                               .date_time,
//                                                                         ),
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                         ),
//                                                                       ),
//                                                                       const SizedBox(
//                                                                         height:
//                                                                             10,
//                                                                       ),
//                                                                       // CircleAvatar(
//                                                                       //   radius: 12,
//                                                                       //   backgroundColor: themelightgreencolor,
//                                                                       //   child: Text(
//                                                                       //     messagesmodel[index].messagescount,
//                                                                       //     style: TextStyle(
//                                                                       //       color: themewhitecolor,
//                                                                       //       fontSize: 12,
//                                                                       //     ),
//                                                                       //   ),
//                                                                       // ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             )
//                                                           : Container();
//                                                     }),
//                                                   );
//                                           } else {
//                                             return Container();
//                                           }
//                                         });
//                                   },
//                                 );
//                         } else {
//                           return Container();
//                         }
//                       }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Stream<List<general_message_model>> filterchatssearch(uid) =>
//       FirebaseFirestore.instance
//           .collection("pine_app")
//           .doc("id")
//           .collection("chats")
//           // .where('uid_list', arrayContains: [auth.currentUser!.uid, uid])
//           .snapshots()
//           .map((snapshot) => snapshot.docs
//               .map((doc) => general_message_model.fromJson(doc.data()))
//               .toList());
//   Stream<List<auth_m>> filterUsers(search) => firestore
//       .collection(MainColl().auth)
//       .where('name', isGreaterThanOrEqualTo: search)
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((document) => auth_m.fromJson(document.data()))
//           .toList());
// }
