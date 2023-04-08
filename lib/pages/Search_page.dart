import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Track> _tracks = [];

  void _handleSearch(String query) {
    _searchTracks(query);
  }

  Future<void> _searchTracks(String query) async {
    if (query.isEmpty) {
      setState(() {
        _tracks = [];
      });
      return;
    }
    final clientId = 'c9229c368b5f4a95bab7b83236096d97';
    final clientSecret = '53cd4795d5ee468a970982ffe1c371d7';
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret')),
      },
      body: {
        'grant_type': 'client_credentials',
      },
    );
    final data = jsonDecode(response.body);
    final token = data['access_token'];
    final url = Uri.https(
      'api.spotify.com',
      '/v1/search',
      {'q': query, 'type': 'track'},
    );
    final response2 = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response2.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response2.body);
      final List<dynamic> tracks = data['tracks']['items'];
      setState(() {
        _tracks = tracks.map((trackData) => Track.fromData(trackData)).toList();
      });
    } else {
      throw Exception('Failed to load tracks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
              controller: _searchController,
              onChanged: _handleSearch,
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: ListView.builder(
                itemCount: _tracks.length,
                itemBuilder: (BuildContext context, int index) {
                  final track = _tracks[index];
                  return ListCard(
                    title: track.title,
                    artist: track.artist,
                    imageUrl: track.imageUrl,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Track {
  final String title;
  final String artist;
  final String imageUrl;

  const Track({
    required this.title,
    required this.artist,
    required this.imageUrl,
  });

  factory Track.fromData(Map<String, dynamic> data) {
    final title = data['name'];
    final artist = data['artists'][0]['name'];
    final imageUrl = data['album']['images'][0]['url'];
    return Track(title: title, artist: artist, imageUrl: imageUrl);
  }
}

class ListCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;

  const ListCard({
    Key? key,
    required this.title,
    required this.artist,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        subtitle: Text(artist),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
