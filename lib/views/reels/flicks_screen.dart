// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mended/model/auth_model.dart';
// import 'package:mended/model/reels_model.dart';
// import 'package:mended/provider/auth_pro.dart';
// import 'package:mended/provider/flicks_pro.dart';
// import 'package:mended/provider/reels_providers.dart';
// import 'package:mended/theme/colors.dart';
// import 'package:mended/views/chat/Future/future.dart';
// import 'package:mended/views/reels/video_player_item.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';

// class FlicksScreen extends StatefulWidget {
//   FlicksScreen({Key? key}) : super(key: key);

//   @override
//   State<FlicksScreen> createState() => _FlicksScreenState();
// }

// class _FlicksScreenState extends State<FlicksScreen> {
//   int limit = 2;

//   final PageController _pageController = PageController();
//   @override
//   void initState() {
//     super.initState();
//     _pageController.addListener(_scrollListner);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _pageController.dispose();
//   }

//   void _scrollListner() {
//     if (_pageController.position.pixels ==
//         _pageController.position.maxScrollExtent) {
//       setState(() {
//         filter(
//           limit++,
//         );
//       });
//     } else {}
//   }

//   buildProfile(String profilePhoto) {
//     return SizedBox(
//       width: 60,
//       height: 60,
//       child: Stack(children: [
//         Positioned(
//           left: 5,
//           child: Container(
//             width: 50,
//             height: 50,
//             padding: const EdgeInsets.all(1),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25),
//               child: Image(
//                 image: NetworkImage(profilePhoto),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         )
//       ]),
//     );
//   }

//   buildMusicAlbum(String profilePhoto) {
//     return SizedBox(
//       width: 60,
//       height: 60,
//       child: Column(
//         children: [
//           Container(
//               padding: const EdgeInsets.all(11),
//               height: 50,
//               width: 50,
//               decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [
//                       Colors.grey,
//                       Colors.white,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(25)),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(25),
//                 child: Image(
//                   image: NetworkImage(profilePhoto),
//                   fit: BoxFit.cover,
//                 ),
//               ))
//         ],
//       ),
//     );
//   }

//   void countViews(String reelId) {
//     final reelProvider = Provider.of<FlicksPro>(context, listen: false);
//     reelProvider.reelViewAddFunc(reelId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final width = MediaQuery.of(context).size.width;
//     // final height = MediaQuery.of(context).size.height;
//     // final _model_auth = Provider.of<auth_pro>(context, listen: false);
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // RouteNavigator.route(context, add_new_reels_screen());

//           context.pushNamed(
//             'add-reel',
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: SafeArea(
//         child: StreamBuilder<List<FlicksModel>>(
//           stream: filter(limit),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('Something went wrong! ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               final listdata = snapshot.data!..shuffle();
//               return PageView.builder(
//                   pageSnapping: true,
//                   itemCount: snapshot.data!.length,
//                   scrollDirection: Axis.vertical,
//                   itemBuilder: (context, index) {
//                     final data = listdata[index];
//                     countViews(data.id);
//                     return Stack(
//                       children: [
//                        FlicksVideoWidget(
//                                   videoUrl: data.video,
//                                   play: true,
//                                   id: data.id,
//                                 ),
//                         Container(
//                           padding: const EdgeInsets.only(
//                               top: 10, left: 25, right: 25, bottom: 100),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               IntrinsicHeight(
//                                 child: Row(
//                                   children: [
//                                     const Text(
//                                       "Flicks",
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: themewhitecolor,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     const Text(
//                                       "Family",
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: themewhitecolor,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: VerticalDivider(
//                                         color: themewhitecolor,
//                                         thickness: 3,
//                                       ),
//                                     ),
//                                     const Text(
//                                       "Shines",
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: themewhitecolor,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     InkWell(
//                                       onTap: () {
//                                         // RouteNavigator.route(context, FindMenderScreen());
//                                       },
//                                       child: const CircleAvatar(
//                                         backgroundColor: themedarkgreycolor,
//                                         child: Icon(
//                                           Icons.search,
//                                           color: themewhitecolor,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               const Spacer(),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           FutureBuilder<String>(
//                                             future: user_image_get(data.uid),
//                                             builder: ((context, snapshot) {
//                                               if (snapshot.hasData) {
//                                                 String Datara = snapshot.data!;
//                                                 return InkWell(
//                                                   onTap: () {},
//                                                   child: (Datara != "")
//                                                       ? CircleAvatar(
//                                                           radius: 30,
//                                                           backgroundImage:
//                                                               NetworkImage(
//                                                             Datara,
//                                                           ),
//                                                         )
//                                                       : const CircleAvatar(
//                                                           radius: 30,
//                                                           backgroundImage:
//                                                               NetworkImage(
//                                                             "https://img.freepik.com/free-vector/cute-rabbit-holding-carrot-cartoon-vector-icon-illustration-animal-nature-icon-isolated-flat_138676-7315.jpg?w=2000",
//                                                           ),
//                                                         ),
//                                                 );
//                                               } else {
//                                                 return Container();
//                                               }
//                                             }),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           FutureBuilder<String>(
//                                             future: user_name_get(data.uid),
//                                             builder: ((context, snapshot) {
//                                               if (snapshot.hasData) {
//                                                 String Datara = snapshot.data!;
//                                                 return Text(
//                                                   Datara,
//                                                   style: const TextStyle(
//                                                     color: themewhitecolor,
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 );
//                                               } else {
//                                                 return Container();
//                                               }
//                                             }),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         width: size.width / 100 * 70,
//                                         child: Text(
//                                           data.caption,
//                                           style: const TextStyle(
//                                             color: themewhitecolor,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                         data.hashtags,
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 1,
//                                         style: const TextStyle(
//                                           color: themewhitecolor,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Row(
//                                         children: [
//                                           const Icon(
//                                             Icons.music_note,
//                                             color: themewhitecolor,
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           const Text(
//                                             "Original sound - Olivia Rodrigo",
//                                             style: TextStyle(
//                                               color: themewhitecolor,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       StreamBuilder<AuthM>(
//                                           stream: filterMended(data.uid),
//                                           builder: (context, snapshot) {
//                                             if (snapshot.hasError) {
//                                               return Text(
//                                                   'Something went wrong! ${snapshot.error}');
//                                             } else if (snapshot.hasData) {
//                                               final userData = snapshot.data!;
//                                               return userData.email.isEmpty
//                                                   ? const CircularProgressIndicator()
//                                                   : userData.uid ==
//                                                           FirebaseAuth.instance
//                                                               .currentUser!.uid
//                                                       ? const SizedBox()
//                                                       : InkWell(
//                                                           onTap: () {
//                                                             // if (userData.supporterList.contains(FirebaseAuth
//                                                             //       .instance.currentUser!.uid)) {
//                                                             //     final ProviderPost =
//                                                             //         Provider.of<AuthPro>(context,
//                                                             //             listen: false);
//                                                             //     ProviderPost.add_to_supporter_func(
//                                                             //         1, userData.uid);
//                                                             //   } else {
//                                                             //     final ProviderPost =
//                                                             //         Provider.of<AuthPro>(context,
//                                                             //             listen: false);
//                                                             //     ProviderPost.add_to_supporter_func(
//                                                             //         0, userData.uid);
//                                                             //   }
//                                                           },
//                                                           child: userData
//                                                                   .supporterList
//                                                                   .contains(FirebaseAuth
//                                                                       .instance
//                                                                       .currentUser!
//                                                                       .uid)
//                                                               ? const CircleAvatar(
//                                                                   backgroundColor:
//                                                                       themewhitecolor,
//                                                                   child: Icon(
//                                                                     Icons.done,
//                                                                     color:
//                                                                         themeredcolor,
//                                                                     size: 30,
//                                                                   ),
//                                                                 )
//                                                               : const CircleAvatar(
//                                                                   backgroundColor:
//                                                                       themewhitecolor,
//                                                                   child: Icon(
//                                                                     Icons.add,
//                                                                     color:
//                                                                         themeblackcolor,
//                                                                     size: 30,
//                                                                   ),
//                                                                 ),
//                                                         );
//                                             } else {
//                                               return Container();
//                                             }
//                                           }),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           // if (data.like.contains(FirebaseAuth
//                                           //     .instance.currentUser!.uid)) {
//                                           //   final ProviderPost =
//                                           //       Provider.of<reels_pro>(context,
//                                           //           listen: false);
//                                           //   ProviderPost.reels_like_remove(
//                                           //       1, data.reels_id);
//                                           // } else {
//                                           //   final ProviderPost =
//                                           //       Provider.of<reels_pro>(context,
//                                           //           listen: false);
//                                           //   ProviderPost.reels_like_remove(
//                                           //       0, data.reels_id);
//                                           // }
//                                         },
//                                         icon: Icon(
//                                           Icons.favorite,
//                                           color: data.like.contains(FirebaseAuth
//                                                   .instance.currentUser!.uid)
//                                               ? themeredcolor
//                                               : themewhitecolor,
//                                           size: 45,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         data.like.length.toString(),
//                                         style: const TextStyle(
//                                           color: themewhitecolor,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
// //  context.pushNamed('view-reel-comments',queryParams: { 'reel_id': data.reels_id, });
//                                         },
//                                         icon: const Icon(
//                                           Icons.chat_bubble,
//                                           color: themewhitecolor,
//                                           size: 45,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         data.comment.toString(),
//                                         style: const TextStyle(
//                                           color: themewhitecolor,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       const Icon(
//                                         Icons.favorite_border,
//                                         color: themewhitecolor,
//                                         size: 45,
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       const Text(
//                                         "0",
//                                         style: TextStyle(
//                                           color: themewhitecolor,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       InkWell(
//                                         onTap: () async {
// //                                                                                                     await Share.share(
// //                                                               "${data.reels_id}😊\n\n${data.video}");
// // final reelProvider = Provider.of<reels_pro>(context,listen: false);
// // Timer(const Duration(seconds: 2), (){

// // reelProvider.reels_share_func(data.reels_id);
// // });
//                                         },
//                                         child: Column(
//                                           children: [
//                                             const Icon(
//                                               Icons.share,
//                                               color: themewhitecolor,
//                                               size: 45,
//                                             ),
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Text(
//                                               data.shares.toString(),
//                                               style: const TextStyle(
//                                                 color: themewhitecolor,
//                                                 fontSize: 18,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   });
//             } else {
//               return const Center();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Stream<List<FlicksModel>> filter(limit1) => FirebaseFirestore.instance
//       .collection('flicks').where('type', isEqualTo: 0)
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((doc) => FlicksModel.fromJson(doc.data()))
//           .toList());

//   Stream<AuthM> filterMended(String userId) => FirebaseFirestore.instance
//       .collection('auth')
//       .doc(userId)
//       .snapshots()
//       .map((snapshot) => AuthM.fromJson(snapshot.data() ?? {}));
// }
