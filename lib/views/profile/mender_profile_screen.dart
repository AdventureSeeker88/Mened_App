
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mended/future/future.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/model/flicks_model.dart';
import 'package:mended/model/memeland_model.dart';
import 'package:mended/provider/flicks_pro.dart';
import 'package:mended/provider/memeland_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/views/flicks/widget/video_widget.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:provider/provider.dart';

class MenderProfileScreen extends StatefulWidget {
  final String id;
  const MenderProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<MenderProfileScreen> createState() => _MenderProfileScreenState();
}

class _MenderProfileScreenState extends State<MenderProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: StreamBuilder<AuthM>(
            stream: filterUser(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final userData = snapshot.data!;
                return userData.email.isEmpty
                    ? Expanded(
                        child: Center(
                            child: Image.asset(
                          "assets/images/png/mender-circular-logo.png",
                        )),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: CustomIconButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back_ios,color: themewhitecolor,),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (userData.image != "") {}
                            },
                            child: Hero(
                                tag: "profile-img",
                                child: CustomCircleAvtar(
                                  url: userData.image,
                                  height: 80,
                                  width: 80,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            userData.name,
                            style: const TextStyle(
                              color: themewhitecolor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            userData.bio,
                            style: const TextStyle(
                              color: themegreytextcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomSimpleRoundedButton(
                                onTap: () {},
                                height: 60,
                                width: width / 100 * 40,
                                buttoncolor: themelightgreencolor,
                                borderRadius: BorderRadius.circular(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FutureBuilder<int>(
                                        future: FutureFun()
                                            .flickTotalViews(widget.id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            int get = snapshot.data!;
                                            return Text(
                                              get.toString(),
                                              style: const TextStyle(
                                                color: themewhitecolor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          } else {
                                            return const Text("0",
                                                style: TextStyle(
                                                  color: themewhitecolor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ));
                                          }
                                        }),
                                    const Text(
                                      "views",
                                      style: TextStyle(
                                        color: themegreycolor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomSimpleRoundedButton(
                                onTap: () {},
                                height: 60,
                                width: width / 100 * 40,
                                buttoncolor: themelightgreencolor,
                                borderRadius: BorderRadius.circular(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      userData.supporterList.length.toString(),
                                      style: const TextStyle(
                                        color: themewhitecolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "supporters",
                                      style: TextStyle(
                                        color: themegreycolor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            color: themelightgreencolor,
                            child: TabBar(
                              controller: tabController,
                              indicator: const UnderlineTabIndicator(
                                borderSide: BorderSide.none,
                              ),
                              labelColor: themegreencolor,
                              unselectedLabelColor: themewhitecolor,
                              tabs: const [
                                Tab(
                                  text: "Memes",
                                ),
                                Tab(
                                  text: "Flicks",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                MemesTab(id: widget.id),
                                FlicksTab(id: widget.id),
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

  Stream<AuthM> filterUser(String uid) {
    return FirebaseFirestore.instance
        .collection(Database.auth)
        .doc(uid)
        .snapshots()
        .map((snapshot) => AuthM.fromJson(snapshot.data() ?? {}));
  }
}

class MemesTab extends StatefulWidget {
  final String id;
  const MemesTab({super.key, required this.id});

  @override
  State<MemesTab> createState() => _MemesTabState();
}

class _MemesTabState extends State<MemesTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: Provider.of<MemelandPro>(context, listen: false)
          .getMemeLandByUserId(widget.id),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data!.length,
            primary: false,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context, index) {
              var model = MemelandModel.fromSnap(snapshot.data![index]);
              return InkWell(
                onTap: () {
                  Go.named(
                      context, Routes.memelandPostScreen, {'id': model.id});
                },
                child: CustomCachedImage(
                  url: model.image,
                  height: 100,
                  width: 100,
                  borderRadius: 0,
                  fullview: false,
                ),
              );
            },
          );
        } else {
          return Container();
        }
      }),
    );
  }
}

class FlicksTab extends StatefulWidget {
  final String id;
  const FlicksTab({super.key, required this.id});

  @override
  State<FlicksTab> createState() => _FlicksTabState();
}

class _FlicksTabState extends State<FlicksTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: Provider.of<FlicksPro>(context, listen: false)
          .getFlicksByUserId(widget.id),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data!.length,
            primary: false,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context, index) {
              var model = FlicksModel.fromSnap(snapshot.data![index]);
              return InkWell(
                onTap: () {
                  Go.named(
                      context, Routes.memelandPostScreen, {'id': model.id});
                },
                child: FlicksVideoWidget(
                  videoUrl: model.video,
                  play: false,
                  id: model.id,
                ),
              );
            },
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
