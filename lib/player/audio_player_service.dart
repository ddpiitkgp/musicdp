import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class AudioPlayerService {
  // Singleton: one player for the whole app
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;
  AudioPlayerService._internal();

  final AudioPlayer player = AudioPlayer();

  // Playlist and current index
  List<String> _playlist = [];
  int _currentIndex = -1;

  // Current song info
  String currentTitle = "";
  String currentSource = "";
  String currentArtist = ""; // NEW: optional artist
  String currentImage = "";  // NEW: optional album art URL or path

  /// Play local file
  Future<void> playLocal(
      String path, {
        required String title,
        String artist = "",
        String image = "",
        List<String>? playlist,
        int startIndex = 0,
      }) async {
    try {
      if (playlist != null && playlist.isNotEmpty) {
        _playlist = playlist;
        _currentIndex = startIndex;
      }
      currentTitle = title;
      currentSource = path;
      currentArtist = artist;
      currentImage = image;

      await player.setFilePath(path);
      await player.play();
      debugPrint("Playing local file: $path");
    } catch (e) {
      debugPrint("Error playing local file: $e");
    }
  }

  /// Play online URL
  Future<void> playUrl(
      String url, {
        required String title,
        String artist = "",
        String image = "",
        List<String>? playlist,
        int startIndex = 0,
      }) async {
    try {
      if (playlist != null && playlist.isNotEmpty) {
        _playlist = playlist;
        _currentIndex = startIndex;
      }
      currentTitle = title;
      currentSource = url;
      currentArtist = artist;
      currentImage = image;

      await player.setUrl(url);
      await player.play();
      debugPrint("Streaming: $url");
    } catch (e) {
      debugPrint("Error streaming: $e");
    }
  }

  /// Playback controls
  Future<void> next() async {
    if (_playlist.isEmpty) return;

    _currentIndex++;
    if (_currentIndex >= _playlist.length) _currentIndex = 0;

    String url = _playlist[_currentIndex];
    await playUrl(
      url,
      title: url.split('/').last,
      artist: "",
      image: "",
    );
  }

  Future<void> previous() async {
    if (_playlist.isEmpty) return;

    _currentIndex--;
    if (_currentIndex < 0) _currentIndex = _playlist.length - 1;

    String url = _playlist[_currentIndex];
    await playUrl(
      url,
      title: url.split('/').last,
      artist: "",
      image: "",
    );
  }

  Future<void> pause() async => await player.pause();
  Future<void> resume() async => await player.play();
  Future<void> stop() async => await player.stop();
  Future<void> seek(Duration position) async => await player.seek(position);

  void toggle() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void setPlaylist(List<String> list, int startIndex) {
    _playlist = list;
    _currentIndex = startIndex;
  }

  /// Streams for UI
  Stream<PlayerState> get playerStateStream => player.playerStateStream;
  Stream<Duration?> get durationStream => player.durationStream;
  Stream<Duration> get positionStream => player.positionStream;

  void dispose() => player.dispose();
}