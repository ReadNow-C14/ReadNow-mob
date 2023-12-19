import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {
  final int bookId;

  AddReview({Key? key, required this.bookId}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 1.0;
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87), // Modern icon color
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add your Review', style: TextStyle(color: Colors.black87)), // Modern text style
        backgroundColor: Colors.white, // Modern app bar color
        elevation: 1, // Subtle shadow for app bar
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center( // Center align the rating bar
                child: RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 30.0, // Slightly larger stars
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) => setState(() => _rating = rating),
                ),
              ),
              SizedBox(height: 16.0), // Spacing between elements
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Write your comment here",
                  labelText: "Comment",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder( // Highlight color when focused
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) => setState(() => _comment = value),
                validator: (value) => value == null || value.isEmpty ? "Comment cannot be empty!" : null,
                maxLines: 3, // Allow for multi-line input
              ),
              SizedBox(height: 20.0), // Spacing before the button
              Center( // Center the button
                child: ElevatedButton(
                  onPressed: () async {
                      if (_formKey.currentState!.validate()) {
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
                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("There was an error, please try again."),
                          ));
                        }
                      }
                    },
                  child: Text('Submit Review', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8BD0FC), // Button color
                    foregroundColor: Colors.black, // Text color
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    elevation: 0, // No shadow
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
