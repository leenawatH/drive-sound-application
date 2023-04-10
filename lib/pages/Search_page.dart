import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './component/Track.dart';
import './component/ListCard.dart';
import 'DetailsPage.dart';

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

  Future<String> _fetchLyrics(String artist, String track) async {
    final musiXmatchApiKey = 'd399277239e1d2dfaecd885146898ee6';
    final url = Uri.https(
      'api.musixmatch.com',
      '/ws/1.1/matcher.lyrics.get',
      {
        'q_track': track,
        'q_artist': artist,
        'apikey': musiXmatchApiKey,
      },
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final lyrics = data['message']['body']['lyrics']['lyrics_body'];
      if (lyrics is String) {
        return lyrics.split('*').first;
      }
      return lyrics;
    } else {
      throw Exception('Failed to load lyrics');
    }
  }

  void _handleTrackTap(Track track) {
    _fetchLyrics(track.artist, track.title).then((lyrics) {
      setState(() {
        track.lyrics = lyrics;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(track: track),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Page',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white10,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.0),
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
                  return GestureDetector(
                    onTap: () => _handleTrackTap(track),
                    child: ListCard(
                      title: track.title,
                      artists: track.artist,
                      imageUrl: track.imageUrl,
                    ),
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
