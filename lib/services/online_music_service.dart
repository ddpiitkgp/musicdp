import 'package:http/http.dart' as http;
import 'package:musicdp/models/onlinesong.dart';

class OnlineMusicService {

  Future<List<OnlineSongModel>> fetchSongs(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception("Cannot reach server");
    }
    final body = response.body;
    // match mp3 links
    RegExp exp = RegExp(r'href="([^"]+\.mp3)"', caseSensitive: false);
    Iterable<Match> matches = exp.allMatches(body);
    List<OnlineSongModel> songs = [];
    Set<String> seen = {}; // avoid duplicates
    for (var m in matches) {
      String file = m.group(1)!;
      // build full URL safely
      Uri songUri = uri.resolve(file);
      String fullUrl = songUri.toString();
      if (seen.contains(fullUrl)) continue;
      seen.add(fullUrl);
      // extract filename
      String title = songUri.pathSegments.last
          .replaceAll(".mp3", "")
          .replaceAll("%20", " ");
      songs.add(
        OnlineSongModel(
          title: title,
          url: fullUrl,
          artist: "Online",
        ),
      );
    }

    return songs;
  }
}