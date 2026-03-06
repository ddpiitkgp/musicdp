import 'package:flutter/material.dart';
import 'package:musicdp/screens/login_screen.dart';
import 'package:musicdp/screens/local_songs_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:musicdp/screens/bottom_status_bar.dart';
import 'package:musicdp/screens/online_songs_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedInstrument = 0;
  TextEditingController beatController = TextEditingController();
  List<String> instruments = [ "Kick", "Snare", "HiHat", "Clap", "Tom", "Crash", "Ride", "Bass"];

  Future<bool> requestMusicPermission() async {
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

          /// SEARCH
          TextField(
            style: const TextStyle(color: Colors.lightGreenAccent),
            decoration: InputDecoration(
              hintText: "Search songs...",
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 25),

          /// LIBRARY
          const Text(
            "Your Library",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

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
              }
            },
          ),

          /// ONLINE SONGS
          ListTile(
            leading: const Icon(Icons.cloud, color: Colors.white),
            title: const Text("Online Collection",
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnlineSongsScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 25),

          /// OCTOPAD SECTION
          const Text(
            "Beat Pad",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          /// INSTRUMENT DOTS
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: instruments.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedInstrument = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedInstrument == index
                          ? Colors.greenAccent
                          : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          /// OCTOPAD GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {

              String padName =
                  "${String.fromCharCode(65 + selectedInstrument)}$index";

              return GestureDetector(
                onTap: () {

                  setState(() {
                    beatController.text += "$padName ";
                  });

                  debugPrint("Pad pressed: $padName");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      padName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          /// BEAT RECORDER
          TextField(
            controller: beatController,
            style: const TextStyle(color: Colors.white),
            maxLines: 2,
            decoration: InputDecoration(
              labelText: "Recorded Beats",
              labelStyle: const TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 10),

        ],
      ),

      bottomNavigationBar: const BottomStatusBar(
        text: "MusicDP • Ready",
      ),
    );
  }
}