// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/models/comments_models.dart';
import 'package:firebaseaut/screens/authentications/login_screen.dart';
import 'package:firebaseaut/services/auth_service.dart';
import 'package:firebaseaut/services/comments_service.dart';
import 'package:firebaseaut/widgets/buttons.dart';
import 'package:firebaseaut/widgets/comments_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final _auth = FirebaseAuth.instance;
    final CommentService _commentService = CommentService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 0.3),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                _auth.currentUser!.email!,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
                onTap: () async {
                  await auth.signout();
                  goToLogin(context);
                },
                child: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                )),
          )
        ],
        title: const Text('Dashboard'),
      ),
      body: FutureBuilder(
        future: _commentService.getComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Comment>? comments = snapshot.data;
            return ListView.builder(
              itemCount: comments!.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return CommentCard(
                  name: comment.name,
                  email: comment.email,
                  body: comment.body,
                );
              },
            );
          }
        },
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
}
