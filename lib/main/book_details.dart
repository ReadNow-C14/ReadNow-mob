import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:readnow_mobile/rekomendasi/rekomendasi_page.dart';
import 'package:readnow_mobile/review_buku/screens/review_buku.dart';
import 'package:readnow_mobile/pinjam_buku/screens/pinjam_buku_form.dart';
import 'package:readnow_mobile/wishlists/screens/list_wishlist.dart';

class BookDetails extends StatefulWidget {
  final Book book;
  const BookDetails({Key? key, required this.book}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  TextEditingController isbnController = TextEditingController();
  TextEditingController publishYearController = TextEditingController();

  @override
  void dispose() {
    isbnController.dispose();
    super.dispose();
  }

  Future<List<Book>> fetchBook(CookieRequest cookieRequest) async {
    // final request = context.watch<CookieRequest>();
    Book book = widget.book;
    var urlWithId =
        "https://readnow-c14-tk.pbp.cs.ui.ac.id/rekomendasi/json/${book.pk}";
    var url = Uri.parse(urlWithId);
    // melakukan decode response menjadi bentuk json
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Book> listRecommendation = [];
    for (var d in data) {
      if (d != null) {
        listRecommendation.add(Book.fromJson(d));
      }
    }

    // ==================== fetching Wishlist ====================
    var responseWishlist = await cookieRequest.get(
        "https://readnow-c14-tk.pbp.cs.ui.ac.id/wishlist/get-wishlist/");
    wishlistBookId.clear();
    // konversi json menjadi object Product
    for (var d in responseWishlist) {
      if (d != null) {
        wishlistBookId.add(d["pk"]);
      }
    }
    // ============================================================

    return listRecommendation;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    bool isWishlist = false;
    Book book = widget.book;
    Status status = book.fields.status; // ini adalah enum value
    String statusString = statusValues.reverse[status] ??
        'Available'; // ini mengonversi enum ke string
    return Scaffold(
        backgroundColor: const Color(0xFFF5F9FF),
        // appBar: AppBar(
        //   title: const Text('Book Recommendation'),
        //   backgroundColor: const Color.fromARGB(255, 139, 209, 252),
        //   foregroundColor: Colors.black,
        // ),
        // drawer: const LeftDrawer(),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
                // autogroupmnefJHH (4nWivJaxzYJUzRapFrMneF)
                width: double.infinity,
                height: 410,
                child: Stack(
                  children: [
                    Positioned(
                      // autogroupf2exQ5R (4nWfcyv6AV9T87Gtj2F2EX)
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: 415,
                        height: 399,
                        child: Stack(
                          children: [
                            Positioned(
                              // frame781R (68:609)
                              left: 0,
                              top: 0,
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 49, 20, 99),
                                width: 415,
                                height: 361,
                                decoration: const BoxDecoration(
                                  color: Color(0xff8bd0fc),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(
                                            context); // Melakukan pop pada navigator ketika diklik
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 24),
                                        width: 30,
                                        height: 30,
                                        child: const Icon(Icons.arrow_back_ios,
                                            size: 30),
                                      ),
                                    ),
                                    Container(
                                      // autogroupgv517tw (4nWfnydSDYyNKei3WKGv51)
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      width: double.infinity,
                                      height: 159,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // rectangle278Eif (68:628)
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 20, 4),
                                            width: 100,
                                            height: 145,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                book.fields.imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            // group1843LFu (68:611)
                                            width: 230,
                                            height: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // autogroupwpdvGQT (4nWg1PSRVve5jAZA4PWPDV)
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 4),
                                                  width: 220,
                                                  height: 77,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        // aloneatruestory9j9 (68:612)
                                                        left: 0,
                                                        top: 0,
                                                        child: Align(
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 80,
                                                            child: Text(
                                                              book.fields.title,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 1.5,
                                                                color: const Color(
                                                                    0xff1f1e22),
                                                              ),
                                                              maxLines:
                                                                  2, // Contoh: Batasi maksimal 2 baris
                                                              overflow: TextOverflow
                                                                  .ellipsis, // Ganti dengan TextOverflow.visible jika ingin teks terus berlanjut ke baris berikutnya
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        // morganmaxwellyy5 (68:613)
                                                        left: 0,
                                                        top: 50,
                                                        child: Align(
                                                          child: SizedBox(
                                                            width: 200,
                                                            height: 40,
                                                            child: Text(
                                                              book.fields
                                                                  .authors,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 3,
                                                                color: const Color(
                                                                    0xff1f1e22),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  // autogrouphxabsHm (4nWg6dngNqQ67B7DDfhXab)
                                                  width: 180,
                                                  height: 78,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        // pagesD6j (68:614)
                                                        left: 0,
                                                        top: 0,
                                                        child: Align(
                                                          child: SizedBox(
                                                            width: 100,
                                                            height: 40,
                                                            child: Text(
                                                              '${book.fields.numOfPages} pages',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                height:
                                                                    3.0769230769,
                                                                color: const Color(
                                                                    0xff77777a),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        // 7C7 (68:615)
                                                        left: 50,
                                                        top: 38,
                                                        child: Align(
                                                          child: SizedBox(
                                                            width: 70,
                                                            height: 40,
                                                            child: Text(
                                                              '(${book.fields.ratingDistTotal})',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                height:
                                                                    3.6363636364,
                                                                color: const Color(
                                                                    0xff1f1e22),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        // 12b (68:616)
                                                        left: 0,
                                                        top: 38,
                                                        child: Align(
                                                          child: SizedBox(
                                                            width: 40,
                                                            height: 40,
                                                            child: Text(
                                                              book.fields
                                                                  .rating,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height:
                                                                    2.3529411765,
                                                                color: const Color(
                                                                    0xffff8f5c),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              // frame8rou (68:621)
                              left: 20,
                              top: 323,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    28.5, 12, 24.5, 6),
                                width: 375,
                                height: 76,
                                decoration: BoxDecoration(
                                  color: const Color(0xfff1f1f1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // autogroupqenxFr3 (4nWgaY9rSZVmsUn1UwqENX)
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 53, 1),
                                      width: 90,
                                      height: 57,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // isbnyX9 (68:622)
                                            left: 23.5,
                                            top: 17,
                                            child: Align(
                                              child: SizedBox(
                                                width: 30,
                                                height: 40,
                                                child: Text(
                                                  'ISBN',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w500,
                                                    height: 5,
                                                    color:
                                                        const Color(0xff77777a),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // fum (68:627)
                                            left: 0,
                                            top: 0,
                                            child: Align(
                                              child: SizedBox(
                                                width: 90,
                                                height: 40,
                                                child: Text(
                                                  book.fields.isbn,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    height: 3.3333333333,
                                                    color:
                                                        const Color(0xff1f1e22),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // autogroupcnewaWw (4nWgecsPM3eDwi6VicCnew)
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 50.5, 0),
                                      width: 50,
                                      height: double.infinity,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // publisherJxj (68:623)
                                            left: 0,
                                            top: 18,
                                            child: Align(
                                              child: SizedBox(
                                                width: 45,
                                                height: 40,
                                                child: Text(
                                                  'Publisher',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w500,
                                                    height: 5,
                                                    color:
                                                        const Color(0xff77777a),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // nalAzw (68:626)
                                            left: 0,
                                            top: 0,
                                            child: Align(
                                              child: SizedBox(
                                                width: 48,
                                                height: 40,
                                                child: Text(
                                                  book.fields.publisher,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    height: 3.3333333333,
                                                    color:
                                                        const Color(0xff1f1e22),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      // autogroupfyu1fgo (4nWgi7mZGKUts3oCVTfYu1)
                                      width: 65,
                                      height: double.infinity,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // statusRR5 (68:624)
                                            left: 16.5,
                                            top: 18,
                                            child: Align(
                                              child: SizedBox(
                                                width: 30,
                                                height: 40,
                                                child: Text(
                                                  'Status',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w500,
                                                    height: 5,
                                                    color:
                                                        const Color(0xff77777a),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // availablev6w (68:625)
                                            left: 0,
                                            top: 0,
                                            child: Align(
                                              child: SizedBox(
                                                width: 65,
                                                height: 40,
                                                child: Text(
                                                  statusString,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    height: 3.3333333333,
                                                    color:
                                                        const Color(0xff1f1e22),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
                // autogroupmnefJHH (4nWivJaxzYJUzRapFrMneF)
                width: double.infinity,
                height: 200,
                child: Stack(
                  children: [
                    Container(
                      // autogroupk1ejkiX (4nWokqCCk4MdJuHfWRk1Ej)
                      margin: const EdgeInsets.fromLTRB(21, 0, 38, 34),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // reviewsHiT (108:1865)
                            margin: const EdgeInsets.fromLTRB(0, 1, 185, 0),
                            child: Text(
                              'Reviews',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 3.0769230769,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // addyourreviewQHH (108:1867)
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewPage(bookid: widget.book.pk),
                                  ),
                                );
                              },
                              child: Text(
                                'Add your review',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  height: 3.6363636364,
                                  color: const Color(0xff77777a),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment
                          .center, // Menempatkan teks di tengah container
                      child: Text(
                        'No reviews yet.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff77777a),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
                // autogroupmnefJHH (4nWivJaxzYJUzRapFrMneF)
                width: double.infinity,
                height: 48,
                child: Stack(
                  children: [
                    Container(
                      // line4GLj (108:1897)
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                      width: double.infinity,
                      height: 1,
                      decoration: const BoxDecoration(
                        color: Color(0xffd6d5d2),
                      ),
                    ),
                    Container(
                      // autogroupsxymPgF (4nWosQqaAJxZBWxwSQsXym)
                      margin: const EdgeInsets.fromLTRB(16, 0, 24, 0),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // similarbooksvAP (108:1866)
                            margin: const EdgeInsets.fromLTRB(5, 0, 230, 1),
                            child: Text(
                              'Similar Books',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 3.0769230769,
                                color: const Color(0xff1f1e22),
                              ),
                            ),
                          ),
                          Container(
                            // seeallERy (108:1869)
                            margin: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RecommendationPage(
                                        book:
                                            book))); // Melakukan pop pada navigator ketika diklik
                              },
                              child: Text(
                                'See all',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  height: 3.6363636364,
                                  color: const Color(0xff1f1e22),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
                // autogroupbtwwerf (4nWi7AGrNp67AkZ9jtBtWw)
                left: 22,
                top: 800,
                child: SizedBox(
                    width: 420,
                    height: 150,
                    // decoration: BoxDecoration(
                    //   color: Color(0xff8bd0fc),
                    // ),
                    child: FutureBuilder(
                        future: fetchBook(request),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (!snapshot.hasData) {
                              return const Column(
                                children: [
                                  Text(
                                    "Tidak ada data item.",
                                    style: TextStyle(
                                        color: Color(0xff59A5D8), fontSize: 20),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              );
                            } else {
                              return GridView.builder(
                                  // ignore: prefer_const_constructors
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        3, // Number of items per row// Aspect ratio of the items
                                  ),
                                  itemCount: snapshot.data!.length > 3
                                      ? 3
                                      : snapshot.data!.length,
                                  itemBuilder: (_, index) => InkWell(
                                      onTap: () {
                                        // Navigasi ke halaman ItemInformations dengan membawa data item
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RecommendationPage(
                                              book: book,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        // autogroupbm4waVR (4nWiKEm4XMJ6CccxbnBm4w)
                                        margin: const EdgeInsets.fromLTRB(
                                            28, 0, 5, 0),
                                        width: 120,
                                        height: 200,
                                        child: Stack(children: [
                                          Positioned(
                                            // book6uGo (68:656)
                                            left: 2,
                                            top: 0,
                                            child: SizedBox(
                                              width: 120,
                                              height: 140.8,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    // rectangle280dCo (68:657)
                                                    left: 12.5427246094,
                                                    top: 10.9750976562,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 71.34,
                                                        height: 105.83,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: index % 2 ==
                                                                    0
                                                                ? const Color(
                                                                    0xfffce76c)
                                                                : const Color(
                                                                    0xff8bd0fc),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    // rectangle277Yaf (68:658)
                                                    left: 0,
                                                    top: 0,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 71.34,
                                                        height: 105.83,
                                                        child: Image.network(
                                                          "${snapshot.data![index].fields.imageUrl}",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // thedavincicode4J7 (68:665)
                                            left: 0,
                                            top: 112,
                                            child: Align(
                                              child: SizedBox(
                                                width: 92,
                                                height: 30,
                                                child: Text(
                                                  "${snapshot.data![index].fields.title}",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    height: 4,
                                                    color:
                                                        const Color(0xff1f1e22),
                                                    // backgroundColor:Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      )));
                            }
                          }
                        }))),
          ]),
        ),
        bottomNavigationBar: InkWell(
            onTap: () {
              if (kDebugMode) print("Menekan tombol wishlist");
            },
            child: Positioned(
              left: 0,
              right: 0,
              bottom: 0, // Menempelkan ke bawah layar
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xfffce76c),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BorrowFormPage(bookid: widget.book.pk)));
                        },
                        child: Container(
                          // frame107NB (I78:939;74:806)
                          margin: const EdgeInsets.fromLTRB(0, 0, 34, 0),
                          width: 295,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: statusString == "Available"
                                ? const Color(0xff8bd0fc)
                                : const Color.fromARGB(255, 197, 197, 197),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Borrow this book',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                height: 2.3529411765,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        )),
                    Container(
                      // vectornDR (I78:939;75:809)
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                      width: 26,
                      height: 23,
                      child: InkWell(
                          onTap: () async {
                            if (isWishlist) {
                              removeItem(book.pk, request);
                              // setState
                              wishlistBookId.remove(book.pk);
                              isWishlist = false;
                            } else {
                              final response = await request.post(
                                  'https://readnow-c14-tk.pbp.cs.ui.ac.id/wishlist/add-wishlist-flutter/${widget.book.pk}/',
                                  {});
                              if (response["status"] == "success") {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Item added to wishlist'),
                                    ),
                                  );
                                }
                                wishlistBookId.add(book.pk);
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Failed to add this book to wishlist'),
                                    ),
                                  );
                                }
                              }
                              // set state
                              wishlistBookId.add(book.pk);
                              isWishlist = true;
                            }
                            setState(() {
                              if (kDebugMode){
                                print("setState!: $isWishlist");
                              }
                            });
                          },
                          child: FutureBuilder(
                              future: fetchBook(request),
                              builder: (context, AsyncSnapshot snapshot) {
                                for (var id in wishlistBookId) {
                                  if (id == widget.book.pk) {
                                    isWishlist = true;
                                    break;
                                  } else {
                                    isWishlist = false;
                                  }
                                }
                                if (snapshot.data == null ||
                                    !snapshot.hasData) {
                                  return const Center(
                                      child: Icon(Icons.favorite_border_rounded,
                                          size: 26));
                                } else {
                                  if (kDebugMode) {
                                    // print("is ${book.fields.title} Wishlist? $isWishlist");
                                  }
                                  return Center(
                                    child: isWishlist
                                        ? const Icon(Icons.favorite)
                                        : const Icon(
                                            Icons.favorite_border_rounded,
                                            size: 26),
                                  );
                                }
                              })),
                    ),
                  ],
                ),
              ),
            )));
  }

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
  }
}
