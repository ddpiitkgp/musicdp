class OnlineSongModel {
  final String title;
  final String url;
  final String artist;
  final bool isFolder;

  OnlineSongModel({
    required this.title,
    required this.url,
    required this.artist,
    required this.isFolder,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'artist': artist,
      'isFolder': isFolder
    };
  }
}
