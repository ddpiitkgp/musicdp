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
  AudioPlayerService audPlayerService = AudioPlayerService();

  @override
  Widget build(BuildContext context) {
    String title = audPlayerService.currentTitle ?? "No Song";

    return Container(
      height: 60,
      color: Colors.grey.shade600,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          /// Song Title
          Expanded(
            child: getMarquee(title)
          ),

          /// Previous Button
          IconButton(
            icon: const Icon(Icons.skip_previous, color: Colors.black87),
            onPressed: () {
              audPlayerService.previous();
              setState(() {}); // refresh title
            },
          ),

          /// Play / Pause Button
          StreamBuilder<PlayerState>(
            stream: audPlayerService.playerStateStream,
            builder: (context, snapshot) {
              final playing = audPlayerService.player.playing ?? false; //snapshot.data?.playing ?? false;
              return IconButton(
                icon: Icon(
                  playing ? Icons.pause : Icons.play_arrow,
                  color: Colors.black87,
                ),
                onPressed: () {
                  audPlayerService.toggle();
                },
              );
            },
          ),
          // IconButton(
          //   icon: Icon(
          //     audPlayerService.player.playing ? Icons.pause : Icons.play_arrow,
          //     color: Colors.greenAccent,
          //   ),
          //   onPressed: () {
          //     audPlayerService.toggle();
          //     setState(() {}); // refresh button if needed
          //   }
          // ),

          /// Next Button
          IconButton(
            icon: const Icon(Icons.skip_next, color: Colors.black87),
            onPressed: () {
              audPlayerService.next();
              setState(() {}); // refresh title
            },
          ),
        ],
      ),
    );
  }
}