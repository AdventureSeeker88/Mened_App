import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mended/future/future.dart';
import 'package:mended/model/group_model.dart';
import 'package:mended/provider/group_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:provider/provider.dart';

class GroupTransferScreen extends StatefulWidget {
  final String id;
  const GroupTransferScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<GroupTransferScreen> createState() => _GroupTransferScreenState();
}

class _GroupTransferScreenState extends State<GroupTransferScreen> {
  // TextEditingController titleCtrl = TextEditingController();
  // TextEditingController desCtrl = TextEditingController();
  // final formKey = GlobalKey<FormState>();
  // @override
  // void initState() {
  //   load();
  //   super.initState();
  // }

  // load() async {
  //   final groupPro = Provider.of<GroupPro>(context, listen: false);
  //   await groupPro.getGroupId(widget.id);
  //   titleCtrl.text = groupPro.groupModelData!.title;
  //   desCtrl.text = groupPro.groupModelData!.des;
  // }

  @override
  Widget build(BuildContext context) {
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
                        child: Text(
                          "No Data Avaialable",
                          style: TextStyle(color: themewhitecolor),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
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
                                      "Transfer Group Admin",
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
                              const Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  "Group Members",
                                  style: TextStyle(
                                      color: themewhitecolor, fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: themegreycolor.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListView.separated(
                                  itemCount:
                                      modelvalue.groupModelData!.member.length,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return FutureBuilder<GroupMemberM>(
                                        future: FutureFun().getGroupMemberByid(
                                            widget.id,
                                            modelvalue
                                                .groupModelData!.member[index]),
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
                                                            .groupModelData!.uid
                                                    ? const Text(
                                                        "Admin",
                                                        style: TextStyle(
                                                            color:
                                                                themegreencolor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16),
                                                      )
                                                    : TextButton(
                                                        onPressed: () {
                                                          Provider.of<GroupPro>(
                                                                  context,
                                                                  listen: false)
                                                              .groupTransferAdminFunc(
                                                                  modelvalue
                                                                      .groupModelData!
                                                                      .id,
                                                                  modelvalue
                                                                      .groupModelData!
                                                                      .member[index],
                                                                  context);
                                                        },
                                                        child: const Text(
                                                          "Make Admin",
                                                          style: TextStyle(
                                                              color:
                                                                  themegreycolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16),
                                                        ))));
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
                            ],
                          ),
                        ),
                      );
          })),
        ));
  }

  Stream<GroupModel> groupStream(String id) {
    return FirebaseFirestore.instance
        .collection(Database.group)
        .doc(id)
        .snapshots()
        .map((snapshot) => GroupModel.fromJson(snapshot.data() ?? {}));
  }
}
