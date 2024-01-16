import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class ReelsVideoWidget extends StatefulWidget {
  final bool play;
  final String videoUrl;

  const ReelsVideoWidget({
    Key? key,
    required this.videoUrl,
    required this.play,
  }) : super(key: key);

  @override
  _ReelsVideoWidgetState createState() => _ReelsVideoWidgetState();
}

class _ReelsVideoWidgetState extends State<ReelsVideoWidget> {
  late VideoPlayerController videoPlayerController;
  late final PodPlayerController controller;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.setLooping(true);
        if (widget.play) {
          videoPlayerController.play();
        } else {
          videoPlayerController.pause();
        }

        // videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.play) {
      videoPlayerController.play();
    } else {
      videoPlayerController.pause();
    }
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),
    );
  }
}

