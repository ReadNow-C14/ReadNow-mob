// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    int book;
    String user;
    String comment;
    String createdAt;
    int rating;

    Review({
        required this.book,
        required this.user,
        required this.comment,
        required this.createdAt,
        required this.rating,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        book: json["book"],
        user: json["user"],
        comment: json["comment"],
        createdAt: json["created_at"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "book": book,
        "user": user,
        "comment": comment,
        "created_at": createdAt,
        "rating": rating,
    };
}
