import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';
// import 'package:musicdp/player/pad_audio_manager.dart';


class AudioPlayerService {

  //final AudioPlayer _player = AudioPlayer();
  List<String> _playlist = []; // list of URLs or file paths
  int _currentIndex = -1;       // current playing index
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

  /*
  Future<void> playPad(String instrument, int pad) async {
    String padName = "$instrument$pad";
    octopadAudio.play(padName);
  }
  */
  /// PLAY LOCAL FILE
  Future<void> playLocal(
      String path, {
        required String title,
        List<String>? playlist,
        int startIndex = 0,
      }) async {
    try {
      // Set playlist if provided
      if (playlist != null && playlist.isNotEmpty) {
        _playlist = playlist;
        _currentIndex = startIndex;
      }
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
  Future<void> playUrl(
      String url, {
        required String title,
        List<String>? playlist,
        int startIndex = 0,
      }) async {
    try {
      // Set playlist if provided
      if (playlist != null && playlist.isNotEmpty) {
        _playlist = playlist;
        _currentIndex = startIndex;
      }
      currentTitle = title;
      currentSource = url;
      await player.setUrl(url);
      player.play();
      debugPrint("Streaming: $url");
    } catch (e) {
      debugPrint("Error streaming: $e");
    }
  }

  Future<void> next() async {
    if (_playlist.isEmpty) return;

    _currentIndex++;
    if (_currentIndex >= _playlist.length) _currentIndex = 0;

    String url = _playlist[_currentIndex];
    await playUrl(url, title: url.split('/').last);
  }

  Future<void> previous() async {
    if (_playlist.isEmpty) return;

    _currentIndex--;
    if (_currentIndex < 0) _currentIndex = _playlist.length - 1;

    String url = _playlist[_currentIndex];
    await playUrl(url, title: url.split('/').last);
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
  /// Playlist Inclusion
  void setPlaylist(List<String> list, int startIndex) {
    _playlist = list;
    _currentIndex = startIndex;
  }

  void toggle() {
    if (player.playing) {
      player.pause();   // pause playback
    } else {
      player.play();    // resume or start playback
    }
  }


}