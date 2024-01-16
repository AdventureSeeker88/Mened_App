import 'package:flutter/material.dart';
import 'package:mended/provider/flicks_pro.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class FlicksVideoWidget extends StatefulWidget {
  final bool play;
  final String videoUrl;
  final String id;
  const FlicksVideoWidget({
    Key? key,
    required this.videoUrl,
    required this.play,
    required this.id,
  }) : super(key: key);

  @override
  _FlicksVideoWidgetState createState() => _FlicksVideoWidgetState();
}

class _FlicksVideoWidgetState extends State<FlicksVideoWidget> {
  late VideoPlayerController videoPlayerController;

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
      });

      Provider.of<FlicksPro>(context,listen: false).addViews(widget.id);
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
