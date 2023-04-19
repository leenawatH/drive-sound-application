import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './component/Track.dart';
import './component/ListCard.dart';
import 'Result_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Track> _tracks = [];
  bool showNoResults = false;

  void _handleSearch(String query) {
    _searchTracks(query);
  }

  Future<void> _searchTracks(String query) async {
    if (query.isEmpty) {
      setState(() {
        _tracks = [];
        showNoResults = false;
      });
      return;
    }
    const clientId = 'c9229c368b5f4a95bab7b83236096d97';
    const clientSecret = '53cd4795d5ee468a970982ffe1c371d7';
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
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
        showNoResults = _tracks.isEmpty;
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
      final message = data['message'];
      if (message != null && message['header']['status_code'] == 200) {
        final body = message['body'];
        final lyrics = body['lyrics'];
        if (lyrics != null && lyrics['lyrics_body'] is String) {
          return lyrics['lyrics_body'].split('*').first;
        }
      }
      return 'No lyrics found';
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
          builder: (context) => ResultPage(track: track),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        backgroundColor: Colors.white10,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0), // Add this SizedBox
              Text(
                "Find your song",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
              ),
              controller: _searchController,
              onChanged: _handleSearch,
            ),
            const SizedBox(height: 32.0),
            showNoResults
                ? const Text(
                    'No results found',
                    style: TextStyle(fontSize: 16.0),
                  )
                : Container(),
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
