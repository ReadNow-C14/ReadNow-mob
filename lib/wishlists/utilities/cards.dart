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
    var containerHeight = height*0.18;
    return Container(
      // 7WT (1:2768)
      margin: EdgeInsets.fromLTRB(width*0.01, height*0.03, width*0.01, height*0.01),
      width: double.infinity,
      height: containerHeight,
      child: Stack(
        children: [
          // Box Row Beres
          Positioned(
            // rectangle39D (1:2769)
            left: width*0.05,
            top: containerHeight*0.05,
            child: Align(
              child: SizedBox(
                width: width,
                height: containerHeight*0.85,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10),
                    color: Color.fromARGB(255, 240, 240, 240),
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
          // Title Beres
          Positioned(
            // graphicdesignadvanvMR (1:2772)
            left: width*0.35,
            top: containerHeight*0.22,
            child: Align(
              child: SizedBox(
                width: width*0.55,
                height: 24,
                child: Text(
                  "${book.fields.title}",
                  style: GoogleFonts.jost(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.445,
                    color: Color(0xff202244),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          // Author Beres
          Positioned(
            // graphicdesignRfZ (1:2771)
            left: width*0.35,
            top: containerHeight*0.4,
            child: Align(
              child: SizedBox(
                width: width*0.55,
                height: 24,
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
          // Rating & Pages Beres
          Positioned(
            // starDbR (1:2773)
            left: width*0.35,
            top: containerHeight*0.50,
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
          // ISBN Beres
          Positioned(
            // viewcertificatepjd (1:2780)
            left: width*0.35,
            top: containerHeight*0.65,
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
          // Remove
          Positioned(
            left: width*0.75,
            top: containerHeight*0.7,
            child: InkWell(
              onTap: () {
                
              },
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  radius: containerHeight*0.15,
                  child: Icon(Icons.delete_outline),
                ),
              ),
            ),
          ),
          // Shading Beres
          Positioned(
            // rectangle280dCo (68:657)
            left: width*0.05+containerHeight*0.05,
            top: containerHeight*0.05,
            child: Container(
              child: SizedBox(
                width: containerHeight*0.95*0.69,
                height: containerHeight*0.95,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Color(0xfffce76c),
                  ),
                ),
              ),
            ),
          ),
          // Gambar Beres
          Positioned(
            // imageKcX (1:2770)
            left: width*0.05,
            top: 0,
            child: Container(
              // rectangle278Eif (68:628)
              margin: const EdgeInsets.fromLTRB(
                  0, 0, 20, 4),
              width: containerHeight*0.95*0.69,
              height: containerHeight*0.95,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(7),
                child: Image.network(
                  book.fields.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}