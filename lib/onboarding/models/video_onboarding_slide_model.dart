class VideoOnboardingSlideModel {
  final String assetPath;
  final bool autoPlay;
  final bool loop;

  VideoOnboardingSlideModel({
    required this.assetPath,
    this.autoPlay = true,
    this.loop = true,
  });
}