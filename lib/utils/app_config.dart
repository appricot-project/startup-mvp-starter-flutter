enum Flavor { prod, dev }

class AppConfig {
  late Flavor flavor;

  final String baseUrl;
  final String refreshPath;

  factory AppConfig.create({Flavor flavor = Flavor.dev}) {
    String baseUrl;
    String refreshPath;
    switch (flavor) {
      case Flavor.dev:
        baseUrl = '';
        refreshPath = '';
      case Flavor.prod:
        baseUrl = '';
        refreshPath = '';
    }

    return AppConfig(
      flavor: flavor,
      baseUrl: baseUrl,
      refreshPath: refreshPath,
    );
  }

  AppConfig({
    required this.flavor,
    required this.baseUrl,
    required this.refreshPath,
  });
}
