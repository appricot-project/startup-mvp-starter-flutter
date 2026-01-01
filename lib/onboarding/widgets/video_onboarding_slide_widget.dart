import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/onboarding/models/video_onboarding_slide_model.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_slide_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/my_circular_progress_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoOnboardingSlideWidget
    extends OnboardingSlideWidget<VideoOnboardingSlideModel> {
  VideoOnboardingSlideWidget({required super.slideModel});

  @override
  Widget build(BuildContext context) {
    return _VideoPlayerBody(slideModel: slideModel);
  }
}

class _VideoPlayerBody extends StatefulWidget {
  final VideoOnboardingSlideModel slideModel;

  const _VideoPlayerBody({required this.slideModel});

  @override
  State<_VideoPlayerBody> createState() => _VideoPlayerBodyState();
}

class _VideoPlayerBodyState extends State<_VideoPlayerBody> {
  late VideoPlayerController _controller;
  bool _showPlayButton = false;

  @override
  void initState() {
    super.initState();

    _showPlayButton = !widget.slideModel.autoPlay;

    _controller = VideoPlayerController.asset(widget.slideModel.assetPath)
      ..setLooping(widget.slideModel.loop)
      ..initialize().then((_) {
        if (widget.slideModel.autoPlay) {
          _controller.play();
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return MyCircularProgressIndicator();
    }

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          // if (_showPlayButton)
          GestureDetector(
            onTap: () {
              if (_showPlayButton) {
                _controller.play();
                setState(() {
                  _showPlayButton = false;
                });
              } else {
                _controller.pause();
                setState(() {
                  _showPlayButton = true;
                });
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _showPlayButton ? Icons.play_arrow : Icons.pause,
                    color: Colors.white,
                    size: 42,
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
