class OnlineSongModel {
  String title;
  String url;
  String artist;

  OnlineSongModel({
    required this.title,
    required this.url,
    required this.artist,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'artist': artist,
    };
  }
}
