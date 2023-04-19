import 'package:flutter/material.dart';

class AboutUsCard extends StatelessWidget {
  final String firstname;
  final String surname;
  final String email;
  final String imageUrl;

  const AboutUsCard({
    Key? key,
    required this.firstname,
    required this.surname,
    required this.email,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fullname = "$firstname $surname";

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white10,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            fullname,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            email,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
