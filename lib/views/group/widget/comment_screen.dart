import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mended/helper/time.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/model/comment_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/provider/group_pro.dart';
import 'package:mended/provider/memeland_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:provider/provider.dart';

class GroupCommentScreen extends StatefulWidget {
  final String id;
  final String gId;
  const GroupCommentScreen({
    super.key,
    required this.id,
    required this.gId,
  });

  @override
  State<GroupCommentScreen> createState() => _GroupCommentScreenState();
}

class _GroupCommentScreenState extends State<GroupCommentScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: SizedBox(
        height: size.height / 100 * 70,
        child: Scaffold(
          backgroundColor: themegreencolor,
          bottomNavigationBar: Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/png/bottom-nav-bar.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: themewhitecolor),
                            controller: commentEditingController,
                            decoration: InputDecoration(
                              hintText: "Add Comment",
                              hintStyle: const TextStyle(
                                color: themewhitecolor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: themewhitecolor,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: themewhitecolor,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return "";
                              }
                              return null;
                            }),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              Provider.of<GroupPro>(context, listen: false)
                                  .postComment(
                                commentEditingController.text,
                                widget.id,
                                widget.gId,
                              );
                              commentEditingController.clear();
                            }
                          },
                          child: const Icon(
                            Icons.send_outlined,
                            color: themewhitecolor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themelightgreencolor.withOpacity(0.2),
                  themelightgreencolor.withOpacity(0.4),
                  themegreencolor.withOpacity(0.6),
                  themegreencolor.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.4, 0.8, 1],
              ),
            ),
            child: Center(
              child: StreamBuilder<List<CommentModel>>(
                stream: filterComments(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final commentslistdata = snapshot.data!;

                    return Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${commentslistdata.length} comments",
                                  style: const TextStyle(
                                    color: themewhitecolor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: CustomIconButton(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: themewhitecolor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 40,
                          color: themewhitecolor,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ListView.separated(
                              itemCount: commentslistdata.length,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final model = commentslistdata[index];
                                return FutureBuilder<AuthM>(
                                    future: Provider.of<AuthPro>(context,
                                            listen: false)
                                        .getUserById(model.uid),
                                    builder: ((context, snapshot) {
                                      if (snapshot.hasData) {
                                        AuthM auth = snapshot.data!;

                                        return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomCircleAvtar(
                                                url: auth.image,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          timeAgo(
                                                              model.dateTime),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                themegreycolor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      model.text,
                                                      style: const TextStyle(
                                                        color: themewhitecolor,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomIconButton(
                                                          onTap: () {
                                                            if (model.like.contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)) {
                                                              final post =
                                                                  Provider.of<
                                                                          GroupPro>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              post.commentLike(
                                                                  1,
                                                                  widget.gId,
                                                                  model.refid,
                                                                  model.id);
                                                            } else {
                                                              final post =
                                                                  Provider.of<
                                                                          GroupPro>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              post.commentLike(
                                                                  0,
                                                                  widget.gId,
                                                                  model.refid,
                                                                  model.id);
                                                            }
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                model.like.contains(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                    ? "assets/images/png/reel-liked.png"
                                                                    : "assets/images/png/reel-like.png",
                                                                width: 28,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                model
                                                                    .like.length
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  color:
                                                                      themewhitecolor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Image.asset(
                                                          "assets/images/png/report.png",
                                                          width: 28,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const Text(
                                                          "Report",
                                                          style: TextStyle(
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
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  color: themewhitecolor,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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
            ),
          ),
        ),
      ),
    );
  }

  Stream<List<CommentModel>> filterComments() => FirebaseFirestore.instance
      .collection(Database.group)
      .doc(widget.gId)
      .collection(Database.groupPost)
      .doc(widget.id)
      .collection(Database.comment)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CommentModel.fromJson(doc.data()))
          .toList());
}
