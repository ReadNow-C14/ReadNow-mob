import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/main/book_details.dart';
import 'package:readnow_mobile/main/searchpage.dart';
import 'dart:convert';
import 'package:readnow_mobile/models/book.dart';
import 'package:readnow_mobile/wishlists/utilities/cards.dart';
import 'package:readnow_mobile/wishlists/widgets/left_drawer_wishlist.dart';

class MyWishlistPage extends StatefulWidget {
  const MyWishlistPage({Key? key}) : super(key: key);

  @override
  _MyWishlistPageState createState() => _MyWishlistPageState();
}

class _MyWishlistPageState extends State<MyWishlistPage> {
  // Variable
  List<Book> list_wishlist = [];
  // Fetching data
  Future<List<Book>> fetchWishlist(CookieRequest cookieRequest) async {
    // TODO: Ubah url sesuai dengan wishilst
    var response = await cookieRequest.get(
      // TODO: change to deployed server
      "http://127.0.0.1:8000/wishlist/get-wishlist/"
    );

    print(response);
    list_wishlist = [];

    // konversi json menjadi object Product
    for (var d in response) {
      if (d != null) {
        list_wishlist.add(Book.fromJson(d));
      }
    }
    if (kDebugMode) {
      print(list_wishlist);
    }
    return list_wishlist;
  }

  // Menampilkan data
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('WISHLIST'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        drawer: const TemporaryLeftDrawerWishlist(),
        // ================== Menampilkan seluruh Wishlist yang ada ==================
        body: FutureBuilder(
            future: fetchWishlist(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                // TODO: Ubah jdi circular
                // return const Center(child: CircularProgressIndicator());
                return const Center(child: Text("Data is null or not found"));
              } else {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: width*0.3 <= 200 ? width * 0.3 : 200,
                          color: Colors.grey[500],
                        ),
                        Text(
                          "Your Wishlist is Empty.",
                          style: TextStyle(
                            fontSize: width*0.1 <= 20 ? width * 0.1 : 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[500],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        Text(
                          "You can add book to wishlist by clicking the heart icon on the book details page.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width*0.1 <= 20 ? width * 0.1 : 15,
                            color: Colors.grey[500],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchPage(),
                              ),
                            );
                          },
                          onHover: (value) {
                            
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              "Search for Books",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width*0.1 <= 25 ? width * 0.1 : 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true, // Menambahkan ini
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => InkWell(
                            onTap: () {
                              // Navigasi ke halaman ItemInformations dengan membawa data item
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetails(
                                    book: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            child: WishlistCard(book: snapshot.data![index], onTap: () => removeItem(snapshot.data![index].pk, request))
                          ));
                }
              }
            }));
  }
  
  removeItem(int id, CookieRequest request) async {
    // final response = request.postJson(
    //   jsonEncode(<String, String>{
    //     // 'book_id': list_wishlist[index].pk.toString(),
    //     'book_id': "-1",
    //   })
    // );
    final response = await request.post('http://127.0.0.1:8000/wishlist/remove-wishlist-flutter/${id}/',{});
    if (response["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item removed from wishlist'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to remove item from wishlist'),
        ),
      );
    }
    setState(() {});
  }
}
