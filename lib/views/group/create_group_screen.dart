import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mended/helper/pick_image.dart';
import 'package:mended/provider/group_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:mended/widgets/toast.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  int groupType = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController groupnameC = TextEditingController();
  final TextEditingController groupdescriptionC = TextEditingController();
  Uint8List? selectGroupImage;
  Future selectGroupImageFunc() async {
    try {
      Uint8List file;
      file = await pickImage(ImageSource.gallery);

      selectGroupImage = file;
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themelightgreencolor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomSimpleRoundedButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (selectGroupImage != null) {
                Provider.of<GroupPro>(context, listen: false).createGroup(
                    selectGroupImage!,
                    groupnameC.text,
                    groupdescriptionC.text,
                    groupType == 0 ? "Public" : "Private",
                    context);
              } else {
                customToast("Please Select Group Image to continue.", context);
              }
            }
          },
          height: 50,
          width: size.width,
          buttoncolor: Palette.themecolor,
          borderRadius: BorderRadius.circular(30),
          child: const Text(
            "Create Your Group",
            style: TextStyle(
              color: themewhitecolor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          //top change password
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CustomIconButton(
                    onTap: () {
                      // Navigator.pop(context);
                      context.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: themewhitecolor,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Create a Group",
                    style: TextStyle(
                      color: themewhitecolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //body
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      selectGroupImage == null
                          ? const CustomCircleAvtar()
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor: themeyellowcolor,
                              backgroundImage: MemoryImage(selectGroupImage!)),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          selectGroupImageFunc();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.upload,
                              color: themewhitecolor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Select Group Picture",
                              style: TextStyle(
                                color: themewhitecolor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: groupnameC,
                        decoration: InputDecoration(
                          hintText: "Enter your Group Name",
                          hintStyle: const TextStyle(
                            color: themegreycolor,
                          ),
                          filled: true,
                          fillColor: themegreycolor.withOpacity(0.4),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: themewhitecolor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: themewhitecolor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        maxLines: 4,
                        controller: groupdescriptionC,
                        decoration: InputDecoration(
                          hintText: "Enter Your Group Description",
                          hintStyle: const TextStyle(
                            color: themegreycolor,
                          ),
                          filled: true,
                          fillColor: themegreycolor.withOpacity(0.4),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: themewhitecolor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: themewhitecolor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Group Type: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: themewhitecolor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                groupType = 0;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                color: groupType == 0
                                    ? Palette.themecolor
                                    : themegreycolor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: themewhitecolor,
                                    child: Icon(
                                      Icons.group,
                                      color: Palette.themecolor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Public",
                                    style: TextStyle(
                                      color: groupType == 0
                                          ? themewhitecolor
                                          : themeblackcolor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                groupType = 1;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                color: groupType == 1
                                    ? Palette.themecolor
                                    : themegreycolor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: themewhitecolor,
                                    child: Icon(
                                      Icons.lock,
                                      color: Palette.themecolor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Private",
                                    style: TextStyle(
                                      color: groupType == 1
                                          ? themewhitecolor
                                          : themeblackcolor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
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
          )
        ],
      )),
    );
  }
}
