import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readnow_mobile/models/book.dart';
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
        'https://readnow-c14-tk.pbp.cs.ui.ac.id/wishlist/get-wishlist/');
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
        backgroundColor: const Color(0xFFF5F9FF),
        appBar: AppBar(
          title: const Text('My Wishlist'),
          backgroundColor: const Color.fromARGB(255, 139, 209, 252),
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
                      physics:
                          const NeverScrollableScrollPhysics(), // Mencegah ListView sendiri dapat di-scroll
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => GridTile(
                            child: Container(
                              // 7WT (1:2768)
                              margin: EdgeInsets.fromLTRB(13, 0, 13, 20),
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
                                            color: Color(0xffffffff),
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
                                            color: Color(0xffff6b00),
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
                                            color: Color(0xff202244),
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
                                    child: Container(
                                      width: 141,
                                      height: 19,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          // Rating icon
                                          Container(
                                            // starLg3 (1:2774)
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 3, 2.6),
                                            width: 12,
                                            height: 11.4,
                                            child: Image.asset(
                                              "assets/images/star.webp",
                                              width: 12,
                                              height: 11.4,
                                            ),
                                          ),
                                          // Rating
                                          Container(
                                            // FY7 (1:2777)
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 8, 0),
                                            child: Text(
                                              "${snapshot.data![index].fields.rating}",
                                              style: GoogleFonts.mulish(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w800,
                                                height: 1.255,
                                                color: Color(0xff202244),
                                              ),
                                            ),
                                          ),
                                          // Separator
                                          Container(
                                            // n2F (1:2778)
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 8, 1),
                                            child: Text(
                                              '|',
                                              style: GoogleFonts.mulish(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                height: 1.255,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                          // Page icon
                                          Container(
                                            // starLg3 (1:2774)
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 3, 2.6),
                                            width: 12,
                                            height: 11.4,
                                            child: Icon(
                                              Icons.file_copy_outlined,
                                              size: 12,
                                              color: Color(0xff202244),
                                            ),
                                          ),
                                          // Pages
                                          Text(
                                            // hrs36mins6Hq (1:2779)
                                            '${snapshot.data![index].fields.numOfPages} Pages',
                                            style: GoogleFonts.mulish(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w800,
                                              height: 1.255,
                                              color: Color(0xff202244),
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
                                          "ISBN: ${snapshot.data![index].fields.isbn}",
                                          style: GoogleFonts.mulish(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            height: 1.255,
                                            color: Color.fromARGB(255, 0, 0, 0),
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
            }));
  }
}
