import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                          // autogrouptgkuczF (DBzzdgspGjkpaJGDEhTgKu)
                          margin:  EdgeInsets.fromLTRB(0, 0, 128, 180),
                          width:  double.infinity,
                          child:
                          Row(
                            crossAxisAlignment:  CrossAxisAlignment.start,
                            children:  [
                              Container(
                                // youareborrowingbooksfornowMgw (90:1023)
                                margin:  EdgeInsets.fromLTRB(0, 0, 9, 0),
                                constraints:  BoxConstraints (
                                  maxWidth:  199,
                                ),
                                child:
                                Text(
                                  'You are borrowing\nbook(s) for now.',
                                  style:  GoogleFonts.poppins (
                                    fontSize:  21,
                                    fontWeight:  FontWeight.w700,
                                    height:  1.4285714286,
                                    color:  Color(0xff000000),
                                  ),
                                ),
                              ),
                              Container(
                                // csm (90:1025)
                                margin:  EdgeInsets.fromLTRB(0, 1, 0, 0),
                                child:
                                Text(
                                  '0',
                                  style:  GoogleFonts.poppins (
                                    fontSize:  21,
                                    fontWeight:  FontWeight.w700,
                                    height:  1.4285714286,
                                    color:  Color(0xff8bd0fc),
                                  ),
                                ),
                              ),
                            ],
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
                          // returnbuttonAXu (90:1044)
                          margin:  EdgeInsets.fromLTRB(86, 0, 87, 0),
                          width:  double.infinity,
                          height:  40,
                          decoration:  BoxDecoration (
                            color:  Color(0xfffce76c),
                            borderRadius:  BorderRadius.circular(20),
                            boxShadow:  [
                              BoxShadow(
                                color:  Color(0x3f000000),
                                offset:  Offset(0, 4),
                                blurRadius:  2,
                              ),
                            ],
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              'Search for books',
                              textAlign:  TextAlign.center,
                              style:  GoogleFonts.poppins (
                                fontSize:  15,
                                fontWeight:  FontWeight.w700,
                                height:  2,
                                color:  Color(0xff000000),
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
