import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'AboutUs_page.dart';
import 'Starter_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  int _age = 0;
  String _telNumber = '';

  @override
  void initState() {
    super.initState();
    // Get the current user's email
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _email = user.email ?? '';
      _getUserData();
    }
  }

  Future<void> _getUserData() async {
    // Query Firestore for the user data
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: _email)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> userData = snapshot.docs.first.data();
      _firstName = userData['first name'] ?? '';
      _lastName = userData['last name'] ?? '';
      _age = userData['age'] ?? 0;
      _telNumber = userData['tel number'] ?? '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Center(
              child: Icon(
                Icons.account_circle,
                size: 100.0,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Name',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            Text(
              '$_firstName $_lastName',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Email',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            Text(
              '$_email',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Phone Number',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            Text(
              '$_telNumber',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Age',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            Text(
              '$_age',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
