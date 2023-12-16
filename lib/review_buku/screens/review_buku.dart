import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
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
  List<int?> ratings = [null, 1, 2, 3, 4, 5]; // Tambahkan 'null' untuk opsi 'Semua'

  Future<List<Review>> fetchReview(request, [int? rating]) async {
    var url = Uri.parse('https://readnow-c14-tk.pbp.cs.ui.ac.id/review/get-review-json/${widget.bookid}');
    var response = await http.get(url, headers: {"Content-Type": "application/json"});
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
      children: List.generate(count, (index) => Icon(Icons.star, color: Colors.amber)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Review Book"),
          actions: <Widget>[
            // Dropdown untuk memilih rating
            DropdownButton<int?>(
              value: selectedRating,
              hint: Text("Filter Rating"),
              items: ratings.map<DropdownMenuItem<int?>>((int? value) {
                return DropdownMenuItem<int?>(
                  value: value,
                  child: Text(value == null ? 'All Reviews' : value.toString()),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  selectedRating = newValue;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add_comment),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddReview(bookId: widget.bookid),
                  ),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder(
            future: fetchReview(context.watch<CookieRequest>(), selectedRating),
            builder: (context, AsyncSnapshot<List<Review>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No reviews found"));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      final review = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("User ID: ${review.user}", style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text("Rating: ${review.rating}"),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Comment: ${review.comment}"),
                                _buildStars(review.rating),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }
            }));
  }
}
