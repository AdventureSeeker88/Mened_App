// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:kashmir_news/models/dummy_imageslider_model.dart';
// import 'package:kashmir_news/theme/colors.dart';
// import 'package:kashmir_news/widgets/custom_icon_button.dart';

// class ActiveDot extends StatelessWidget {
//   const ActiveDot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 3, right: 3),
//       height: 7,
//       width: 7,
//       decoration: BoxDecoration(
//         color: themebluecolor,
//         borderRadius: BorderRadius.circular(50),
//       ),
//     );
//   }
// }

// class InactiveDot extends StatelessWidget {
//   const InactiveDot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 3, right: 3),
//       height: 7,
//       width: 7,
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(50),
//       ),
//     );
//   }
// }

// class ImageSlider extends StatefulWidget {
//   // final List items;
//   const ImageSlider({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _ImageSliderState createState() => _ImageSliderState();
// }

// class _ImageSliderState extends State<ImageSlider> {
//   int activeIndex = 0;

//   setActiveDot(index) {
//     setState(() {
//       activeIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: <Widget>[
//         CarouselSlider(
//           options: CarouselOptions(
//             autoPlayInterval: const Duration(seconds: 5),
//             autoPlay: false,
//             height: MediaQuery.of(context).size.height * 0.25,
//             autoPlayCurve: Curves.fastLinearToSlowEaseIn,
//             autoPlayAnimationDuration: const Duration(seconds: 2),
//             viewportFraction: 1,
//             onPageChanged: (index, reason) {
//               setActiveDot(index);
//             },
//           ),
//           items: List.generate(
//             imgslidercontent.length,
//             (index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                         imgslidercontent[index].image,
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.all(20.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20.0),
//                       gradient: LinearGradient(
//                         colors: [
//                           themeblackcolor.withOpacity(0.2),
//                           themeblackcolor.withOpacity(0.2),
//                           themeblackcolor.withOpacity(0.6),
//                           themeblackcolor.withOpacity(0.8),
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         stops: [0, 0.4, 0.8, 1],
//                       ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 12.0, vertical: 6.0),
//                           decoration: BoxDecoration(
//                             color: themebluecolor,
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Text(
//                             imgslidercontent[index].newscatetitle,
//                             style: TextStyle(
//                               color: themewhitecolor,
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
                            
//                             Text(
//                               imgslidercontent[index].time,
//                               style: TextStyle(
//                                 color: themegreycolor,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             CircleAvatar(
//                               backgroundColor: themewhitecolor,
//                               radius: 2,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             CircleAvatar(
//                               backgroundColor: Colors.blue,
//                               radius: 10,
//                               child: Icon(
//                                 Icons.check,
//                                 color: themewhitecolor,
//                                 size: 12,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               imgslidercontent[index].channeltitle,
//                               style: TextStyle(
//                                 color: themegreycolor,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           imgslidercontent[index].title,
//                           textAlign: TextAlign.end,
//                           style: TextStyle(
//                             color: themewhitecolor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );

//               // Container(
//               //   margin: const EdgeInsets.only(left: 0, right: 0),
//               //   decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(0),
//               //     image: DecorationImage(
//               //       image: NetworkImage(imgslidercontent[index].image),
//               //       colorFilter: const ColorFilter.mode(
//               //           themegreycolor, BlendMode.modulate),
//               //       fit: BoxFit.cover,
//               //     ),
//               //   ),
//               // );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 210.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               imgslidercontent.length,
//               (idx) {
//                 return activeIndex == idx
//                     ? const ActiveDot()
//                     : const InactiveDot();
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
