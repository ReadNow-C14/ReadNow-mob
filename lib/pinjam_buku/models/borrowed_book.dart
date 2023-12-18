// To parse this JSON data, do
//
//     final borrowedBook = borrowedBookFromJson(jsonString);

import 'dart:convert';

List<BorrowedBook> borrowedBookFromJson(String str) => List<BorrowedBook>.from(json.decode(str).map((x) => BorrowedBook.fromJson(x)));

String borrowedBookToJson(List<BorrowedBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BorrowedBook {
  String model;
  int pk;
  Fields fields;

  BorrowedBook({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory BorrowedBook.fromJson(Map<String, dynamic> json) => BorrowedBook(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int user;
  int book;
  DateTime borrowDate;
  DateTime returnDate;

  Fields({
    required this.user,
    required this.book,
    required this.borrowDate,
    required this.returnDate,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    book: json["book"],
    borrowDate: DateTime.parse(json["borrow_date"]),
    returnDate: DateTime.parse(json["return_date"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "book": book,
    "borrow_date": borrowDate.toIso8601String(),
    "return_date": returnDate.toIso8601String(),
  };
}