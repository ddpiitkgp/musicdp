import 'package:http/http.dart' as http;
import 'package:musicdp/models/onlinesong.dart';

class OnlineMusicService {

  Future<List<OnlineSongModel>> fetchSongs(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception("Cannot reach server");
    }
    final body = response.body;
    RegExp exp = RegExp(r'href="([^"]+\.mp3)"', caseSensitive: false);
    Iterable<Match> matches = exp.allMatches(body);
    List<OnlineSongModel> songs = [];
    for (var m in matches) {
      String file = m.group(1)!;
      if (!file.startsWith("http")) {
        file = "$url/$file";
      }
      /// Extract file name as title
      String title = file.split("/").last.replaceAll(".mp3", "");
      songs.add(
        OnlineSongModel(
          title: title,
          url: file,
          artist: "Online",
        ),
      );
    }

    return songs;
  }
}