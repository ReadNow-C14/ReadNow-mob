import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:readnow_mobile/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:readnow_mobile/rekomendasi/rekomendasi_filter.dart';
import 'package:readnow_mobile/rekomendasi/rekomendasi_isbn.dart';

class RecommendationPage extends StatefulWidget {
  final Book book;
  const RecommendationPage({Key? key, required this.book}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  TextEditingController isbnController = TextEditingController();
  TextEditingController publishYearController = TextEditingController();

  @override
  void dispose() {
    isbnController.dispose();
    super.dispose();
  }

  Future<List<Book>> fetchBook() async {
    Book book = widget.book;
    // final request = context.watch<CookieRequest>();
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
    return listRecommendation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F9FF),
        appBar: AppBar(
          title: const Text('Book Recommendation'),
          backgroundColor: const Color.fromARGB(255, 139, 209, 252),
          foregroundColor: Colors.black,
        ),
        // drawer: const LeftDrawer(),
        body: SingleChildScrollView(
            child: Column(children: [
          // ================================= Field Search by ISBN =================================
          Container(
            margin: const EdgeInsets.fromLTRB(13, 10, 19.66, 10),
            padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: TextFormField(
              controller: isbnController, // Menetapkan TextEditingController
              decoration: InputDecoration(
                hintText: 'Find Recommendation by ISBN',
                hintStyle: GoogleFonts.mulish(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffb4bdc4),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/search.png",
                      width: 30, height: 30),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xffffffff),
                contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              ),
              onFieldSubmitted: (String value) {
                isbnController.clear();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RekomendasiISBN(
                      isbn: value), // Mengirim ISBN ke RecommendationPage
                ));
              },
            ),
          ),
          // ================================= Filter PublishedYear =================================
          Container(
            margin: const EdgeInsets.fromLTRB(13, 0, 19.66, 10),
            padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: TextFormField(
              controller:
                  publishYearController, // Menetapkan TextEditingController
              decoration: InputDecoration(
                hintText: 'Filter books by publish year',
                hintStyle: GoogleFonts.mulish(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffb4bdc4),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.filter_alt_outlined,
                    size: 30, // Mengatur ukuran ikon
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xffffffff),
                contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              ),
              onFieldSubmitted: (String value) {
                publishYearController.clear();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RekomendasiFilter(
                      publishedYear: int.parse(value),
                      bookId: 1), // Mengirim publishedYear ke RekomendasiFilter
                ));
              },
            ),
          ),
          // ================================= Display all books data =================================
          FutureBuilder(
              future: fetchBook(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text(
                          "Tidak ada data item.",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true, // Menambahkan ini
                        physics:
                            const NeverScrollableScrollPhysics(), // Mencegah ListView sendiri dapat di-scroll
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => GridTile(
                              child: Container(
                                // 7WT (1:2768)
                                margin: const EdgeInsets.fromLTRB(13, 0, 13, 20),
                                width: double.infinity,
                                height: 142,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // rectangle39D (1:2769)
                                      left: 0,
                                      top: 8,
                                      child: Align(
                                        child: SizedBox(
                                          width: 380,
                                          height: 134,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: const Color(0xffffffff),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x14000000),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // imageKcX (1:2770)
                                      left: 0,
                                      top: 8,
                                      child: Align(
                                        child: SizedBox(
                                          width: 110,
                                          height: 134,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xff000000),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                bottomLeft: Radius.circular(16),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                bottomLeft: Radius.circular(16),
                                              ),
                                              child: Image.network(
                                                "${snapshot.data![index].fields.imageUrl}",
                                                fit: BoxFit
                                                    .cover, // Atur fit ke BoxFit.cover
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // graphicdesignRfZ (1:2771)
                                      left: 144,
                                      top: 23,
                                      child: Align(
                                        child: SizedBox(
                                          width: 150,
                                          height: 16,
                                          child: Text(
                                            "${snapshot.data![index].fields.authors}",
                                            style: GoogleFonts.mulish(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              height: 1.255,
                                              color: const Color(0xffff6b00),
                                            ),
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // graphicdesignadvanvMR (1:2772)
                                      left: 144,
                                      top: 44,
                                      child: Align(
                                        child: SizedBox(
                                          width: 210,
                                          height: 24,
                                          child: Text(
                                            "${snapshot.data![index].fields.title}",
                                            style: GoogleFonts.jost(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              height: 1.445,
                                              color: const Color(0xff202244),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // starDbR (1:2773)
                                      left: 143.9998779297,
                                      top: 73,
                                      child: SizedBox(
                                        width: 141,
                                        height: 19,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              // starLg3 (1:2774)
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 3, 2.6),
                                              width: 12,
                                              height: 11.4,
                                              child: Image.asset(
                                                "assets/images/star.webp",
                                                width: 12,
                                                height: 11.4,
                                              ),
                                            ),
                                            Container(
                                              // FY7 (1:2777)
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 8, 0),
                                              child: Text(
                                                "${snapshot.data![index].fields.rating}",
                                                style: GoogleFonts.mulish(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w800,
                                                  height: 1.255,
                                                  color: const Color(0xff202244),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // n2F (1:2778)
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 8, 1),
                                              child: Text(
                                                '|',
                                                style: GoogleFonts.mulish(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.255,
                                                  color: const Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // starLg3 (1:2774)
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 3, 2.6),
                                              width: 12,
                                              height: 11.4,
                                              child: Image.asset(
                                                "assets/images/user.webp",
                                                width: 12,
                                                height: 11.4,
                                              ),
                                            ),
                                            Text(
                                              // hrs36mins6Hq (1:2779)
                                              "${snapshot.data![index].fields.ratingDistTotal}",
                                              style: GoogleFonts.mulish(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w800,
                                                height: 1.255,
                                                color: const Color(0xff202244),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // viewcertificatepjd (1:2780)
                                      left: 144,
                                      top: 105,
                                      child: Align(
                                        child: SizedBox(
                                          width: 200,
                                          height: 18,
                                          child: Text(
                                            '${snapshot.data![index].fields.numOfPages} Pages',
                                            style: GoogleFonts.mulish(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              height: 1.255,
                                              color:
                                                  const Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  }
                }
              })
        ])));
  }
}
