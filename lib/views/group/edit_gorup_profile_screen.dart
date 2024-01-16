import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mended/helper/pick_image.dart';
import 'package:mended/provider/group_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:mended/widgets/shimer.dart';
import 'package:provider/provider.dart';

class EditProfileForThisGroupScreen extends StatefulWidget {
  final String id;
  const EditProfileForThisGroupScreen({Key? key, required this.id})
      : super(key: key);

  @override
  State<EditProfileForThisGroupScreen> createState() =>
      _EditProfileForThisGroupScreenState();
}

class _EditProfileForThisGroupScreenState
    extends State<EditProfileForThisGroupScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController bioCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String getImage = "";
  Uint8List? image;
  Future selectImage() async {
    Uint8List file;
    file = await pickImage(ImageSource.gallery);
    setState(() {
      image = file;
    });
  }

  String? validator(value) {
    if (value == "") {
      return "";
    }
    return null;
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    final pro = Provider.of<GroupPro>(context, listen: false);
    await pro.getProfileForThisGroup(widget.id);
    getImage = pro.profileForGroupData['image'];
    nameCtrl.text = pro.profileForGroupData['name'];
    bioCtrl.text = pro.profileForGroupData['bio'];
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GroupPro>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: model.profileGroupisLoading
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: themewhitecolor,
                ),
              )
            : Padding(
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
                              "Edit Profile For This Group",
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
                      image != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(image!),
                            )
                          : CustomCircleAvtar(
                              height: 80,
                              width: 80,
                              url: getImage,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextButton(
                        buttonText: "Edit Photo",
                        onTap: () {
                          selectImage();
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
                        controller: nameCtrl,
                        cursorColor: themewhitecolor,
                        style: const TextStyle(
                          color: themewhitecolor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Magicwhirl Star",
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
                            return "Name is empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: bioCtrl,
                        maxLines: 8,
                        cursorColor: themewhitecolor,
                        style: const TextStyle(
                          color: themewhitecolor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Add Bio",
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
                          suffixIcon: const Icon(
                            Icons.edit_outlined,
                            color: themewhitecolor,
                          ),
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bio is empty";
                          }
                          return null;
                        },
                      ),
                      const Spacer(),
                      CustomSimpleRoundedButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            Provider.of<GroupPro>(context, listen: false)
                                .updateProfileForThisGroup(image, nameCtrl.text,
                                    bioCtrl.text, widget.id, context);
                          }
                        },
                        height: 45,
                        width: size.width / 100 * 28,
                        buttoncolor: themelightgreencolor,
                        borderRadius: BorderRadius.circular(30),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: themewhitecolor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
