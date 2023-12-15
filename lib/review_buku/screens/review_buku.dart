import 'package:flutter/foundation.dart';
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
  Future<List<Review>> fetchReview(request) async {
    var url = Uri.parse('https://readnow-c14-tk.pbp.cs.ui.ac.id/review/get-review-json/${widget.bookid}');
    var response = await http.get(url, headers: {"Content-Type": "application/json"});

    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    return data.map((d) => Review.fromJson(d)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Review Book"),
          actions: <Widget>[
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
            future: fetchReview(context.watch<CookieRequest>()),
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
                              Text("Book ID: ${review.book}"),
                              const SizedBox(height: 10),
                              Text("Rating: ${review.rating}"),
                              const SizedBox(height: 10),
                              Text("Comment: ${review.comment}"),
                            ],
                          ));
                    });
              }
            }));
  }
}
