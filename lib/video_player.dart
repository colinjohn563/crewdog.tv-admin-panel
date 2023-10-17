import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CustomVideoPlayer({super.key, required this.videoUrl});

  @override
  CustomVideoPlayerState createState() => CustomVideoPlayerState();
}

class CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late CachedVideoPlayerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.network(
      widget.videoUrl,
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: true,
      ),
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPlaying = !_isPlaying;
          _isPlaying ? _controller.play() : _controller.pause();
        });
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CachedVideoPlayer(
                _controller,
              ),
            ),
          if (!_controller.value.isInitialized)
            const CircularProgressIndicator(
              color: Colors.black,
            ),
          if (_isPlaying)
            IconButton(
              icon: const Icon(
                Icons.pause,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isPlaying = false;
                  _controller.pause();
                });
              },
            )
          else
            IconButton(
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isPlaying = true;
                  _controller.play();
                });
              },
            ),
        ],
      ),
    );
  }
}
