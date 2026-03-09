import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicdp/player/audio_player_service.dart';
import 'package:musicdp/utils/general_utils.dart';
import 'package:musicdp/widgets/expanded_player.dart';

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
      color: Colors.green.shade900,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Top Row: Song title + controls
          Row(
            children: [
              Expanded(
                child: getMarquee(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              /// Expand Button
              IconButton(
                icon: const Icon(Icons.expand_less, color: Colors.greenAccent),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => ExpandedPlayer(
                      audPlayerService: audPlayerService,
                    ),
                  );
                },
              ),

              /// Previous Button
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.green),
                onPressed: () {
                  audPlayerService.previous();
                  setState(() {});
                },
              ),

              /// Play / Pause
              StreamBuilder<PlayerState>(
                stream: audPlayerService.player.playerStateStream,
                builder: (context, snapshot) {
                  final playing = audPlayerService.player.playing;
                  return IconButton(
                    icon: Icon(
                      playing ? Icons.pause : Icons.play_arrow,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      audPlayerService.toggle();
                      setState(() {});
                    },
                  );
                },
              ),

              /// Next Button
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.green),
                onPressed: () {
                  audPlayerService.next();
                  setState(() {});
                },
              ),
            ],
          ),

          /// Seek Bar + Timer
          StreamBuilder<Duration>(
            stream: audPlayerService.player.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              final duration = audPlayerService.player.duration ?? Duration.zero;

              return Row(
                children: [
                  /// Elapsed Time
                  Text(
                    _formatDuration(position),
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),

                  /// Slider
                  Expanded(
                    child: Slider(
                      min: 0,
                      max: duration.inMilliseconds.toDouble().clamp(0, double.infinity),
                      value: position.inMilliseconds.toDouble().clamp(0, duration.inMilliseconds.toDouble()),
                      activeColor: Colors.greenAccent,
                      inactiveColor: Colors.white24,
                      onChanged: (value) {
                        audPlayerService.player.seek(Duration(milliseconds: value.toInt()));
                      },
                    ),
                  ),

                  /// Total Duration
                  Text(
                    _formatDuration(duration),
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// Helper to format mm:ss
  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}