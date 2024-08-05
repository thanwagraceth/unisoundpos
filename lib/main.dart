import 'package:flutter/material.dart';
import 'package:unisoundpos/pages/loginpin.dart';

void main() {
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
