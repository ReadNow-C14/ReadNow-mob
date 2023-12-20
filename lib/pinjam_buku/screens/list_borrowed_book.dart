import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/main/book_details.dart';
import 'package:readnow_mobile/models/book.dart';
import 'package:readnow_mobile/wishlists/utilities/cards.dart';
import 'package:readnow_mobile/pinjam_buku/widgets/borrowed_book_card.dart';

// menyimpan id buku yang ada di wishlist
final List<int> borrowedBookId = <int>[];

class BorrowedBookPage extends StatefulWidget {
  const BorrowedBookPage({Key? key}) : super(key: key);

  @override
  _BorrowedBookPageState createState() => _BorrowedBookPageState();
}

class _BorrowedBookPageState extends State<BorrowedBookPage> {
  // Variable
  List<Book> listBorrowedBook = [];
  // Fetching data
  Future<List<Book>> fetchWishlist(CookieRequest cookieRequest) async {
    var response = await cookieRequest
        .get("https://readnow-c14-tk.pbp.cs.ui.ac.id/pinjam/get-borrowed-book/");

    listBorrowedBook = [];

    // konversi json menjadi object Product
    for (var d in response) {
      if (d != null) {
        listBorrowedBook.add(Book.fromJson(d));
        borrowedBookId.add(d["pk"]);
      }
    }
    if (kDebugMode) {
      print(listBorrowedBook);
    }
    return listBorrowedBook;
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
        automaticallyImplyLeading: false,
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
                'BORROWED',
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
                'Archive',
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
      // ================== Menampilkan seluruh Wishlist yang ada ==================
      body: FutureBuilder(
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
                        Icons.book_outlined,
                        size: width * 0.3 <= 180 ? width * 0.3 : 180,
                        color: Colors.grey[500],
                      ),
                      Text(
                        "You haven't borrowed any books",
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
                          "Nothing to show",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.1 <= 13 ? width * 0.1 : 13,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
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
                        child: BorrowedCard(
                            book: snapshot.data![index],
                            onTap: () => removeItem(
                                snapshot.data![index].pk, request))));
              }
            }
          }),
    );
  }

  removeItem(int id, CookieRequest request) async {
    // final response = request.postJson(
    //   jsonEncode(<String, String>{
    //     // 'book_id': list_wishlist[index].pk.toString(),
    //     'book_id': "-1",
    //   })
    // );
    final response = await request.post(
        'https://readnow-c14-tk.pbp.cs.ui.ac.id/pinjam/return-book-flutter/$id/',
        {});
    if (response["status"] == "success") {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The book has been returned'),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to return book'),
          ),
        );
      }
    }
    setState(() {});
  }
}
