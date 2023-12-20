// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:readnow_mobile/main/searchpage.dart';
// import 'package:readnow_mobile/main/widgets/bottom_nav.dart';
//
// class BorrowedBookPage extends StatefulWidget {
//   const BorrowedBookPage({Key? key}) : super(key: key);
//
//   @override
//   _BorrowedBookPageState createState() => _BorrowedBookPageState();
// }
//
// class _BorrowedBookPageState extends State<BorrowedBookPage>{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Color(0xfffffffe),
//           borderRadius: BorderRadius.circular(20 * MediaQuery.of(context).size.width),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               // borrowedbookspageempty2m9 (90:1022)
//               width:  double.infinity,
//               decoration:  BoxDecoration (
//                 color:  Color(0xfffffffe),
//                 borderRadius:  BorderRadius.circular(20),
//               ),
//               child:
//               Column(
//                 crossAxisAlignment:  CrossAxisAlignment.center,
//                 children:  [
//                   Container(
//                     // autogroupuqmhKET (DBzzk6ro858PG63qKbUQmh)
//                     padding:  EdgeInsets.fromLTRB(20, 55, 20, 293),
//                     width:  double.infinity,
//                     child:
//                     Column(
//                       crossAxisAlignment:  CrossAxisAlignment.center,
//                       children:  [
//                         Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 0, 180),  // Adjust the margin as needed
//                           child: RichText(
//                             textAlign: TextAlign.left,  // Align text to the left
//                             text: TextSpan(
//                               style: GoogleFonts.poppins(
//                                 fontSize: 21,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xff000000),
//                               ),
//                               children: <TextSpan>[
//                                 TextSpan(text: 'You are borrowing '),
//                                 TextSpan(
//                                   text: '0',
//                                   style: TextStyle(color: Color(0xff8bd0fc)),
//                                 ),
//                                 TextSpan(text: ' \nbook(s) for now.'),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           // nothingtoshow3iB (91:1071)
//                           margin:  EdgeInsets.fromLTRB(0, 0, 0, 21),
//                           child:
//                           Text(
//                             'Nothing to show',
//                             textAlign:  TextAlign.center,
//                             style:  GoogleFonts.poppins (
//                               fontSize:  12,
//                               fontWeight:  FontWeight.w500,
//                               height:  2.5,
//                               fontStyle:  FontStyle.italic,
//                               color:  Color(0xff77777a),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(86, 0, 87, 0),
//                           width: double.infinity,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: Color(0xfffce76c),
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Color(0x3f000000),
//                                 offset: Offset(0, 4),
//                                 blurRadius: 2,
//                               ),
//                             ],
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 1))
//                               );
//                             },
//                             child: Center(
//                               child: Text(
//                                 'Search for books',
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w700,
//                                   height: 2,
//                                   color: Color(0xff000000),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/main/book_details.dart';
import 'package:readnow_mobile/models/book.dart';
import 'package:readnow_mobile/wishlists/utilities/cards.dart';

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
                        child: WishlistCard(
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
