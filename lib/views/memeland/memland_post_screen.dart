import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/model/memeland_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/provider/memeland_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/views/flicks/widget/add_supported_button.dart';
import 'package:mended/views/memeland/comment_sheet.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:provider/provider.dart';

class MemelandPostScreen extends StatefulWidget {
  final String id;
  const MemelandPostScreen({super.key, required this.id});

  @override
  State<MemelandPostScreen> createState() => _MemelandPostScreenState();
}

class _MemelandPostScreenState extends State<MemelandPostScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      body: FutureBuilder(
        future: Provider.of<MemelandPro>(context, listen: false)
            .getMemeById(widget.id, context),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final auth = AuthM.fromJson(snapshot.data!["user"]);
            final memeland = MemelandModel.fromJson(snapshot.data!["memeland"]);

            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.network(
                    memeland.image,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: themewhitecolor,
                            )),
                      ),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Memeland",
                          style: TextStyle(
                            fontSize: 36,
                            color: themewhitecolor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "dripping",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 25, right: 25, bottom: 40),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Go.named(context, Routes.menderProfile,
                                          {'id': memeland.uid});
                                    },
                                    child: CustomCircleAvtar(
                                      url: auth.image,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    auth.name,
                                    style: const TextStyle(
                                      color: themewhitecolor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: size.width / 100 * 70,
                                child: Text(
                                  memeland.caption,
                                  style: const TextStyle(
                                    color: themewhitecolor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 80.0),
                            child: Column(children: [
                              AddSupporterButton(
                                  id: memeland.uid,
                                  supporterList: auth.supporterList),
                              const SizedBox(
                                height: 30,
                              ),
                              //likes
                              MemelandLikeButton(
                                like: memeland.like,
                                id: memeland.id,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (context, setState) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: CommentScreen(
                                          id: memeland.id,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                icon: Image.asset(
                                  "assets/images/png/reel-messages.png",
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                memeland.comment.toString(),
                                style: const TextStyle(
                                  color: themewhitecolor,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                  onTap: () async {
                                    // await Share.share(
                                    //     "${model.id}😊\n\n${model.image}");
                                    // final reelProvider =
                                    //     Provider.of<MemlandPro>(context,
                                    //         listen: false);
                                    // Timer(const Duration(seconds: 2), () {
                                    //   reelProvider.sharefun(model.id);
                                    // });
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.share,
                                        color: themewhitecolor,
                                        size: 45,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        memeland.share.toString(),
                                        style: const TextStyle(
                                          color: themewhitecolor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    'upload-memeland',
                                  );
                                },
                                child: Image.asset(
                                  "assets/images/png/mended-add-reel.png",
                                ),
                              ),
                              SizedBox(
                                height: size.height / 100 * 7,
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

class MemelandLikeButton extends StatefulWidget {
  final List like;
  final String id;
  const MemelandLikeButton({super.key, required this.like, required this.id});

  @override
  State<MemelandLikeButton> createState() => _MemelandLikeButtonState();
}

class _MemelandLikeButtonState extends State<MemelandLikeButton> {
  bool button = false;
  @override
  void initState() {
    if (widget.like.contains(FirebaseAuth.instance.currentUser!.uid)) {
      button = true;
    } else {
      button = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (button) {
                button = false;
                widget.like.remove(FirebaseAuth.instance.currentUser!.uid);
              } else {
                widget.like.add(FirebaseAuth.instance.currentUser!.uid);

                button = true;
              }
            });
            Provider.of<MemelandPro>(context, listen: false)
                .likeUpdate(widget.id);
          },
          child: button
              ? Image.asset(
                  "assets/images/png/reel-liked.png",
                )
              : Image.asset(
                  "assets/images/png/reel-like.png",
                ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.like.length.toString(),
          style: const TextStyle(
            color: themewhitecolor,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
