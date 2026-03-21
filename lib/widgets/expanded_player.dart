import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicdp/player/audio_player_service.dart';

class ExpandedPlayer extends StatelessWidget {
  final AudioPlayerService audPlayerService;

  const ExpandedPlayer({super.key, required this.audPlayerService});

  @override
  Widget build(BuildContext context) {
    final title = audPlayerService.currentTitle ?? "No Song";
    final artist = audPlayerService.currentArtist ?? "Unknown Artist";
    final imageUrl = audPlayerService.currentImage ?? ''; // URL or local path from mp3

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// Drag handle
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          /// Album Art
          if (imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.green.shade900,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.music_note, size: 100, color: Colors.white24),
            ),

          const SizedBox(height: 20),

          /// Title & Artist
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            artist,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          /// Seek Bar + Timer
          StreamBuilder<Duration>(
            stream: audPlayerService.player.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              final duration = audPlayerService.player.duration ?? Duration.zero;

              return Row(
                children: [
                  Text(
                    _formatDuration(position),
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
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
                  Text(
                    _formatDuration(duration),
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          /// Controls: Prev / Play / Next
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.greenAccent),
                iconSize: 40,
                onPressed: () => audPlayerService.previous(),
              ),
              StreamBuilder<PlayerState>(
                stream: audPlayerService.player.playerStateStream,
                builder: (context, snapshot) {
                  final playing = audPlayerService.player.playing;
                  return IconButton(
                    icon: Icon(playing ? Icons.pause_circle_filled : Icons.play_circle_filled, color: Colors.greenAccent),
                    iconSize: 60,
                    onPressed: () => audPlayerService.toggle(),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.greenAccent),
                iconSize: 40,
                onPressed: () => audPlayerService.next(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}