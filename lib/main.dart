import 'package:democart/app/di/app_locator.dart';
import 'package:democart/app/bootstrap/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupAppLocator();
  runApp(const DemoCartApp());
}
