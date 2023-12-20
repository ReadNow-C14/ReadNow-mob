import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readnow_mobile/models/book.dart';

// ignore: must_be_immutable
class BorrowedCard extends StatelessWidget {
  Book book;
  final VoidCallback onTap;
  BorrowedCard({Key? key, required this.book, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var containerHeight = height * 0.16;
    return Container(
      // 7WT (1:2768)
      margin: EdgeInsets.fromLTRB(
          width * 0.01, height * 0.03, width * 0.01, height * 0.005),
      width: double.infinity,
      height: height * 0.18,
      child: Stack(
        children: [
          // Box Row Beres
          Positioned(
            // rectangle39D (1:2769)
            left: width * 0.05,
            top: containerHeight * 0.05,
            child: Align(
              child: SizedBox(
                width: width,
                height: containerHeight * 0.85,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 240, 240, 240),
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
            left: width * 0.05 + containerHeight * 0.9,
            top: containerHeight * 0.17,
            child: Align(
              child: SizedBox(
                width: width * 0.55,
                height: 24,
                child: Text(
                  book.fields.title,
                  style: GoogleFonts.jost(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.445,
                    color: const Color(0xff202244),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          // Author Beres
          Positioned(
            // graphicdesignRfZ (1:2771)
            left: width * 0.05 + containerHeight * 0.9,
            top: containerHeight * 0.4,
            child: Align(
              child: SizedBox(
                width: width * 0.55,
                height: 24,
                child: Text(
                  book.fields.authors,
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
          // Rating & Pages Beres
          Positioned(
            // starDbR (1:2773)
            left: width * 0.05 + containerHeight * 0.9,
            top: containerHeight * 0.58,
            child: Align(
              child: SizedBox(
                width: 200,
                height: 18,
                child: Text(
                  "Return Date: ${book.fields.returnDate}",
                  style: GoogleFonts.mulish(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    height: 1.255,
                    color: const Color.fromARGB(255, 77, 77, 77),
                  ),
                ),
              ),
            ),
          ),
          // ISBN Beres
          Positioned(
            left: width * 0.68,
            top: containerHeight * 0.7,
            child: TextButton(
              onPressed: onTap,
              child: Container(
                width: 90,
                height: 40, // Consider increasing this if necessary
                decoration: BoxDecoration(
                  color: Color(0xfffce76c),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0, 4),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Return',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15, // Adjust font size if needed
                      fontWeight: FontWeight.w700,
                      height: 1.5, // Adjust line height if needed
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   left: width * 0.75,
          //   top: containerHeight * 0.7,
          //   child: InkWell(
          //     onTap: onTap,
          //     child: Center(
          //       child: CircleAvatar(
          //         backgroundColor: Colors.yellow,
          //         radius: containerHeight * 0.15,
          //         child: const Icon(Icons.delete_outline),
          //       ),
          //     ),
          //   ),
          // ),
          // Shading Beres
          Positioned(
            // rectangle280dCo (68:657)
            left: width * 0.05 + containerHeight * 0.1,
            top: containerHeight * 0.05,
            child: SizedBox(
              width: containerHeight * 0.95 * 0.69,
              height: containerHeight * 0.95,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Color(0xfffce76c),
                ),
              ),
            ),
          ),
          // Gambar Beres
          Positioned(
            // imageKcX (1:2770)
            left: width * 0.05,
            top: 0,
            child: Container(
              // rectangle278Eif (68:628)
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 4),
              width: containerHeight * 0.95 * 0.69,
              height: containerHeight * 0.95,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
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
