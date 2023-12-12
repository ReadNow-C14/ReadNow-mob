// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Model model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int bookId;
  String title;
  int numOfPages;
  Language language;
  String authors;
  String publisher;
  String isbn;
  int countsOfReview;
  int ratingDistTotal;
  String rating;
  int ratingDist1;
  int ratingDist2;
  int ratingDist3;
  int ratingDist4;
  int ratingDist5;
  String indices;
  String distance;
  String imageUrl;
  String smallImageUrl;
  int publishDay;
  int publishMonth;
  int publishYear;
  Status status;
  DateTime? returnDate;

  Fields({
    required this.bookId,
    required this.title,
    required this.numOfPages,
    required this.language,
    required this.authors,
    required this.publisher,
    required this.isbn,
    required this.countsOfReview,
    required this.ratingDistTotal,
    required this.rating,
    required this.ratingDist1,
    required this.ratingDist2,
    required this.ratingDist3,
    required this.ratingDist4,
    required this.ratingDist5,
    required this.indices,
    required this.distance,
    required this.imageUrl,
    required this.smallImageUrl,
    required this.publishDay,
    required this.publishMonth,
    required this.publishYear,
    required this.status,
    required this.returnDate,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        bookId: json["book_id"],
        title: json["title"],
        numOfPages: json["num_of_pages"],
        language: languageValues.map[json["language"]]!,
        authors: json["authors"],
        publisher: json["publisher"],
        isbn: json["isbn"],
        countsOfReview: json["counts_of_review"],
        ratingDistTotal: json["rating_dist_total"],
        rating: json["rating"],
        ratingDist1: json["rating_dist1"],
        ratingDist2: json["rating_dist2"],
        ratingDist3: json["rating_dist3"],
        ratingDist4: json["rating_dist4"],
        ratingDist5: json["rating_dist5"],
        indices: json["indices"],
        distance: json["distance"],
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
        publishDay: json["publish_day"],
        publishMonth: json["publish_month"],
        publishYear: json["publish_year"],
        status: statusValues.map[json["status"]]!,
        returnDate: json["return_date"] == null
            ? null
            : DateTime.parse(json["return_date"]),
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "title": title,
        "num_of_pages": numOfPages,
        "language": languageValues.reverse[language],
        "authors": authors,
        "publisher": publisher,
        "isbn": isbn,
        "counts_of_review": countsOfReview,
        "rating_dist_total": ratingDistTotal,
        "rating": rating,
        "rating_dist1": ratingDist1,
        "rating_dist2": ratingDist2,
        "rating_dist3": ratingDist3,
        "rating_dist4": ratingDist4,
        "rating_dist5": ratingDist5,
        "indices": indices,
        "distance": distance,
        "image_url": imageUrl,
        "small_image_url": smallImageUrl,
        "publish_day": publishDay,
        "publish_month": publishMonth,
        "publish_year": publishYear,
        "status": statusValues.reverse[status],
        "return_date":
            "${returnDate!.year.toString().padLeft(4, '0')}-${returnDate!.month.toString().padLeft(2, '0')}-${returnDate!.day.toString().padLeft(2, '0')}",
      };
}

enum Language { ENG, EN_US }

final languageValues =
    EnumValues({"eng": Language.ENG, "en-US": Language.EN_US});

enum Status { AVAILABLE, BORROWED }

final statusValues =
    EnumValues({"Available": Status.AVAILABLE, "Borrowed": Status.BORROWED});

enum Model { BOOK_BOOK }

final modelValues = EnumValues({"book.book": Model.BOOK_BOOK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
