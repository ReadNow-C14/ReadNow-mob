import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/review_buku/screens/review_buku.dart';
// Import your Review model and any other necessary imports

class AddReview extends StatefulWidget {
  final int bookId;

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Comment",
                    labelText: "Comment",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _comment = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _comment = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Category cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Rating",
                    labelText: "Rating",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _rating = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Rating cannot be empty!";
                    }
                    else if (int.tryParse(value) == null) {
                      return "Rating must be a valid integer!";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                        String username = 'testUser';
                        // Kirim ke Django dan tunggu respons
                        final response = await request.postJson(
                          "http://127.0.0.1:8000/submit-review-flutter/${widget.bookId}",
                          jsonEncode(<String, String>{
                              "book": widget.bookId.toString(),
                              "user": username,
                              "comment": _comment,
                              "rating": _rating.toString(),
                              "created_at": DateTime.now().toString()
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
