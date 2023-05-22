import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/canton/canton.dart';
import 'package:video_player/video_player.dart';
import 'package:ptt_rtmb/features/video_player/controls_overlay.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Canton canton;

  const VideoPlayerWidget({Key? key, required this.canton}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.network(widget.canton.presentation_video)
          ..initialize().then((_) {
            setState(() {});
          });
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(padding: const EdgeInsets.only(top: 20.0)),
          Container(
            padding: const EdgeInsets.all(20),
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        ControlsOverlay(controller: _controller),
                        VideoProgressIndicator(_controller,
                            allowScrubbing: true),
                      ],
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
