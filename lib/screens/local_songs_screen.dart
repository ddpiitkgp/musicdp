import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:musicdp/screens/bottom_status_bar.dart';


class LocalSongsScreen extends StatefulWidget {
  const LocalSongsScreen({super.key});

  @override
  State<LocalSongsScreen> createState() => _LocalSongsScreenState();
}

class _LocalSongsScreenState extends State<LocalSongsScreen> {

  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> songs = [];

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {

    var status = await Permission.storage.request();

    if (status.isGranted) {
      loadSongs();
    }
  }

  Future<void> loadSongs() async {

    List<SongModel> allSongs = await _audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: SongSortType.TITLE,
    );

    setState(() {
      songs = allSongs;
    });
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
          ? const Center(
        child: Text(
          "No Songs Found",
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {

          final song = songs[index];

          return ListTile(
            title: Text(
              song.title,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              song.artist ?? "Unknown Artist",
              style: const TextStyle(color: Colors.white70),
            ),
            leading: const Icon(Icons.music_note, color: Colors.white),
          );
        },
      ),
      /// Mini Player Placeholder
      bottomNavigationBar: const BottomStatusBar(
        text: "MusicDP • Ready",
      ),
    );
  }
}