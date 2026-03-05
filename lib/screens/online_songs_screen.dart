import 'package:flutter/material.dart';
import 'package:musicdp/services/online_music_service.dart';
import 'package:musicdp/player/audio_player_service.dart';

class OnlineSongsScreen extends StatefulWidget {
  const OnlineSongsScreen({super.key});

  @override
  State<OnlineSongsScreen> createState() => _OnlineSongsScreenState();
}

class _OnlineSongsScreenState extends State<OnlineSongsScreen> {

  final TextEditingController urlController =
  TextEditingController(text: "http://127.0.0.1/Music");
  final OnlineMusicService service = OnlineMusicService();
  final AudioPlayerService player = AudioPlayerService();

  List<String> songs = [];
  bool loading = false;

  Future<void> loadSongs() async {
    setState(() {
      loading = true;
    });
    try {
      List<String> result = await service.fetchSongs(urlController.text);
      setState(() {
        songs = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Online Collection"),
        backgroundColor: const Color.fromARGB(255, 10, 61, 36),
        foregroundColor: Colors.greenAccent,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: urlController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter URL",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: loadSongs,
                  child: const Text("Go"),
                )

              ],
            ),
          ),

          if (loading)
            const CircularProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                String url = songs[index];
                String name = url.split("/").last;
                return ListTile(
                  leading: const Icon(Icons.cloud, color: Colors.white),
                  title: Text(name,
                      style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    player.playUrl(url);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}