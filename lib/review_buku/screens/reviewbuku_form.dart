import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/review_buku/screens/review_buku.dart';
// Import your Review model and any other necessary imports

class AddReview extends StatefulWidget {
  final int bookId; // Assuming each book has a unique identifier

  AddReview({Key? key, required this.bookId}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 1;
  String _comment = "";

  // void _submitReview() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     Navigator.of(context).pop(); // Close the screen after submission
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add your Review'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Add your comment here'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                },
                onSaved: (value) {
                  _comment = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rating'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                },
                onSaved: (value) {
                  _rating = int.parse(value!);
                },
              ),
              ElevatedButton(
                onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                        // Kirim ke Django dan tunggu respons
                        final response = await request.postJson(
                        "https://readnow-c14-tk.pbp.cs.ui.ac.id/submit-review-flutter/${widget.bookId}",
                        jsonEncode(<String, String>{
                            'id_buk_db': widget.bookId.toString(),
                            //'user': request.user!.username,
                            'rating': _rating.toString(),
                            'comment': _comment,
                            'created_at': DateTime.now().toString(),
                        }));
                        if (response['status'] == 'success') {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                            content: Text("Review Anda berhasil ditambahkan!"),
                            ));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ReviewPage(bookid: widget.bookId,)),
                            );
                        } else {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content:
                                    Text("Terdapat kesalahan, silakan coba lagi."),
                            ));
                        }
                    }
                  },
                child: Text('Submit Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
