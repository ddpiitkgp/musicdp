/*
import 'package:just_audio/just_audio.dart';

final OctopadAudio octopadAudio = OctopadAudio();

class OctopadAudio {
  final Map<String,String> _padPaths = {};
  final List<AudioPlayer> _players = [];
  int _playerIndex = 0;

  static const List<String> banks = ["A","B","C","D","E","F","G","H"];

  Future<void> init() async {
    for (int i = 0; i < 8; i++) {
      _players.add(AudioPlayer());
    }

    for (var bank in banks) {
      for (int i = 0; i < 8; i++) {
        String pad = "$bank$i";
        String path = "assets/octopad/wav/$bank/$pad.wav";
        _padPaths[pad] = path;
      }
    }

    print("Pads mapped: ${_padPaths.length}");
  }

  Future<void> play(String pad) async {
    final path = _padPaths[pad];
    if (path == null) {
      print("Pad not found: $pad");
      return;
    }

    final player = _players[_playerIndex];
    _playerIndex = (_playerIndex + 1) % _players.length;

    try {
      await player.setAsset(path);
      player.play();
    } catch (e) {
      print("Playback error for $pad");
    }
  }

  Future<void> dispose() async {
    for (var player in _players) {
      await player.dispose();
    }
  }
}
 */