import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/review_buku/screens/review_buku.dart';

class AddReview extends StatefulWidget {
  final int bookId;

  AddReview({Key? key, required this.bookId}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 1.0; // Rating as a double
  String _comment = "";

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
                child: RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false, // Set to false to only allow whole numbers
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
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
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Comment cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Send to Django and wait for response
                    final response = await request.postJson(
                      "https://readnow-c14-tk.pbp.cs.ui.ac.id/review/submit-review-flutter/${widget.bookId}",
                      jsonEncode(<String, String>{
                        "book": widget.bookId.toString(),
                        "comment": _comment,
                        "rating": _rating.toString(),
                        "created_at": DateTime.now().toString()
                      }),
                    );
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Your review has been added successfully!"),
                      ));
                      
                      // Ini adalah penambahan. Navigator.pop dengan nilai 'true'
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("There was an error, please try again."),
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
