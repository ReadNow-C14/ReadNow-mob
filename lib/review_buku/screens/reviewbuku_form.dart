import 'package:flutter/material.dart';
// Import your Review model and any other necessary imports

class AddReviewScreen extends StatefulWidget {
  final int bookId; // Assuming each book has a unique identifier

  AddReviewScreen({Key? key, required this.bookId}) : super(key: key);

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 1;
  String _comment = '';

  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Here you should send the review data to your backend.
      // For example: uploadReview(widget.bookId, _rating, _comment);

      Navigator.of(context).pop(); // Close the screen after submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review for Book ${widget.bookId}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Comment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
                onSaved: (value) {
                  _comment = value!;
                },
              ),
              DropdownButtonFormField<int>(
                value: _rating,
                decoration: InputDecoration(labelText: 'Rating'),
                items: List.generate(5, (index) => index + 1)
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    _rating = newValue!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _submitReview,
                child: Text('Submit Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
