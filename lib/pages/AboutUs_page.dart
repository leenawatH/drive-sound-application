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
                    firstname: 'Phumtham',
                    surname: 'Akkarasiriwong',
                    email: 'phumtham.akk@student.mahidol.ac.th',
                    imageUrl:
                        'https://avatars.githubusercontent.com/u/98636379?v=4',
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
                    firstname: 'Leenawat',
                    surname: 'Honglerdnapakul',
                    email: 'leenawat.hon@student.mahidol.ac.th',
                    imageUrl:
                        'https://avatars.githubusercontent.com/u/98454141?v=4',
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
                    firstname: 'Phurich',
                    surname: 'Kongmont',
                    email: 'phurich.kon@student.mahidol.ac.th',
                    imageUrl:
                        'https://avatars.githubusercontent.com/u/98454214?v=4',
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
