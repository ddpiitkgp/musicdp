import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
//import 'package:musicdp/player/pad_audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await octopadAudio.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 10, 61, 36), // same as AppBar
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
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