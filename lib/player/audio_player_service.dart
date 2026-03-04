import 'package:just_audio/just_audio.dart';

class AudioPlayerService {

  static final AudioPlayerService _instance = AudioPlayerService._internal();
  String? currentSongTitle;

  factory AudioPlayerService() {
    return _instance;
  }

  AudioPlayerService._internal();

  final AudioPlayer player = AudioPlayer();

  Future<void> playSong(String path) async {
    await player.setFilePath(path);
    player.play();
  }

  void pause() {
    player.pause();
  }

  void stop() {
    player.stop();
  }
}