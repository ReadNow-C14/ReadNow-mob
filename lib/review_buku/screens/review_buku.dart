import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:readnow_mobile/review_buku/models/reviewBuku.dart';

class ReviewPage extends StatefulWidget {
    const ReviewPage({Key? key}) : super(key: key);

    @override
    _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  Future<List<Review>> fetchReview(request) async {
      var url = Uri.parse(
          'https://readnow-c14-tk.pbp.cs.ui.ac.id/review/review_json/');
      var response = await http.get(
          url,
          headers: {"Content-Type": "application/json"},
      );

      // melakukan decode response menjadi bentuk json
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      // melakukan konversi data json menjadi object Product
      List<Review> list_review = [];
      for (var d in data) {
          if (d != null) {
              list_review.add(Review.fromJson(d));
          }
      }
      return list_review;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Review book"),
        ),
        body: FutureBuilder(
            future: fetchReview(context.watch<CookieRequest>()),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    // return const Center(child: CircularProgressIndicator());
                    return const Center(child: Text("p, null"));
                } else {
                    if (!snapshot.hasData) {
                    // return const Center(child: CircularProgressIndicator());
                    return const Center(child: Text("Data is null or not found"));
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.user}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Book ID : ${snapshot.data![index].fields.book}"),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.rating}"),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.comment}"),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.createdAt}")
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}