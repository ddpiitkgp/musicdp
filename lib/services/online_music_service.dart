import 'package:http/http.dart' as http;

class OnlineMusicService {

  Future<List<String>> fetchSongs(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception("Cannot reach server");
    }
    final body = response.body;
    RegExp exp = RegExp(r'href="([^"]+\.mp3)"', caseSensitive: false);
    Iterable<Match> matches = exp.allMatches(body);
    List<String> songs = [];
    for (var m in matches) {
      String file = m.group(1)!;
      if (!file.startsWith("http")) {
        file = "$url/$file";
      }
      songs.add(file);
    }
    return songs;
  }
}