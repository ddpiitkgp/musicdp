import 'package:flutter/foundation.dart';
import 'package:musicdp/player/audio_player_service.dart';

class AudioService extends ChangeNotifier {

  final AudioPlayerService _playerService = AudioPlayerService();

  String currentTitle = "";
  bool isPlaying = false;

  /// Play local file
  Future<void> playLocal(String path, {String title = ""}) async {

    await _playerService.playLocal(path, title: title);

    currentTitle = title;
    isPlaying = true;

    notifyListeners();
  }

  /// Play from URL
  Future<void> playUrl(String url, {String title = ""}) async {

    await _playerService.playUrl(url, title: title);

    currentTitle = title;
    isPlaying = true;

    notifyListeners();
  }

  /// Pause
  Future<void> pause() async {
    await _playerService.pause();
    isPlaying = false;
    notifyListeners();
  }

  /// Resume
  Future<void> resume() async {
    await _playerService.resume();
    isPlaying = true;
    notifyListeners();
  }

  /// Toggle play/pause
  Future<void> toggle() async {

    if (isPlaying) {
      await pause();
    } else {
      await resume();
    }
  }

  String get title => currentTitle;

}