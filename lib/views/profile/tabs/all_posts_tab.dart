import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/model/reels_model.dart';
import 'package:mended/theme/colors.dart';

import 'mended_reel_video_player.dart';
class AllPostsTab extends StatefulWidget {
  bool isMainProfile;
  String userId;
  AllPostsTab({Key? key, required this.isMainProfile, required this.userId})
      : super(key: key);

  @override
  State<AllPostsTab> createState() => _AllPostsTabState();
}

class _AllPostsTabState extends State<AllPostsTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
    
      backgroundColor: themegreencolor,
      body: StreamBuilder<List<FlicksModel>>(
          stream: filter(widget.isMainProfile
              ? FirebaseAuth.instance.currentUser!.uid
              : widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final listdata = snapshot.data!;

              return listdata.isEmpty
                  ? Center(
                      child: Image.asset(
                        "assets/images/png/no_reels.png",
                        height: 250,
                        width: 250,
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: listdata.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 200,
                      ),
                      itemBuilder: (context, index) {
                        final model = listdata[index];
                        return InkWell(
                            onTap: () {
                            
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ReelsVideoWidget(
                                    videoUrl: model.video,
                                    play: false,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: themewhitecolor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.favorite,
                                          color: themeredcolor,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          model.like.length.toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      },
                    );
            } else {
              return Container();
            }
          }),
    );
  }

  Stream<List<FlicksModel>> filter(userId) => FirebaseFirestore.instance
      .collection('flicks')
      .where("uid", isEqualTo: userId)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => FlicksModel.fromJson(doc.data()))
          .toList());
}
