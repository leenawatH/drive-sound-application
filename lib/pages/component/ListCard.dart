import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String title;
  final String artists;
  final String imageUrl;

  const ListCard({
    Key? key,
    required this.title,
    required this.artists,
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
        subtitle: Text(artists),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}
