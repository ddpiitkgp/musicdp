import 'dart:io';
import 'package:http/io_client.dart';
import 'package:musicdp/models/onlinesong.dart';

class OnlineMusicService {

  Future<List<OnlineSongModel>> fetchItems(String url) async {
    final uri = Uri.parse(url);

    // allow self-signed certificates
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    final ioClient = IOClient(httpClient);
    final response = await ioClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Cannot reach server");
    }

    final body = response.body;

    // capture all links from nginx directory listing
    RegExp exp = RegExp(r'href="([^"]+)"', caseSensitive: false);
    Iterable<Match> matches = exp.allMatches(body);

    List<OnlineSongModel> items = [];
    Set<String> seen = {};
    bool isFolder = false, isAudio = false;
    for (var m in matches) {
      String link = m.group(1)!;

      // skip parent directory
      if (link == "../") continue;

      Uri itemUri = uri.resolve(link);
      String fullUrl = itemUri.toString();

      if (seen.contains(fullUrl)) continue;
      seen.add(fullUrl);

      isFolder = link.endsWith("/");

      isAudio = link.toLowerCase().endsWith(".mp3") ||
          link.toLowerCase().endsWith(".flac") ||
          link.toLowerCase().endsWith(".wav") ||
          link.toLowerCase().endsWith(".m4a");

      if (!isFolder && !isAudio) continue;

      String name = itemUri.pathSegments.last;

      // folders have empty last segment sometimes
      if (isFolder) {
        name = itemUri.pathSegments[itemUri.pathSegments.length - 2];
      }

      name = name
          .replaceAll("%20", " ")
          .replaceAll(RegExp(r'\.(mp3|flac|wav|m4a)$', caseSensitive: false), "");

      items.add(
        OnlineSongModel(
          title: name,
          url: fullUrl,
          artist: isFolder ? "Folder" : "Online",
          isFolder: isFolder,
        ),
      );
    }

    return items;
  }
}