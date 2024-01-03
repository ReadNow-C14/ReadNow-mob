// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/main/book_details.dart';
import 'package:readnow_mobile/main/login.dart';
import 'package:readnow_mobile/styles/colors.dart';
import 'package:readnow_mobile/models/book.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Book> listBooks = [];
  List<Book> filteredList = [];
  bool isSearching = false;

  Future<List<Book>> fetchItem() async {
    var url = Uri.parse('https://readnow-c14-tk.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    listBooks = [];
    for (var d in data) {
      if (d != null) {
        listBooks.add(Book.fromJson(d));
      }
    }
    return listBooks;
  }

  Future<void> _handleLogout() async {
    final request = context.read<CookieRequest>();
    final response = await request
        .logout("https://readnow-c14-tk.pbp.cs.ui.ac.id/auth/logout/");
    String message = response["message"];
    if (response['status']) {
      String uname = response["username"];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$message see you again, $uname!"),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Logout failed: $message"),
        ),
      );
    }
  }

  List<Book> filterBooks(String query) {
    List<Book> filteredList = [];
    for (var book in listBooks) {
      if (book.fields.title.toLowerCase().contains(query.toLowerCase()) ||
          book.fields.authors.toLowerCase().contains(query.toLowerCase()) ||
          book.fields.isbn.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(book);
      }
    }
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              await _handleLogout();
            },
          ),
        ],
        toolbarHeight: height * 0.1 <= 150 ? height * 0.1 : 150,
        scrolledUnderElevation: 5,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.white,
        elevation: 5,
        title: Stack(
          children: [
            SizedBox(
              width: width,
              child: Text(
                'SEARCH',
                style: TextStyle(
                  fontSize: width * 0.15 <= 40 ? width * 0.15 : 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.2),
                  letterSpacing: width * 0.1 <= 2 ? 1 : 2,
                ),
              ),
            ),
            Positioned(
              top: (height * 0.02),
              left: width * 0.1,
              child: Text(
                'Books',
                style: TextStyle(
                  fontSize: width * 0.1 <= 15 ? width * 0.1 : 15,
                  fontWeight: FontWeight.bold,
                  color: Colorz.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              width * 0.05,
              height * 0.02,
              width * 0.05,
              height * 0.02,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by Title, Author, or ISBN',
                hintStyle: TextStyle(
                  fontSize: width * 0.1 <= 15 ? width * 0.1 : 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[500],
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    isSearching = true;
                    filteredList = filterBooks(value);
                  });
                } else {
                  setState(() {
                    isSearching = false;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchItem(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No book found."),
                    );
                  } else {
                    if (isSearching) {
                      if (filteredList.isEmpty) {
                        return const Center(
                          child: Text("Book is Not Found"),
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: filteredList.length,
                        itemBuilder: (_, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetails(
                                  book: filteredList[index],
                                ),
                              ),
                            );
                          },
                          child: GridTile(
                            child: Column(
                              children: [
                                Image.network(
                                  filteredList[index].fields.imageUrl,
                                ),
                                Text(
                                  filteredList[index].fields.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(filteredList[index].fields.authors),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetails(
                                  book: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          child: GridTile(
                            child: Column(
                              children: [
                                Image.network(
                                  "${snapshot.data![index].fields.imageUrl}",
                                ),
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("${snapshot.data![index].fields.authors}"),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
