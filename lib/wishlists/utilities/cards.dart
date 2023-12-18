import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readnow_mobile/models/book.dart';

class WishlistCard extends StatelessWidget {
  Book book;
  WishlistCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width  = MediaQuery.of(context).size.width;
    return Container(
      // 7WT (1:2768)
      margin: EdgeInsets.fromLTRB(13, 0, 13, 20),
      width: double.infinity,
      height: height*0.1,
      child: Stack(
        children: [
          // Box Row
          Positioned(
            // rectangle39D (1:2769)
            left: 0,
            top: 0.013*height,
            child: Align(
              child: SizedBox(
                width: 380,
                height: 134,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10),
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
          // Gambar
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
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Image.network(
                      "${book.fields.imageUrl}",
                      fit: BoxFit
                          .cover, // Atur fit ke BoxFit.cover
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Author
          Positioned(
            // graphicdesignRfZ (1:2771)
            left: 144,
            top: 23,
            child: Align(
              child: SizedBox(
                width: 150,
                height: 16,
                child: Text(
                  "${book.fields.authors}",
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
          // Title
          Positioned(
            // graphicdesignadvanvMR (1:2772)
            left: 144,
            top: 44,
            child: Align(
              child: SizedBox(
                width: 210,
                height: 24,
                child: Text(
                  "${book.fields.title}",
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
          // Rating & Pages
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
                      "${book.fields.rating}",
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
                    '${book.fields.numOfPages} Pages',
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
          // ISBN
          Positioned(
            // viewcertificatepjd (1:2780)
            left: 144,
            top: 105,
            child: Align(
              child: SizedBox(
                width: 200,
                height: 18,
                child: Text(
                  "ISBN: ${book.fields.isbn}",
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
    );
  }
}