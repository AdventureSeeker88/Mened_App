import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/helper/time.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/model/group_model.dart';
import 'package:mended/model/group_post_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/provider/group_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/views/group/widget/comment_screen.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:mended/widgets/toast.dart';
import 'package:mended/widgets/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class GroupPostScreen extends StatefulWidget {
  final String id;

  const GroupPostScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<GroupPostScreen> createState() => _GroupPostScreenState();
}

class _GroupPostScreenState extends State<GroupPostScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<GroupModel>(
        stream: groupDetail(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final model = snapshot.data!;
            return model.title.isEmpty
                ? Expanded(
                    child: Center(
                        child: Image.asset(
                      "assets/images/png/mended-logo-1.png",
                    )),
                  )
                : Scaffold(
                    backgroundColor: themegreencolor,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endDocked,
                    floatingActionButton: GestureDetector(
                      onTap: () {
                        Go.named(
                            context, Routes.groupaddPost, {'id': widget.id});
                      },
                      child: Image.asset(
                        "assets/images/png/floating-button.png",
                      ),
                    ),
                    body: SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 25.0),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: CustomIconButton(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: themewhitecolor,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    model.title,
                                    style: const TextStyle(
                                      color: themewhitecolor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "dripping",
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: CustomTextButton(
                                      buttonText: "Settings",
                                      onTap: () {
                                      
                                        if (model.uid ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid) {
                                          Go.named(context, Routes.groupSetting,
                                              {'id': model.id});
                                        } else {
                                          Go.named(
                                              context,
                                              Routes.editGroupProfile,
                                              {'id': model.id});
                                        }
                                      },
                                      textstyle: const TextStyle(
                                        color: themewhitecolor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Container(
                                          height: 200,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: themewhitecolor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 60.0,
                                        ),
                                        child: Column(
                                          children: [
                                            CustomCircleAvtar(
                                              url: model.image,
                                            ),
                                            Text(
                                              model.title,
                                              style: const TextStyle(
                                                color: themegreencolor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.people_outline,
                                                  color: themegreytextcolor,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  "${model.member.length} Members",
                                                  style: const TextStyle(
                                                    color: themegreytextcolor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Icon(
                                                  (model.type == "Public")
                                                      ? Icons.lock_open
                                                      : Icons.lock,
                                                  color: themegreytextcolor,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  model.type,
                                                  style: const TextStyle(
                                                    color: themegreytextcolor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 80),
                                              child: CustomElevatedButton(
                                                onTap: () {
                                                  customToast(
                                                      "Comming Soon", context);
                                                },
                                                buttonSize: const Size(300, 40),
                                                buttoncolor:
                                                    themelightgreencolor
                                                        .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                elevation: 5,
                                                child:  Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.videocam_outlined,
                                                      color: themewhitecolor,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Start Group Therapy",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: themewhitecolor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                 
                                  StreamBuilder<List<GroupPostModel>>(
                                    stream: streamPost(widget.id),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text(
                                            'Something went wrong! ${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        final postData = snapshot.data!;
                                        return ListView.separated(
                                          itemCount: postData.length,
                                          primary: false,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return FutureBuilder<AuthM>(
                                                future: Provider.of<AuthPro>(
                                                        context,
                                                        listen: false)
                                                    .getUserById(
                                                        postData[index].uid),
                                                builder: ((context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    AuthM auth = snapshot.data!;
                                                    return InkWell(
                                                      onLongPress: () async {
                                                        if ((postData[index]
                                                                .image !=
                                                            '')) {
                                                          await Share.share(
                                                              "${postData[index].title}😊\n${postData[index].description}\n\n${postData[index].image}");
                                                        } else if (postData[
                                                                    index]
                                                                .doc !=
                                                            '') {
                                                          await Share.share(
                                                              "${postData[index].title}😊\n${postData[index].description}\n\n${postData[index].doc}");
                                                        } else {
                                                          await Share.share(
                                                              "${postData[index].title}😊\n\n${postData[index].description}");
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Go.named(
                                                                    context,
                                                                    Routes
                                                                        .menderProfile,
                                                                    {
                                                                      'id': auth
                                                                          .uid
                                                                    });
                                                              },
                                                              child:
                                                                  CustomCircleAvtar(
                                                                url: auth.uid,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        auth.name,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              themewhitecolor,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            timeAgo(postData[index].posted_date),
                                                                            style:
                                                                                const TextStyle(
                                                                              color: themegreycolor,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          (postData[index].uid != FirebaseAuth.instance.currentUser!.uid)
                                                                              ? const SizedBox()
                                                                              : InkWell(
                                                                                  onTap: () {
                                                                                    Provider.of<GroupPro>(context, listen: false).deletePost(
                                                                                      postData[index].groupId,
                                                                                      postData[index].id,
                                                                                      context,
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                      color: themewhitecolor,
                                                                                    ),
                                                                                    child: const Text(
                                                                                      "Delete",
                                                                                      style: TextStyle(
                                                                                        color: themelightgreencolor,
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    postData[
                                                                            index]
                                                                        .description,
                                                                    style:
                                                                        const TextStyle(
                                                                      color:
                                                                          themewhitecolor,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  (postData[index]
                                                                              .image !=
                                                                          '')
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () {
                                                                            // RouteNavigator.route(
                                                                            //     context,
                                                                            //     Hero(
                                                                            //       tag: postData[index].post_id,
                                                                            //       child: Image.network(
                                                                            //         postData[index].image,
                                                                            //       ),
                                                                            //     ));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.all(2),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: themewhitecolor,
                                                                              borderRadius: BorderRadius.circular(16),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(16),
                                                                              child: Hero(
                                                                                tag: postData[index].id,
                                                                                child: Image.network(
                                                                                  postData[index].image,
                                                                                  height: 200,
                                                                                  width: size.width,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : (postData[index].doc !=
                                                                              '')
                                                                          ? InkWell(
                                                                              onTap: () {
                                                                                // log("Pdf: ${postData[index].doc}");
                                                                                // context.pushNamed('view-group-post-pdf', queryParams: {
                                                                                //   .doc': postData[index].doc,
                                                                                // });

                                                                                // RouteNavigator.route(context, GroupPdfViewScreen(url: postData[index].doc));
                                                                              },
                                                                              child: Container(
                                                                                padding: const EdgeInsets.all(2),
                                                                                decoration: BoxDecoration(
                                                                                  color: themewhitecolor,
                                                                                  borderRadius: BorderRadius.circular(16),
                                                                                ),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(16),
                                                                                  child: Image.asset(
                                                                                    "assets/images/png/pdf_image.png",
                                                                                    height: 200,
                                                                                    width: size.width,
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showModalBottomSheet(
                                                                            isScrollControlled:
                                                                                true,
                                                                            shape:
                                                                                const RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.vertical(
                                                                                top: Radius.circular(25),
                                                                              ),
                                                                            ),
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                StatefulBuilder(
                                                                              builder: (context, setState) => Padding(
                                                                                padding: EdgeInsets.only(
                                                                                  bottom: MediaQuery.of(context).viewInsets.bottom,
                                                                                ),
                                                                                child: GroupCommentScreen(
                                                                                  id: postData[index].id,
                                                                                  gId: postData[index].groupId,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Image.asset(
                                                                              "assets/images/png/reel-messages.png",
                                                                              width: 28,
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text(
                                                                              "${postData[index].comment} comments",
                                                                              style: const TextStyle(
                                                                                color: themewhitecolor,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const Spacer(),
                                                                      CustomIconButton(
                                                                        onTap:
                                                                            () {
                                                                          final groupProvider = Provider.of<GroupPro>(
                                                                              context,
                                                                              listen: false);
                                                                          groupProvider.postLike(
                                                                              (postData[index].like.contains(FirebaseAuth.instance.currentUser!.uid))
                                                                                  ? 0
                                                                                  : 1,
                                                                              [
                                                                                FirebaseAuth.instance.currentUser!.uid
                                                                              ],
                                                                              widget.id,
                                                                              postData[index].id,
                                                                              context);
                                                                        },
                                                                        child: (postData[index].like.contains(FirebaseAuth.instance.currentUser!.uid))
                                                                            ? Container(
                                                                                padding: const EdgeInsets.symmetric(
                                                                                  vertical: 8,
                                                                                  horizontal: 16,
                                                                                ),
                                                                                decoration: BoxDecoration(
                                                                                  color: Palette.themecolor,
                                                                                  borderRadius: BorderRadius.circular(30),
                                                                                ),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      "assets/images/png/reel-like.png",
                                                                                      width: 28,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    Text(
                                                                                      "${postData[index].like.length} likes",
                                                                                      style: const TextStyle(
                                                                                        color: themewhitecolor,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : Row(
                                                                                children: [
                                                                                  Image.asset(
                                                                                    "assets/images/png/reel-like.png",
                                                                                    width: 28,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text(
                                                                                    "${postData[index].like.length} likes",
                                                                                    style: const TextStyle(
                                                                                      color: themewhitecolor,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                      ),
                                                                      const Spacer(),
                                                                      Image
                                                                          .asset(
                                                                        "assets/images/png/report.png",
                                                                        width:
                                                                            28,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      const Text(
                                                                        "Report",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              themewhitecolor,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }));
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              height: 15,
                                            );
                                          },
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          enabled: true,
                                          child: SingleChildScrollView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            child: Column(
                                              children: List.generate(
                                                3,
                                                (index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 15,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // mainAxisSize:
                                                      //     MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor:
                                                                  themewhitecolor,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  height: 10,
                                                                  width:
                                                                      size.width /
                                                                          100 *
                                                                          85,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        themewhitecolor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Container(
                                                                  height: 10,
                                                                  width:
                                                                      size.width /
                                                                          100 *
                                                                          85,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        themewhitecolor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 200,
                                                          width: size.width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                themewhitecolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          } else {
            return Container();
          }
        });
  }

  Stream<GroupModel> groupDetail(String id) {
    return FirebaseFirestore.instance
        .collection(Database.group)
        .doc(id)
        .snapshots()
        .map((snapshot) => GroupModel.fromJson(snapshot.data() ?? {}));
  }

  Stream<List<GroupPostModel>> streamPost(String groupId) =>
      FirebaseFirestore.instance
          .collection(Database.group)
          .doc(groupId)
          .collection(Database.groupPost)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) => GroupPostModel.fromJson(document.data()))
              .toList());
}
