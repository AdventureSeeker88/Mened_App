import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mended/helper/pick_image.dart';
import 'package:mended/provider/group_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class GroupAddPostScreen extends StatefulWidget {
  String id;
  GroupAddPostScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<GroupAddPostScreen> createState() => _GroupAddPostScreenState();
}

class _GroupAddPostScreenState extends State<GroupAddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController postTitleC = TextEditingController();
  final TextEditingController postDescriptionC = TextEditingController();
  Uint8List? selectPostImage;
  Future selectPostImageFunc() async {
    try {
      Uint8List file;
      file = await pickImage(ImageSource.gallery);

      selectPostImage = file;
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  File? selectPostPdf;
  Future<void> selectPostPdfFunc() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        selectPostPdf = File(result.files.single.path!);
        selectPostImage = null;
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themegreencolor,
      appBar: AppBar(
        backgroundColor: themegreencolor,
        elevation: 0,
        iconTheme: const IconThemeData(color: themewhitecolor),
        title: const Text(
          "Add Post",
          style: TextStyle(
            color: themewhitecolor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "CREATE A NEW POST 😊",
                  style: TextStyle(
                    fontSize: 20,
                    color: themewhitecolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: themewhitecolor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      //Image Container
                      CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () async {
                          selectPostImageFunc();
                        },
                        child: Container(
                          height: height / 100 * 20,
                          width: width,
                          decoration: BoxDecoration(
                            border: Border.all(color: themegreycolor),
                            color: themegreycolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: (selectPostImage != null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    selectPostImage!,
                                    fit: BoxFit.cover,
                                  ))
                              : Center(
                                  child: Container(
                                    height: height / 100 * 6,
                                    width: width / 100 * 12,
                                    decoration: BoxDecoration(
                                      color: themegreytextcolor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      size: 30,
                                      color: themewhitecolor,
                                    ),
                                  ),
                                ),
                        ),
                      ),
      
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      // post title
                      TextFormField(
                        controller: postTitleC,
                        decoration: InputDecoration(
                          hintText: "Post",
                          hintStyle: const TextStyle(
                            color: themegreytextcolor,
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
                            return "Post is empty";
                          }
                          return null;
                        },
                      ),
      
                      const SizedBox(
                        height: 20,
                      ),
      
                      TextFormField(
                        controller: postDescriptionC,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Post Description",
                          hintStyle: const TextStyle(
                            color: themegreytextcolor,
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
                            return "Post Description is empty";
                          }
                          return null;
                        },
                      ),
      
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () async {
                          selectPostPdfFunc();
                        },
                        child: Container(
                            height: height / 100 * 5,
                            width: width,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: themegreycolor),
                              color: themegreycolor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: (selectPostPdf != null)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Update Document",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: themegreytextcolor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectPostPdf = null;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.cancel,
                                          color: themegreytextcolor,
                                        ),
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.upload_file,
                                        color: themegreytextcolor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Upload Document",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: themegreytextcolor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )),
                      ),
      
                      const SizedBox(
                        height: 20,
                      ),
      
                      CustomRoundedButton(
                          buttonText: "UPLOAD POST",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<GroupPro>(context, listen: false)
                                  .postAdd(
                                      widget.id,
                                      FirebaseAuth.instance.currentUser!.uid,
                                      selectPostImage,
                                      selectPostPdf,
                                      postTitleC.text,
                                      postDescriptionC.text,
                                      context);
                            }
                          },
                          height: height / 100 * 5,
                          width: width,
                          buttoncolor: Palette.themecolor,
                          buttontextcolor: themewhitecolor),
                    ],
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
