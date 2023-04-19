import '../pages/component/AboutUsCard.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        backgroundColor: Colors.white10,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About us",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 3,
                  child: AboutUsCard(
                    firstname: 'Phum',
                    surname: 'a',
                    email: 'adad@',
                    imageUrl:
                        'https://github.com/Drive-Sound/Drive-Sound/blob/main/Drive%20sound/web%20project/public/images/Picture_About_Us/oat.JPG?raw=true',
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 3,
                  child: AboutUsCard(
                    firstname: 'John',
                    surname: 'Doe',
                    email: 'johndoe@example.com',
                    imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 3,
                  child: AboutUsCard(
                    firstname: 'Jane',
                    surname: 'Doe',
                    email: 'janedoe@example.com',
                    imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
