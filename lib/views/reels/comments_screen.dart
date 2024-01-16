
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mended/model/comment_model.dart';
import 'package:mended/provider/flicks_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/views/chat/Future/future.dart';
import 'package:mended/widgets/toast.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final reels_id;
  const CommentsScreen({Key? key, required this.reels_id}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  bool _isloading = false;

  final TextEditingController commentEditingController =
      TextEditingController();
  String ReplayCommentEdit = "";

  String timeAgo(Timestamp d) {
    Duration diff = DateTime.now().difference(d.toDate());
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themepurplecolor,
        elevation: 0,
        title: const Text(
          "Comment",
          style: TextStyle(
            color: themewhitecolor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: const IconThemeData(color: themewhitecolor),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: StreamBuilder<List<CommentModel>>(
            stream: filterComments(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final commentslistdata = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: commentslistdata.map(_buildCommentCard).toList(),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: themegreycolor,
                  ),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 90,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey[200],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: commentEditingController,
                          decoration: const InputDecoration(
                            hintText: 'Comment as ',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (commentEditingController.text == "") {
        customToast("Please Write the Comment.", context);

                      
                    } else {
                      
                      commentEditingController.clear();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: const Icon(
                          Icons.send,
                          color: themebluecolor,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentCard(CommentModel _model) {
    final size = MediaQuery.of(context).size;
    return 
    Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
      child: Row(
        children: [
          FutureBuilder<String>(
              future: user_image_get(_model.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String Datara = snapshot.data!;
                  return CircleAvatar(
                    backgroundImage: NetworkImage(Datara),
                  );
                } else {
                  return const CircleAvatar();
                }
              }),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Container(
              width: size.width / 100 * 80,
              decoration: const BoxDecoration(
                // color: themegreycolor.withOpacity(0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<String>(
                                future: user_name_get(_model.uid),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String Datara = snapshot.data!;
                                    return Text(
                                      Datara,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic),
                                    );
                                  } else {
                                    return const Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    );
                                  }
                                }),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                _model.text,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _model.like.contains(
                                    FirebaseAuth.instance.currentUser!.uid)
                                ? InkWell(
                                    onTap: () {
                                      
                                    },
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                     
                                    },
                                    child: const Icon(
                                      Icons.favorite_border,
                                      size: 25,
                                      color: themedarkgreycolor,
                                    ),
                                  ),
                            const SizedBox(width: 8),
                            Text(
                              _model.like.length.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: themedarkgreycolor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),

                    ///
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  
  
  }

  Stream<List<CommentModel>> filterComments() => FirebaseFirestore.instance
      .collection('reels')
      .doc(widget.reels_id)
      .collection('comment')
      // .orderBy('DateTime', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CommentModel.fromJson(doc.data()))
          .toList());
}
