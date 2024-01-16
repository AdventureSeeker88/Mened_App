// import 'package:flutter/material.dart';
// import 'package:kashmir_news/theme/colors.dart';
// import 'package:story_view/story_view.dart';

// class StoryViewScreen extends StatefulWidget {
//   final String storyimage;
//   const StoryViewScreen({super.key, required this.storyimage});

//   @override
//   State<StoryViewScreen> createState() => _StoryViewScreenState();
// }

// class _StoryViewScreenState extends State<StoryViewScreen> {
//   final StoryController storycontroller = StoryController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StoryView(
//         controller: storycontroller,
//         onVerticalSwipeComplete: (direction) {
//           if (direction == Direction.down) {
//             Navigator.pop(context);
//           }
//         },
//         storyItems: [
//           StoryItem.text(
//             title: "Hello World, how are you doing?",
//             backgroundColor: themeredcolor,
//             roundedTop: true,
//           ),
//           StoryItem.inlineImage(
//             // imageFit: BoxFit.cover,
//             url: widget.storyimage,
//             controller: storycontroller,
//             caption: Text(
//               "Image caption",
//               style: TextStyle(
//                 color: Colors.white,
//                 backgroundColor: Colors.black54,
//                 fontSize: 17,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
