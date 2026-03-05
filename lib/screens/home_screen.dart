import 'package:flutter/material.dart';
import 'package:musicdp/screens/login_screen.dart';
import 'package:musicdp/screens/local_songs_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:musicdp/screens/bottom_status_bar.dart';
import 'package:musicdp/screens/online_songs_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<bool> requestMusicPermission() async {   // UPDATED
    var status = await Permission.audio.request();

    if (status.isGranted) {
      debugPrint("Audio permission granted");
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 61, 36),
        foregroundColor: Colors.greenAccent,
        title: const Text("MusicDP: ddprasad@gmail.com"),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// Search
          TextField(
            style: const TextStyle(
              color: Colors.lightGreenAccent,
            ),
            decoration: InputDecoration(
              hintText: "Search songs...",
              hintStyle: const TextStyle(color: Colors.white54), // NEW
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 25),

          /// Recently Played
          const Text(
            "Recently Played",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.music_note, color: Colors.white),
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          /// Library
          const Text(
            "Your Library",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          /// LOCAL SONGS
          ListTile(
            leading: const Icon(Icons.folder, color: Colors.white),
            title: const Text("Local Songs",
                style: TextStyle(color: Colors.white)),
              onTap: () async {
                var status = await Permission.audio.request();
                if (status.isGranted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocalSongsScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Permission required to read songs")),
                  );
                }
              }
          ),

          ListTile(
            leading: const Icon(Icons.cloud, color: Colors.white),
            title: const Text("Online Collection",
                style: TextStyle(color: Colors.white)),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnlineSongsScreen(),
                ),
              );
            },
          ),
        ],
      ),

      /// Mini Player Placeholder
      bottomNavigationBar: const BottomStatusBar(
        text: "MusicDP • Ready",
      ),
    );
  }
}