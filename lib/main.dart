import 'package:flutter/material.dart';
import 'package:mstech/core/app/app.dart';
import 'package:mstech/di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MainApp());
}
