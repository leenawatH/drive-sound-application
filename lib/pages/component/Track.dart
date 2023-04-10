class Track {
  final String title;
  final String artist;
  final String albumName;
  final String imageUrl;
  final String releaseDate;
  final int popularity;
  String? lyrics;
  Track(
      {required this.title,
      required this.artist,
      required this.imageUrl,
      required this.albumName,
      required this.releaseDate,
      required this.popularity,
      this.lyrics});

  factory Track.fromData(Map<String, dynamic> data) {
    final title = data['name'];
    final artist = data['artists'][0]['name'];
    final albumName = data['album']['name'];
    final imageUrl = data['album']['images'][0]['url'];
    final releaseDate = data['album']['release_date'];
    final popularity = data['popularity'];

    return Track(
      title: title,
      artist: artist,
      albumName: albumName,
      imageUrl: imageUrl,
      releaseDate: releaseDate,
      popularity: popularity,
    );
  }
}
