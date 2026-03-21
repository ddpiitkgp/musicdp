import 'dart:io';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:musicdp/widgets/mini_player.dart';
import 'package:musicdp/player/audio_player_service.dart';
import 'package:musicdp/database/database_helper.dart';
import 'package:musicdp/utils/general_utils.dart';
import 'package:just_audio/just_audio.dart';


class LocalSongsScreen extends StatefulWidget {
  const LocalSongsScreen({super.key});
  @override
  State<LocalSongsScreen> createState() => _LocalSongsScreenState();
}

class _LocalSongsScreenState extends State<LocalSongsScreen> {

  final OnAudioQuery _audioQuery = OnAudioQuery();
  final audioService = AudioPlayerService(); // Global audio player
  List<SongModel> songs = [];

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  Future<void> loadSongs() async {
    bool permission = await _audioQuery.permissionsStatus();
    if (!permission) {
      permission = await _audioQuery.permissionsRequest();
    }
    if (permission) {
      List<SongModel> result = await _audioQuery.querySongs(
        sortType: SongSortType.DATE_ADDED,
        orderType: OrderType.DESC_OR_GREATER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      List<SongModel> filteredSongs = [];
      for (var song in result) {
        File file = File(song.data);
        if (AudioUtils.isValidExtension(song.data) && await AudioUtils.validateFile(file)) {
          filteredSongs.add(song);
        }
      }
      setState(() {
        songs = filteredSongs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 61, 36),
        foregroundColor: Colors.greenAccent,
        title: const Text("Local Songs"),
      ),

      body: songs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          SongModel song = songs[index];
          return StreamBuilder<PlayerState>(
            stream: audioService.playerStateStream,
            builder: (context, snapshot) {
              final playing = snapshot.data?.playing ?? false;
              final isCurrentSong = audioService.currentTitle == song.title;
              return ListTile(
                tileColor: isCurrentSong
                    ? Colors.grey.shade800
                    : Colors.transparent,
                leading: const Icon(Icons.music_note, color: Colors.white),
                title: Text(
                  song.title,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  song.artist ?? "Unknown",
                  style: const TextStyle(color: Colors.white54),
                ),
                trailing: IconButton(
                  icon: Icon(
                    isCurrentSong && playing ? Icons.pause : Icons.play_arrow,
                    color: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (isCurrentSong && playing) {
                      await audioService.pause();
                    } else {
                      await audioService.playLocal(
                        song.data,
                        title: song.title,
                      );
                      await DatabaseHelper.instance.insertSong(
                        title: song.title,
                        url: song.data,
                        artist: song.artist,
                      );
                    }

                  },
                ),
                onTap: () async {
                  await audioService.playLocal(
                    song.data,
                    title: song.title,
                  );
                  await DatabaseHelper.instance.insertSong(
                    title: song.title,
                    url: song.data,
                    artist: song.artist,
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}