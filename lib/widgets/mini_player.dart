import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicdp/player/audio_player_service.dart';
import 'package:musicdp/utils/general_utils.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final AudioPlayerService player = AudioPlayerService();

  @override
  Widget build(BuildContext context) {
    String title = player.currentTitle ?? "No Song";

    return Container(
      height: 60,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          /// Song Title
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          /// Previous Button
          IconButton(
            icon: const Icon(Icons.skip_previous, color: Colors.greenAccent),
            onPressed: () {
              player.previous();
              setState(() {}); // refresh title
            },
          ),

          /// Play / Pause Button
          IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.greenAccent),
            onPressed: () {
              player.toggle();
              setState(() {}); // refresh button if needed
            },
          ),

          /// Next Button
          IconButton(
            icon: const Icon(Icons.skip_next, color: Colors.greenAccent),
            onPressed: () {
              player.next();
              setState(() {}); // refresh title
            },
          ),
        ],
      ),
    );
  }
}