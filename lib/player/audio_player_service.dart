import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class AudioPlayerService {

  /// Singleton (important so only one player exists in the whole app)
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() {
    return _instance;
  }

  AudioPlayerService._internal();
  final AudioPlayer player = AudioPlayer();
  /// Current song info for status bar
  String currentTitle = "";
  String currentSource = "";

  /// PLAY LOCAL FILE
  Future<void> playLocal(String path, {String title = ""}) async {

    try {

      currentTitle = title;
      currentSource = path;
      await player.setFilePath(path);
      player.play();
      debugPrint("Playing local file: $path");
    } catch (e) {
      debugPrint("Error playing local file: $e");
    }
  }

  /// PLAY ONLINE URL
  Future<void> playUrl(String url, {String title = ""}) async {

    try {
      currentTitle = title;
      currentSource = url;
      await player.setUrl(url);
      player.play();
      debugPrint("Streaming: $url");
    } catch (e) {
      debugPrint("Error streaming: $e");
    }
  }

  /// Pause
  Future<void> pause() async {
    await player.pause();
  }
  /// Resume
  Future<void> resume() async {
    await player.play();
  }
  /// Stop
  Future<void> stop() async {
    await player.stop();
  }
  /// Seek
  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  /// Streams (useful for UI updates)
  Stream<PlayerState> get playerStateStream => player.playerStateStream;
  Stream<Duration?> get durationStream => player.durationStream;
  Stream<Duration> get positionStream => player.positionStream;

  /// Dispose (usually not used because singleton)
  void dispose() {
    player.dispose();
  }
}