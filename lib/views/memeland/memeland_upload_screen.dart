import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mended/helper/pick_image.dart';
import 'package:mended/provider/memeland_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class UploadMemeScreen extends StatefulWidget {
  const UploadMemeScreen({Key? key}) : super(key: key);

  @override
  State<UploadMemeScreen> createState() => _UploadMemeScreenState();
}

class _UploadMemeScreenState extends State<UploadMemeScreen> {
  TextEditingController captionCtrl = TextEditingController();
  Uint8List? image;
  Future selectImage(int type) async {
    try {
      Uint8List file;
      file = await pickImage(ImageSource.gallery);
      if (type == 0) {
        // ignore: unnecessary_null_comparison
        if (file == null) {
          Navigator.pop(context);
        } else {
          setState(() {
            image = file;
          });
        }
      } else {
        setState(() {
          image = file;
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    selectImage(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 12.0),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Upload Meme",
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomIconButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: themewhitecolor,
                      ),
                    ),
                  ),
               
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    selectImage(1);
                  },
                  child: image != null
                      ? Image.memory(
                          image!,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 220,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: themewhitecolor, width: 2)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.image,
                                    size: 35,
                                    color: themewhitecolor,
                                  ),
                                  Text(
                                    "Upload Picture",
                                    style: TextStyle(
                                      color: themewhitecolor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: themewhitecolor),
                      controller: captionCtrl,
                      decoration: InputDecoration(
                        hintText: "Write a caption",
                        hintStyle: const TextStyle(
                          color: themewhitecolor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: themewhitecolor,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: themewhitecolor,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CustomIconButton(
                    onTap: () {},
                    child: const Icon(
                      Icons.check,
                      color: themewhitecolor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: InkWell(
                onTap: () {
                  if (image != null) {
                    final post =
                        Provider.of<MemelandPro>(context, listen: false);
                    post.addMemeland(
                      image!,
                      captionCtrl.text,
                      context,
                    );
                  }
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/png/mended-button.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Share",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
