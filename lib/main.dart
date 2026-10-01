
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unisoundpos/pages/loginpin.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(1920, 1080));
    WindowManager.instance.setMaximumSize(const Size(1920, 1080));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'UNISOUND BANGKOK POS',
      debugShowCheckedModeBanner: false,
      home: Loginpin(),
    );
  }
}
