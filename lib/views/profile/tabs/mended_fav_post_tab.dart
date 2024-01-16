import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mended/model/reels_model.dart';
import 'package:mended/theme/colors.dart';

import 'mended_reel_video_player.dart';
class MendedFavPostTab extends StatefulWidget {
  const MendedFavPostTab({Key? key}) : super(key: key);

  @override
  State<MendedFavPostTab> createState() => _MendedFavPostTabState();
}

class _MendedFavPostTabState extends State<MendedFavPostTab> {
  @override
  Widget build(BuildContext context) {
    log(FirebaseAuth.instance.currentUser!.uid);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: themegreencolor,
      body: StreamBuilder<List<FlicksModel>>(
          stream: filter_favourite_post(),
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
                      padding: EdgeInsets.all(20),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: listdata.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 200,
                      ),
                      itemBuilder: (context, index) {
                        final model = listdata[index];
                        return InkWell(
                            onTap: () {
                              // RouteNavigator.route(
                              //     context,
                              //     ProfileReelsScreen(
                              //       pageindex: index,
                              //       uid: FirebaseAuth.instance.currentUser!.uid,
                              //       isMemeland: false,
                              //     ));
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
                                    padding: EdgeInsets.all(6),
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

  Stream<List<FlicksModel>> filter_favourite_post() => FirebaseFirestore
      .instance
      .collection('reels')
      .where("like", arrayContainsAny: [FirebaseAuth.instance.currentUser!.uid])
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => FlicksModel.fromJson(doc.data()))
          .toList());
}
