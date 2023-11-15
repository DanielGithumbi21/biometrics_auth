import 'package:flutter/material.dart';
import './finger_print_auth.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fingerprint Auth',
      debugShowCheckedModeBanner: false,
      home: FingerprintAuth() ,
    );
  }
}

