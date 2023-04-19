import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './component/Track.dart';
import './component/BoxCard.dart';
import 'Result_page.dart';
import 'AboutUs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Track> _popularTracks = [];
  List<Track> _newTracks = [];
  String token = '';

  @override
  void initState() {
    super.initState();
    initToken();
  }

  Future<void> initToken() async {
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
    token = data['access_token'];
    getTopTracks();
    getNewTracks();
  }

  Future<void> getTopTracks() async {
    final url = Uri.https(
      'api.spotify.com',
      '/v1/search',
      {
        'q': 'year:2023',
        'type': 'track',
        'market': 'TH',
        'limit': '3',
        'offset': '0',
        'sort_by': 'popularity',
        'sort_dir': 'desc'
      },
    );
    final response2 = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response2.statusCode == 200) {
      final data2 = jsonDecode(response2.body);
      final List<dynamic> tracks = data2['tracks']['items'];

      tracks.sort((a, b) {
        final popularity1 = a['popularity'];
        final popularity2 = b['popularity'];
        return popularity2.compareTo(popularity1);
      });

      final List<Track> topTracks = tracks.map<Track>((trackData) {
        final title = trackData['name'];
        final albumName = trackData['album']['name'] ?? '';
        final artist =
            trackData['artists'].isEmpty ? '' : trackData['artists'][0]['name'];
        final popularity = trackData['popularity'];
        final releaseDate = trackData['album']['release_date'];
        final imageUrl = trackData['album']['images'].first['url'];
        return Track(
            title: title,
            imageUrl: imageUrl,
            albumName: albumName,
            artist: artist,
            popularity: popularity,
            releaseDate: releaseDate);
      }).toList();

      setState(() {
        _popularTracks = topTracks;
      });
    } else {
      print('Failed to load top tracks');
    }
  }

  Future<void> getNewTracks() async {
    final url2 = Uri.https(
      'api.spotify.com',
      '/v1/search',
      {
        'q': 'year:2023',
        'type': 'track',
        'market': 'TH',
        'limit': '3',
        'offset': '0',
        'sort_by': 'release_date',
        'sort_dir': 'desc'
      },
    );
    final response3 = await http.get(
      url2,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response3.statusCode == 200) {
      final data2 = jsonDecode(response3.body);
      final List<dynamic> tracks = data2['tracks']['items'];

      tracks.sort((a, b) {
        final releaseDate1 = DateTime.parse(a['album']['release_date']);
        final releaseDate2 = DateTime.parse(b['album']['release_date']);
        return releaseDate2.compareTo(releaseDate1);
      });

      final List<Track> newTracks = tracks.map<Track>((trackData) {
        final title = trackData['name'];
        final albumName = trackData['album']['name'] ?? '';
        final artist =
            trackData['artists'].isEmpty ? '' : trackData['artists'][0]['name'];
        final popularity = trackData['popularity'];
        final releaseDate = trackData['album']['release_date'];
        final imageUrl = trackData['album']['images'].first['url'];
        return Track(
            title: title,
            imageUrl: imageUrl,
            albumName: albumName,
            artist: artist,
            popularity: popularity,
            releaseDate: releaseDate);
      }).toList();

      setState(() {
        _newTracks = newTracks;
      });
    } else {
      print('Failed to load new tracks');
    }
  }

  void _handleTap(Track track) {
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
            children: const [
              SizedBox(height: 20.0),
              Text(
                "Drive Sound",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              child: Text(
                'Drive Sound',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // ListTile(
            //   leading: const Icon(Icons.home),
            //   title: const Text('Home'),
            //   onTap: () {
            //     // do something when the settings item is pressed
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('About us'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AboutUsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Popular Song',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10),
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 1.2,
              ),
              itemCount: _popularTracks.length,
              itemBuilder: (BuildContext context, int index) {
                final track = _popularTracks[index];
                return GestureDetector(
                  onTap: () => _handleTap(track),
                  child: BoxCard(
                    title: track.title,
                    imageUrl: track.imageUrl,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 0),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'New Song',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10),
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 1.2,
              ),
              itemCount: _newTracks.length,
              itemBuilder: (BuildContext context, int index) {
                final track = _newTracks[index];
                return GestureDetector(
                  onTap: () => _handleTap(track),
                  child: BoxCard(
                    title: track.title,
                    imageUrl: track.imageUrl,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
