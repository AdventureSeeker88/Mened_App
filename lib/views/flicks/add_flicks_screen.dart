// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:mended/provider/flicks_pro.dart';
// import 'package:mended/theme/colors.dart';
// import 'package:mended/widgets/custom_rounded_button.dart';

// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';

// class AddFlickScreen extends StatefulWidget {
//   const AddFlickScreen({Key? key}) : super(key: key);

//   @override
//   State<AddFlickScreen> createState() => _AddFlickScreenState();
// }

// class _AddFlickScreenState extends State<AddFlickScreen> {
//   late VideoPlayerController _controller;

//   File? _filevideo;
//   var name = "No Select File";
//   String url = "";
//   getvideofile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['mp4'],
//     );

//     if (result != null) {
//       File c = File(result.files.single.path.toString());
//       setState(() {
//         _filevideo = c;
//         name = result.names.toString();

//         _controller = VideoPlayerController.file(_filevideo!)..initialize();
//       });
//     }
//   }

//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController reelDescriptionC = TextEditingController();
//   final TextEditingController reelhashtagsC = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: themeblackcolor,
//       body: _filevideo != null
//           ? Form(
//               key: _formKey,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Spacer(),
//                     SizedBox(
//                         height: 350,
//                         width: size.width,
//                         child: VideoPlayer(_controller)),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       "Reel Description:",
//                       style: TextStyle(
//                           color: themewhitecolor,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     // user name
//                     TextFormField(
//                       controller: reelDescriptionC,
//                       keyboardType: TextInputType.name,
//                       maxLines: 4,
//                       maxLength: 300,
//                       style: const TextStyle(color: themewhitecolor),
//                       decoration: InputDecoration(
//                         helperStyle: const TextStyle(color: themewhitecolor),
//                         hintText: "Enter reel Description here..",
//                         hintStyle: const TextStyle(
//                           color: themewhitecolor,
//                         ),
//                         filled: true,
//                         fillColor: themegreycolor.withOpacity(0.4),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: themegreytextcolor,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: themegreytextcolor,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         contentPadding: const EdgeInsets.all(12),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Description is empty";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     const Text(
//                       "Hashtags:",
//                       style: TextStyle(
//                           color: themewhitecolor,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextFormField(
//                       controller: reelhashtagsC,
//                       keyboardType: TextInputType.text,
//                       style: const TextStyle(color: themewhitecolor),
//                       decoration: InputDecoration(
//                         hintText: "Enter Hashtags here..",
//                         hintStyle: const TextStyle(
//                           color: themewhitecolor,
//                         ),
//                         filled: true,
//                         fillColor: themegreycolor.withOpacity(0.4),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: themegreytextcolor,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: themegreytextcolor,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         contentPadding: const EdgeInsets.all(12),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Hashtag is empty";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
                   
//                     CustomRoundedButton(
//                         buttonText: "UPLOAD REEL",
//                         onTap: () {
//                           if (_formKey.currentState!.validate()) {
//                             final post =
//                                 Provider.of<FlicksPro>(context, listen: false);

//                             post.AddFlicks(reelDescriptionC.text,
//                                 reelhashtagsC.text, _filevideo!, context);
//                           }
//                         },
//                         height: size.height / 100 * 5,
//                         width: size.width,
//                         buttoncolor: Palette.themecolor,
//                         buttontextcolor: themewhitecolor),
//                   ],
//                 ),
//               ),
//             )
//           : Container(
//               color: themeblackcolor,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: InkWell(
//                       onTap: () {
//                         getvideofile();
//                       },
//                       child: Container(
//                         height: size.height / 100 * 18,
//                         width: size.width / 2.3,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: themewhitecolor),
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(20),
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: const [
//                             Icon(
//                               Icons.add_box_outlined,
//                               color: themewhitecolor,
//                               size: 40,
//                             ),
//                             Text(
//                               "Add New Reels",
//                               style: TextStyle(
//                                   color: themewhitecolor,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
