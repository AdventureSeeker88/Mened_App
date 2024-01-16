import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:provider/provider.dart';

class BuddyListScreen extends StatefulWidget {
  const BuddyListScreen({Key? key}) : super(key: key);

  @override
  State<BuddyListScreen> createState() => _BuddyListScreenState();
}

class _BuddyListScreenState extends State<BuddyListScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  CustomIconButton(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: themewhitecolor,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Buddy List",
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40, 
              ),
              Consumer<AuthPro>(
                builder: ((context, modelvalue, child) {
                  return modelvalue.myUserdata['buddyList'].isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height / 100 * 15,
                            ),
                            Center(
                              child: Image.asset(
                                "assets/images/png/no_buddy.png",
                                height: 350,
                                // width: 250,
                              ),
                            ),
                            SizedBox(
                              height: size.height / 100 * 1,
                            ),
                            const Text(
                              "No Buddies to show.",
                              style: TextStyle(
                                color: themewhitecolor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: "dripping",
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          itemCount: modelvalue.myUserdata['buddyList'].length,
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final model =
                                modelvalue.myUserdata['buddyList'][index];
                            return FutureBuilder<AuthM>(
                                future:
                                    Provider.of<AuthPro>(context, listen: false)
                                        .getUserById(model),
                                builder: ((context, snapshot) {
                                  if (snapshot.hasData) {
                                    AuthM auth = snapshot.data!;
                                    return Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: themewhitecolor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        onTap: () {},
                                        minLeadingWidth: 0,
                                        contentPadding: EdgeInsets.zero,
                                        leading: CustomCircleAvtar(
                                          url: auth.image,
                                        ),
                                        title: Text(
                                          auth.name,
                                          style: const TextStyle(
                                            color: themelightgreencolor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        trailing: CustomSimpleRoundedButton(
                                          onTap: () {
                                            Go.named(context,
                                                Routes.chattingScreen, {
                                              'id': model,
                                            });
                                            
                                          },
                                          height: 40,
                                          width: 120,
                                          buttoncolor:
                                              themelightgreenshade2color
                                                  .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          child: const Text(
                                            "Message",
                                            style: TextStyle(
                                              color: themelightgreencolor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
