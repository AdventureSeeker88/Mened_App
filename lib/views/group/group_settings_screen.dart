import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:mended/future/future.dart';
import 'package:mended/model/group_model.dart';
import 'package:mended/provider/group_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:provider/provider.dart';

class GroupSettingsScreen extends StatefulWidget {
  final String id;
  const GroupSettingsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<GroupSettingsScreen> createState() => _GroupSettingsScreenState();
}

class _GroupSettingsScreenState extends State<GroupSettingsScreen> {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController desCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    final groupPro = Provider.of<GroupPro>(context, listen: false);
    await groupPro.getGroupId(widget.id);
    titleCtrl.text = groupPro.groupModelData!.title;
    desCtrl.text = groupPro.groupModelData!.des;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: themegreencolor,
        body: SafeArea(
          child: Consumer<GroupPro>(builder: ((context, modelvalue, child) {
            return modelvalue.groupDataisLoading == true
                ? const Center(
                    child: CupertinoActivityIndicator(
                      color: themewhitecolor,
                    ),
                  )
                : modelvalue.groupModelData == null
                    ? const Center(
                        child: CupertinoActivityIndicator(
                          color: themewhitecolor,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CustomIconButton(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        color: themewhitecolor,
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Edit Group Profile",
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
                                InkWell(
                                  onTap: () {},
                                  child: CustomCircleAvtar(
                                    url: modelvalue.groupModelData!.image,
                                  ),
                                ),
                                CustomTextButton(
                                  buttonText: "Edit Group Image",
                                  onTap: () {
                                    // RouteNavigator.route(
                                    //   context,
                                    //   const EditProfileForThisGroupScreen(),
                                    // );
                                  },
                                  textstyle: const TextStyle(
                                    color: themelightgreenshade2color,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                  style:
                                      const TextStyle(color: themewhitecolor),
                                  controller: titleCtrl,
                                  decoration: InputDecoration(
                                    fillColor: themegreycolor.withOpacity(0.5),
                                    filled: true,
                                    hintText: "Enter your Group Name",
                                    hintStyle: const TextStyle(
                                      color: themewhitecolor,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: themewhitecolor,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: themewhitecolor,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.edit_outlined,
                                      color: themewhitecolor,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  style:
                                      const TextStyle(color: themewhitecolor),
                                  controller: desCtrl,
                                  decoration: InputDecoration(
                                    fillColor: themegreycolor.withOpacity(0.5),
                                    filled: true,
                                    hintText: "Add description to group",
                                    hintStyle: const TextStyle(
                                      color: themegreycolor,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: themewhitecolor,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: themewhitecolor,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.edit_outlined,
                                      color: themewhitecolor,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: themegreycolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        // context.pushNamed('view-group-items',
                                        //     queryParams: {
                                        //       'id': modelvalue.groupModelData!.id
                                        //     });
                                      },
                                      minLeadingWidth: 0,
                                      leading: const Icon(
                                        CupertinoIcons.photo_fill,
                                        color: themewhitecolor,
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Files,photos,links,docs",
                                            style: TextStyle(
                                              color: themewhitecolor,
                                            ),
                                          ),
                                          Text(
                                            modelvalue
                                                .groupModelData!.media.length
                                                .toString(),
                                            style: const TextStyle(
                                              color: themewhitecolor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: themewhitecolor,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    "Group Members",
                                    style: TextStyle(
                                        color: themewhitecolor, fontSize: 18),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: themegreycolor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ListView.separated(
                                    itemCount: modelvalue
                                        .groupModelData!.member.length,
                                    primary: false,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return FutureBuilder<GroupMemberM>(
                                          future: FutureFun()
                                              .getGroupMemberByid(
                                                  widget.id,
                                                  modelvalue.groupModelData!
                                                      .member[index]),
                                          builder: ((context, snapshot) {
                                            if (snapshot.hasData) {
                                              final memberData = snapshot.data;
                                              return ListTile(
                                                  minLeadingWidth: 0,
                                                  leading: CustomCircleAvtar(
                                                    height: 70,
                                                    width: 70,
                                                    url: memberData!.image,
                                                  ),
                                                  title: Text(
                                                    memberData.name,
                                                    style: const TextStyle(
                                                      color: themewhitecolor,
                                                    ),
                                                  ),
                                                  trailing: (modelvalue
                                                              .groupModelData!
                                                              .member[index] ==
                                                          modelvalue
                                                              .groupModelData!
                                                              .uid
                                                      ? const Text(
                                                          "Admin",
                                                          style: TextStyle(
                                                              color:
                                                                  themegreencolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16),
                                                        )
                                                      : const SizedBox()));
                                            } else {
                                              return const SizedBox();
                                            }
                                          }));
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Divider(
                                        height: 0,
                                        color: themewhitecolor,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                modelvalue.groupModelData!.member.length != 1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color:
                                              themegreycolor.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            final members = [];
                                            for (var i = 0;
                                                i <
                                                    modelvalue.groupModelData!
                                                        .member.length;
                                                i++) {
                                              if (FirebaseAuth.instance
                                                      .currentUser!.uid !=
                                                  modelvalue.groupModelData!
                                                      .member[i]) {
                                                members.add(modelvalue
                                                    .groupModelData!.member[i]);
                                              }
                                            }
                                          

                                            Provider.of<GroupPro>(context,
                                                    listen: false)
                                                .groupLeaveFunc(
                                                    modelvalue
                                                        .groupModelData!.id,
                                                    members,
                                                    context);
                                          },
                                          title: const Text(
                                            "Leave the group",
                                            style: TextStyle(
                                              color: themewhitecolor,
                                            ),
                                          ),
                                        ))
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: themegreycolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ListTile(
                                        onTap: () {
                                          Go.named(context,
                                              Routes.groupTransferSetting, {
                                            'id': modelvalue.groupModelData!.id
                                          });
                                        },
                                        title: const Text(
                                          "Transfer Admin",
                                          style: TextStyle(
                                            color: themewhitecolor,
                                          ),
                                        ),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                          color: themewhitecolor,
                                        ))),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: themegreycolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ListTile(
                                        onTap: () {
                                          closeGroupConfirmationDialog(
                                              context, size, modelvalue);
                                        },
                                        title: const Text(
                                          "Close Group",
                                          style: TextStyle(
                                            color: themewhitecolor,
                                          ),
                                        ),
                                        trailing: const Icon(
                                          Icons.close,
                                          size: 18,
                                          color: themewhitecolor,
                                        ))),
                              ],
                            ),
                          ),
                        ),
                      );
          })),
        ));
  }

  Future<Object?> closeGroupConfirmationDialog(
      BuildContext context, Size size, GroupPro modelvalue) {
    return showAnimatedDialog(
      barrierDismissible: true,
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          titlePadding: const EdgeInsets.all(20),
          actionsPadding: const EdgeInsets.all(0),
          buttonPadding: const EdgeInsets.all(0),
          title: SizedBox(
            width: size.width,
            child: Column(
              children: [
                const Text(
                  "Close Group",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Icon(
                  Icons.ads_click_sharp,
                  color: themelightgreencolor,
                  size: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Are you sure you want to close ${modelvalue.groupModelData!.title} group?",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: themeblackcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Provider.of<GroupPro>(context, listen: false)
                              .groupCloseFunc(
                                  modelvalue.groupModelData!.id, context);
                        },
                        child: Container(
                          width: size.width / 100 * 33,
                          height: size.height / 100 * 5,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: themeredcolor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: themewhitecolor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: size.width / 100 * 33,
                          height: size.height / 100 * 5,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Palette.themecolor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "No",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: themewhitecolor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stream<GroupModel> groupStream(String id) {
    return FirebaseFirestore.instance
        .collection(Database.group)
        .doc(id)
        .snapshots()
        .map((snapshot) => GroupModel.fromJson(snapshot.data() ?? {}));
  }
}
