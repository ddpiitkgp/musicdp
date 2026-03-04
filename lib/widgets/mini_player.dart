import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicdp/player/audio_player_service.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {

  final audioService = AudioPlayerService();
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = audioService.player;

    // Update UI whenever playback state changes
    player.playerStateStream.listen((state) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    // Current playing song info
    final currentSong = audioService.currentSongTitle ?? "No song playing";
    final isPlaying = player.playing;

    return Container(
      height: 60,
      color: const Color.fromARGB(255, 10, 61, 36),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.music_note, color: Colors.greenAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              currentSong,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.greenAccent,
            ),
            onPressed: () {
              if (isPlaying) {
                player.pause();
              } else {
                player.play();
              }
            },
          ),
        ],
      ),
    );
  }
}