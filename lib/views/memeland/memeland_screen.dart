import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mended/model/memeland_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/provider/memeland_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/utils/path.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:provider/provider.dart';

class MemelandScreen extends StatefulWidget {
  const MemelandScreen({super.key});

  @override
  State<MemelandScreen> createState() => _MemelandScreenState();
}

class _MemelandScreenState extends State<MemelandScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<MemelandPro>(builder: ((context, modelvalue, child) {
      return Scaffold(
          backgroundColor: Palette.themecolor,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Go.named(context, Routes.uploadMemeland);
                },
                child: Image.asset(Assets.circleAddButton),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Go.named(context, Routes.flicks);
                },
                child: Image.asset(Assets.flicksButton),
              ),
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: modelvalue.pageIndex == 0
                      ? FutureBuilder<List<DocumentSnapshot>>(
                          future:
                              Provider.of<MemelandPro>(context, listen: false)
                                  .getMemeLand(),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data!;
                              return Wrap(
                                children: List.generate(data.length, (index) {
                                  var model = MemelandModel.fromSnap(
                                    data[index],
                                  );
                                  return Consumer<AuthPro>(
                                      builder: ((context, modelauth, child) {
                                    return modelauth.myUserdata['buddyList']
                                                .contains(model.uid) ||
                                            modelauth
                                                .myUserdata['supporterList']
                                                .contains(model.uid)
                                        ? MemlandCard(model: model)
                                        : SizedBox();
                                  }));
                                }),
                              );
                            } else {
                              return Container();
                            }
                          }))
                      : FutureBuilder<List<DocumentSnapshot>>(
                          future:
                              Provider.of<MemelandPro>(context, listen: false)
                                  .getMemeLandPopular(),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data!;
                              return Wrap(
                                children: List.generate(data.length, (index) {
                                  var model = MemelandModel.fromSnap(
                                    data[index],
                                  );
                                  return MemlandCard(model: model);
                                }),
                              );
                            } else {
                              return Container();
                            }
                          }),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 25,
                    right: 25,
                    bottom: 60,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Memeland",
                        style: TextStyle(
                          fontSize: 36,
                          color: themewhitecolor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "dripping",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IntrinsicHeight(
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Provider.of<MemelandPro>(context,
                                            listen: false)
                                        .onPageChanged(0);
                                  },
                                  child: const Text(
                                    "Friends",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: themewhitecolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: themewhitecolor,
                                  indent: 5,
                                  endIndent: 5,
                                  thickness: 2,
                                  width: 40,
                                ),
                                InkWell(
                                  onTap: () {
                                    Provider.of<MemelandPro>(context,
                                            listen: false)
                                        .onPageChanged(1);
                                  },
                                  child: const Text(
                                    "Popular",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: themewhitecolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: CustomIconButton(
                                onTap: () {},
                                child: const Icon(
                                  Icons.search,
                                  color: themewhitecolor,
                                ),
                              ),
                            ),
                            // InkWell(
                            //   // onTap: () {
                            //   //   RouteNavigator.route(
                            //   //     context,
                            //   //     FindMenderScreen(),
                            //   //   );
                            //   // },
                            //   child: CircleAvatar(
                            //     backgroundColor: themedarkgreycolor,
                            //     child: Icon(
                            //       Icons.search,
                            //       color: themewhitecolor,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    }));
  }
}

class MemlandCard extends StatelessWidget {
  final MemelandModel model;
  const MemlandCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Go.named(context, Routes.memelandPostScreen, {'id': model.id});
      },
      child: CustomCachedImage(
        url: model.image,
        height: 120,
        width: size.width / 3,
        borderRadius: 0,
        fullview: false,
      ),
    );
  }
}
