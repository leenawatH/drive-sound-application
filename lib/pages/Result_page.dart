import 'package:flutter/material.dart';

import 'component/Track.dart';

class ResultPage extends StatefulWidget {
  final Track track;

  const ResultPage({Key? key, required this.track}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
        elevation: 0.0,
        title: Expanded(
          flex: 1,
          child: Center(
            child: Text(
              widget.track.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(color: Colors.grey[900], height: 20.0),
                Container(
                  color: Colors.grey[900],
                  width: 200.0,
                  height: 250.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.track.imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[900],
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Artists/Brand : ${widget.track.artist}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Date : ${widget.track.releaseDate}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: Text(
                //     "popularity : ${widget.track.popularity}",
                //     style: const TextStyle(
                //       color: Colors.black,
                //       fontSize: 18.0,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Lyrics : ${widget.track.lyrics}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
