import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mended/provider/flicks_pro.dart';
import 'package:mended/theme/colors.dart';
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

    videoPlayerController = VideoPlayerController.network(
      widget.videoUrl,
    );

    videoPlayerController.addListener(() {
      setState(() {});
    });
    videoPlayerController.setLooping(true);
    videoPlayerController.initialize().then((_) => setState(() {}));
    videoPlayerController.play();

    Provider.of<FlicksPro>(context, listen: false).addViews(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    // if (widget.play) {
    //   videoPlayerController.play();
    // } else {
    //   videoPlayerController.pause();
    // }
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Palette.themecolor,
      ),
      child: videoPlayerController.value.isInitialized
          ? VideoPlayer(
              videoPlayerController,
            )
          : const Center(
              child: SpinKitSquareCircle(
                color: themewhitecolor,
                size: 50.0,
              ),
            ),
      
    );
  }
}
