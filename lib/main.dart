import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MusicDP());
}

class MusicDP extends StatelessWidget {
  const MusicDP({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}