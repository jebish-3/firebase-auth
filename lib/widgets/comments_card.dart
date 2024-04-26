// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String name;
  final String email;
  final String body;

  CommentCard({required this.name, required this.email, required this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHighlightedText('Name', name),
            SizedBox(height: 8),
            Divider(color: Colors.white),
            _buildHighlightedText('Email', email),
            SizedBox(height: 8),
            Divider(color: Colors.white),
            _buildHighlightedText('Body', body),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
