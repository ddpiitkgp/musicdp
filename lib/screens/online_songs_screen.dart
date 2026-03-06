import 'package:flutter/material.dart';
import 'package:musicdp/services/online_music_service.dart';
import 'package:musicdp/player/audio_player_service.dart';
import 'package:musicdp/widgets/mini_player.dart';
import 'package:musicdp/database/database_helper.dart';
import 'package:musicdp/models/onlinesong.dart';
//import 'package:on_audio_query/on_audio_query.dart';

class OnlineSongsScreen extends StatefulWidget {
  const OnlineSongsScreen({super.key});
  @override
  State<OnlineSongsScreen> createState() => _OnlineSongsScreenState();
}

class _OnlineSongsScreenState extends State<OnlineSongsScreen> {

  final TextEditingController urlController = TextEditingController();
  final OnlineMusicService service = OnlineMusicService();
  final audioService = AudioPlayerService(); // Global audio player

  //List<String> songs = [];
  bool loading = false;

  List<String> savedUrls = [];
  String? selectedUrl;
  List<OnlineSongModel> songs = [];

  @override
  void initState() {
    super.initState();
    loadSavedUrls();
  }

  /// Load songs from URL
  Future<void> loadSongs() async {
    if (urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a URL")),
      );
      return;
    }
    setState(() {
      loading = true;
    });

    try {
      List<OnlineSongModel> result = await service.fetchSongs(urlController.text);
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

  /// Load previously used URLs
  Future<void> loadSavedUrls() async {
    savedUrls = await DatabaseHelper.instance.getUrls();
    if (savedUrls.isNotEmpty) {
      selectedUrl = savedUrls.first;
      urlController.text = selectedUrl!;
    }
    setState(() {});
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
          /// URL INPUT
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                /// Editable dropdown
                Expanded (
                child: SizedBox(
                  width: double.infinity,
                  child: DropdownMenu<String>(
                    controller: urlController,
                    width: double.infinity,
                    hintText: "Enter or Select Music URL",
                    enableFilter: true,
                    requestFocusOnTap: true,
                    textStyle: const TextStyle(
                      color: Colors.greenAccent,
                    ),
                    menuStyle: const MenuStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 25, 25, 25),
                      ),
                    ),
                    dropdownMenuEntries: savedUrls.map((url) {
                      return DropdownMenuEntry<String>(
                        value: url,
                        label: url,
                        labelWidget: Text(
                          url,
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onSelected: (value) {
                      urlController.text = value ?? "";
                    },
                  ),
                )
                ),
                const SizedBox(width: 10),
                /// GO button
                ElevatedButton(
                  onPressed: loadSongs,
                  child: const Text("Go"),
                ),
              ],
            ),
          ),

          /// LOADING INDICATOR
          if (loading)
            const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),

          /// SONG LIST
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                String url = songs[index].url;
                OnlineSongModel song = songs[index];
                String fileName = url.split("/").last;
                return ListTile(
                  leading: const Icon(Icons.cloud, color: Colors.white),
                  title: Text(
                    fileName,
                    style: const TextStyle(color: Colors.white),
                  ),
                    onTap: () async {
                      if (song.url != null) {
                        print("Playing: ${song.title}");
                        await audioService.playUrl(
                          song.url,
                          title: song.title,
                        );
                        // 🔹 Save to history
                        await DatabaseHelper.instance.insertSong(
                          title: song.title,
                          url: song.url,
                          artist: song.artist,
                        );

                        setState(() {});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("File path not found")),
                        );
                      }
                    },
                );
              },
            ),
          ),

        ],
      ),

      bottomNavigationBar: const MiniPlayer(),
    );
  }
}