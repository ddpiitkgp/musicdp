import 'package:flutter/material.dart';
import 'package:musicdp/screens/login_screen.dart';
import 'package:musicdp/screens/local_songs_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

          ListTile(
            leading: const Icon(Icons.folder, color: Colors.white),
            title: const Text("Local Songs",
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LocalSongsScreen(), 
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.cloud, color: Colors.white),
            title: const Text("Online Collection",
                style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ],
      ),

      /// Mini Player Placeholder
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white10,
        child: const Center(
          child: Text(
            "Mini Player (Coming Soon)",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}