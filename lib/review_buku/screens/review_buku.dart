import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:readnow_mobile/review_buku/models/reviewBuku.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Reviews',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReviewsScreen(),
    );
  }
}

class ReviewsScreen extends StatefulWidget {
  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<Review> reviews = [];

  @override
  void initState() {
    super.initState();
    // Load reviews
    loadReviews();
  }

  void loadReviews() {
    // Here you should fetch the JSON string from your source and parse it.
    // For now, we'll use an empty list to simulate no reviews.
    setState(() {
      reviews = bookFromJson('[]'); // Replace '[]' with your JSON data.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Reviews'),
      ),
      body: reviews.isEmpty
          ? Center(child: Text('No reviews found.'))
          : ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Review for Book ID: ${reviews[index].fields.book}'),
                  subtitle: Text(reviews[index].fields.comment),
                  trailing: Text('Rating: ${reviews[index].fields.rating}/5'),
                );
              },
            ),
    );
  }
}

// Your Review model goes here...

