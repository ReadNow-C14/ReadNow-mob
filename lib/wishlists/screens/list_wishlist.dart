import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readnow_mobile/models/book.dart';
import 'package:readnow_mobile/wishlists/utilities/cards.dart';
import 'package:readnow_mobile/wishlists/utilities/white_box.dart';
import 'package:readnow_mobile/wishlists/widgets/left_drawer_wishlist.dart';

class MyWishlistPage extends StatefulWidget {
  const MyWishlistPage({Key? key}) : super(key: key);

  @override
  _MyWishlistPageState createState() => _MyWishlistPageState();
}

class _MyWishlistPageState extends State<MyWishlistPage> {
  // Fetching data
  Future<List<Book>> fetchWishlist() async {
    // TODO: Ubah url sesuai dengan wishilst
    var url = Uri.parse(
        'http://127.0.0.1:8000/wishlist/get-wishlist/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // konversi json menjadi object Product
    List<Book> list_wishlist = [];
    for (var d in data) {
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
            future: fetchWishlist(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                // TODO: Ubah jdi circular
                // return const Center(child: CircularProgressIndicator());
                return const Center(child: Text("Data is null or not found"));
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true, // Menambahkan ini
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => GridTile(
                            child: WishlistCard(book: snapshot.data![index],)
                          ));
                }
              }
            }));
  }
}
