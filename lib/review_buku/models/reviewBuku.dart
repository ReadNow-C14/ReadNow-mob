// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    int idBukDb;
    String user;
    String comment;
    String createdAt;
    int rating;

    Review({
        required this.idBukDb,
        required this.user,
        required this.comment,
        required this.createdAt,
        required this.rating,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        idBukDb: json["id_buk_db"],
        user: json["user"],
        comment: json["comment"],
        createdAt: json["created_at"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "id_buk_db": idBukDb,
        "user": user,
        "comment": comment,
        "created_at": createdAt,
        "rating": rating,
    };
}
