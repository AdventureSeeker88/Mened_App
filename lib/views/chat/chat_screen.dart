import 'package:flutter/material.dart';
import 'package:mended/theme/colors.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String userImage;
  const ChatScreen({
    super.key,
    required this.username,
    required this.userImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: themelightgreencolor,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(widget.userImage),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.username,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            // Spacer(),
            // CustomIconButton(
            //   onTap: () {
            //     RouteNavigator.route(context, VideoCallScreen());
            //   },
            //   child: Icon(
            //     Icons.videocam,
            //     color: themewhitecolor,
            //   ),
            // ),
            // SizedBox(
            //   width: 20,
            // ),
            // CustomIconButton(
            //   onTap: () {
            //     RouteNavigator.route(context, CallScreen());
            //   },
            //   child: Icon(
            //     Icons.call,
            //     color: themewhitecolor,
            //   ),
            // ),
          ],
        ),
      ),
      body: Stack(
        children: [
          messages(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: const BoxDecoration(
                // color: themewhitecolor,
                border: Border(
                  top: BorderSide(
                    color: themegreytextcolor,
                  ),
                ),
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add text to this message",
                        hintStyle: TextStyle(
                          color: themegreytextcolor,
                          fontSize: 14,
                        ),
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.send,
                    color: themedarkbluecolor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget messages() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: themelightgreencolor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              "Anybody affected by coronavirus",
              style: TextStyle(
                color: themeblackcolor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 250,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: themelightgreencolor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                "At our office 3 people are affected We Work from home",
                style: TextStyle(
                  color: themewhitecolor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 250,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: themelightgreencolor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              "All good here. We wash hands and stay home",
              style: TextStyle(
                color: themeblackcolor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 250,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: themelightgreencolor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                "This is our new manager, She will join chat. Her name is Ola. This is our new manager, She will join chat. Her name is Ola.",
                style: TextStyle(
                  color: themewhitecolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
