import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readnow_mobile/review_buku/models/reviewBuku.dart';
import 'package:readnow_mobile/review_buku/screens/reviewbuku_form.dart';

class ReviewPage extends StatefulWidget {
  final int bookid;
  const ReviewPage({Key? key, required this.bookid}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int? selectedRating;
  List<Review>? reviews;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    var fetchedReviews = await fetchReview(selectedRating);
    setState(() {
      reviews = fetchedReviews;
    });
  }

  Future<List<Review>> fetchReview([int? rating]) async {
    var url = Uri.parse(
        'https://readnow-c14-tk.pbp.cs.ui.ac.id/review/get-review-json/${widget.bookid}');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    var reviews = data.map((d) => Review.fromJson(d)).toList();
    if (rating != null) {
      reviews = reviews.where((review) => review.rating == rating).toList();
    }
    return reviews;
  }

  Widget _buildStars(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          count, (index) => Icon(Icons.star, color: Colors.amber, size: 16)),
    );
  }

  Widget _buildRadioButton(int? value, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<int?>(
            value: value,
            groupValue: selectedRating,
            onChanged: (int? newValue) {
              setState(() {
                selectedRating = newValue;
                _loadReviews(); // Refresh reviews on rating selection
              });
            },
          ),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
        title: const Text("Review Book"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_comment),
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddReview(bookId: widget.bookid),
                ),
              );

              if (result == true) {
                _loadReviews(); // Reload reviews after returning from AddReview
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Radio buttons for rating
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRadioButton(null, 'All Reviews'),
                ...List.generate(
                    5, (index) => _buildRadioButton(index + 1, '${index + 1}')),
              ],
            ),
          ),
          // Review list
          Expanded(
            child: reviews == null
                ? const Center(child: CircularProgressIndicator())
                : reviews!.isEmpty
                  ? const Center(child: Text("No Reviews yet")) // Tampilkan ini jika tidak ada review
                  : ListView.builder(
                      itemCount: reviews!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final review = reviews![index];
                        return Container(
                          height: 136,
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      review.user,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  _buildStars(review.rating),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                review.comment,
                                style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 8),
                              Text(
                                review.createdAt,
                                style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
