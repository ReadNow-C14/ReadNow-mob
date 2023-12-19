import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readnow_mobile/main/searchpage.dart';
import 'package:readnow_mobile/main/widgets/bottom_nav.dart';

class BorrowedBookPage extends StatefulWidget {
  const BorrowedBookPage({Key? key}) : super(key: key);

  @override
  _BorrowedBookPageState createState() => _BorrowedBookPageState();
}

class _BorrowedBookPageState extends State<BorrowedBookPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xfffffffe),
          borderRadius: BorderRadius.circular(20 * MediaQuery.of(context).size.width),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // borrowedbookspageempty2m9 (90:1022)
              width:  double.infinity,
              decoration:  BoxDecoration (
                color:  Color(0xfffffffe),
                borderRadius:  BorderRadius.circular(20),
              ),
              child:
              Column(
                crossAxisAlignment:  CrossAxisAlignment.center,
                children:  [
                  Container(
                    // autogroupuqmhKET (DBzzk6ro858PG63qKbUQmh)
                    padding:  EdgeInsets.fromLTRB(20, 55, 20, 293),
                    width:  double.infinity,
                    child:
                    Column(
                      crossAxisAlignment:  CrossAxisAlignment.center,
                      children:  [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 180),  // Adjust the margin as needed
                          child: RichText(
                            textAlign: TextAlign.left,  // Align text to the left
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff000000),
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'You are borrowing '),
                                TextSpan(
                                  text: '0',
                                  style: TextStyle(color: Color(0xff8bd0fc)),
                                ),
                                TextSpan(text: ' \nbook(s) for now.'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // nothingtoshow3iB (91:1071)
                          margin:  EdgeInsets.fromLTRB(0, 0, 0, 21),
                          child:
                          Text(
                            'Nothing to show',
                            textAlign:  TextAlign.center,
                            style:  GoogleFonts.poppins (
                              fontSize:  12,
                              fontWeight:  FontWeight.w500,
                              height:  2.5,
                              fontStyle:  FontStyle.italic,
                              color:  Color(0xff77777a),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(86, 0, 87, 0),
                          width: double.infinity,
                          height: 40,
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
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 1))
                              );
                            },
                            child: Center(
                              child: Text(
                                'Search for books',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  height: 2,
                                  color: Color(0xff000000),
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
    );
  }
}
