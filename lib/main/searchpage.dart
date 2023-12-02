import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readnow_mobile/models/book.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Book> _filteredBooks = [];

  Future<List<Book>> fetchBooks() async {
    var url = Uri.parse('http://127.0.0.1:8000/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Book> listBooks = [];
    for (var d in data) {
      listBooks.add(Book.fromJson(d));
    }
    return listBooks;
  }

  void _filterBooks(List<Book> books, String searchTerm) {
    setState(() {
      _filteredBooks = books
          .where((book) =>
              book.fields.title.toLowerCase().contains(searchTerm) ||
              book.fields.authors.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      String searchTerm = _searchController.text.toLowerCase();
      _filterBooks(_filteredBooks, searchTerm);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // filter logic
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for books...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: fetchBooks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No books found."));
                } else {
                  if (_filteredBooks.isEmpty) {
                    _filteredBooks =
                        snapshot.data!; // Initialize with all books
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: _filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = _filteredBooks[index];
                      return GridTile(
                        child: Column(
                          children: [
                            Image.network(book.fields.imageUrl),
                            Text(book.fields.title),
                            Text(book.fields.authors),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
