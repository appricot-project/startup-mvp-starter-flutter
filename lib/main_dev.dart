import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/my_app.dart';
import 'package:startup_mvp_starter_flutter/utils/app_config.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(flavor: Flavor.dev);
  runApp(const MyApp());
}
