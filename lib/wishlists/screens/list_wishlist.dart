import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/main/book_details.dart';
import 'package:readnow_mobile/models/book.dart';
import 'package:readnow_mobile/wishlists/utilities/cards.dart';

// menyimpan id buku yang ada di wishlist
final List<int> wishlistBookId = <int>[];

class MyWishlistPage extends StatefulWidget {
  const MyWishlistPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyWishlistPageState createState() => _MyWishlistPageState();
}

class _MyWishlistPageState extends State<MyWishlistPage> {
  // Variable
  List<Book> listWishlist = [];
  List<Book> filteredList = [];
  bool isSearching = false;
  // Fetching data
  Future<List<Book>> fetchWishlist(CookieRequest cookieRequest) async {
    var response = await cookieRequest
        .get("https://readnow-c14-tk.pbp.cs.ui.ac.id/wishlist/get-wishlist/");

    listWishlist = [];

    // konversi json menjadi object Product
    for (var d in response) {
      if (d != null) {
        listWishlist.add(Book.fromJson(d));
        wishlistBookId.add(d["pk"]);
      }
    }
    if (kDebugMode) {
      print(listWishlist);
    }
    return listWishlist;
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
        toolbarHeight: height * 0.1 <= 150 ? height * 0.1 : 150,
        scrolledUnderElevation: 5,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.white,
        elevation: 5,
        title: Stack(
          children: [
            // Wishlist
            SizedBox(
              width: width,
              child: Text(
                'WISHLIST',
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
                'Collection',
                style: TextStyle(
                  fontSize: width * 0.1 <= 15 ? width * 0.1 : 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
          // ================== Filter Wishlist yang ada ==================
          Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
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
                    filteredList = filterItem(value);
                  });
                } else {
                  setState(() {
                    isSearching = false;
                  });
                }
              },
            ),
          ),
          // ================== Menampilkan seluruh Wishlist yang ada ==================
          Expanded(
            child: FutureBuilder(
                future: fetchWishlist(request),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: width * 0.3 <= 180 ? width * 0.3 : 180,
                              color: Colors.grey[500],
                            ),
                            Text(
                              "Your Wishlist is Empty.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: width * 0.1 <= 20 ? width * 0.1 : 20,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[500],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                            ),
                            SizedBox(
                              width: width * 0.6,
                              child: Text(
                                "You can add book to wishlist by clicking the heart icon on the book details page.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      width * 0.1 <= 13 ? width * 0.1 : 13,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (isSearching) {
                        if (filteredList.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: width * 0.3 <= 180 ? width * 0.3 : 180,
                                  color: Colors.grey[500],
                                ),
                                Text(
                                  "Book is Not Found",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        width * 0.1 <= 20 ? width * 0.1 : 20,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                            padding: const EdgeInsets.only(top: 0),
                            shrinkWrap: true, // Menambahkan ini
                            itemCount: filteredList.length,
                            itemBuilder: (_, index) => InkWell(
                                onTap: () {
                                  // Navigasi ke halaman ItemInformations dengan membawa data item
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDetails(
                                        book: filteredList[index],
                                      ),
                                    ),
                                  );
                                },
                                child: WishlistCard(
                                    book: filteredList[index],
                                    onTap: () => removeItem(
                                        filteredList[index].pk, request))));
                      } else {
                        return ListView.builder(
                            padding: const EdgeInsets.only(top: 0),
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
                                child: WishlistCard(
                                    book: snapshot.data![index],
                                    onTap: () => removeItem(
                                        snapshot.data![index].pk, request))));
                      }
                    }
                  }
                }),
          ),
        ],
      ),
    );
  }

  // ================== Filter Wishlist ==================
  List<Book> filterItem(String query) {
    List<Book> filteredList = [];
    if (kDebugMode) {
      print("the query is: $query");
    }
    for (var item in listWishlist) {
      if (item.fields.title.toLowerCase().contains(query.toLowerCase()) ||
          item.fields.authors.toLowerCase().contains(query.toLowerCase()) ||
          item.fields.isbn.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(item);
      }
    }
    return filteredList;
  }

  // ================== Remove Wishlist ==================
  removeItem(int id, CookieRequest request) async {
    final response = await request.post(
        'https://readnow-c14-tk.pbp.cs.ui.ac.id/wishlist/remove-wishlist-flutter/$id/',
        {});
    if (response["status"] == "success") {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item removed from wishlist'),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to remove item from wishlist'),
          ),
        );
      }
    }
    setState(() {});
  }
}
