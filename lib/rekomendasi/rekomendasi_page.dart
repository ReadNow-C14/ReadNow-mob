

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';
import 'package:readnow_mobile/models/book.dart';
// import 'package:readnow_mobile/rekomendasi/models/book_recommendation.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';



class RecommendationPage extends StatefulWidget {
    const RecommendationPage({Key? key}) : super(key: key);

    @override
    _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
    Future<List<Book>> fetchItem() async {
    // final request = context.watch<CookieRequest>();
    // var urlWithId = "http://127.0.0.1:8000/rekomendasi/json/1";
    var urlWithId = "https://readnow-c14-tk.pbp.cs.ui.ac.id/rekomendasi/json/2";
    var url = Uri.parse(urlWithId);
    // melakukan decode response menjadi bentuk json
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Book> list_recommendation = [];
    for (var d in data) {
      if (d != null) {
        list_recommendation.add(Book.fromJson(d));
      }
    }
    return list_recommendation.sublist(1,21);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Item'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        ),
        // drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchItem(),
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
                    //   gridDelegate:
                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2,
                    // ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => GridTile(
                        child: 
                        // Column(
                        //   children: [
                        //     Image.network("${snapshot.data![index].fields.imageUrl}"),
                        //     Text("${snapshot.data![index].fields.title}"),
                        //     Text("${snapshot.data![index].fields.authors}"),
                        //   ],
                        // )
                        Container(
  // 7WT (1:2768)
  margin:  EdgeInsets.fromLTRB(13, 0, 19.66, 20),
  width:  double.infinity,
  height:  142,
  child:  
Stack(
  children:  [
Positioned(
  // rectangle39D (1:2769)
  left:  0,
  top:  8,
  child:  
Align(
  child:  
SizedBox(
  width:  360,
  height:  134,
  child:  
Container(
  decoration:  BoxDecoration (
    borderRadius:  BorderRadius.circular(16),
    color:  Color(0xffffffff),
    boxShadow:  [
      BoxShadow(
        color:  Color(0x14000000),
        offset:  Offset(0, 4),
        blurRadius:  5,
      ),
    ],
  ),
),
),
),
),
Positioned(
  // imageKcX (1:2770)
  left:  0,
  top:  8,
  child:  
Align(
  child:  
SizedBox(
  width:  110,
  height:  134,
  child:  
Container(
  decoration:  BoxDecoration (
    color:  Color(0xff000000),
    borderRadius:  BorderRadius.only (
      topLeft:  Radius.circular(16),
      bottomLeft:  Radius.circular(16),
    ),
    
  ),
  child: Image.network("${snapshot.data![index].fields.imageUrl}", )
),
),
),
),
Positioned(
  // graphicdesignRfZ (1:2771)
  left:  144,
  top:  23,
  child:  
Align(
  child:  
SizedBox(
  width:  88,
  height:  16,
  child:  
Text(
  "${snapshot.data![index].fields.authors}",
  style:  GoogleFonts.mulish(
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
  left:  144,
  top:  44,
  child:  
Align(
  child:  
SizedBox(
  width:  191,
  height:  24,
  child:  
Text(
  "${snapshot.data![index].fields.title}",
  style:  GoogleFonts.jost (
    fontSize:  16,
    fontWeight:  FontWeight.w600,
    height:  1.445,
    color:  Color(0xff202244),
  ),
  overflow: TextOverflow.ellipsis,
),
),
),
),
Positioned(
  // starDbR (1:2773)
  left:  143.9998779297,
  top:  73,
  child:  
Container(
  width:  141,
  height:  19,
  child:  
Row(
  crossAxisAlignment:  CrossAxisAlignment.end,
  children:  [
Container(
  // starLg3 (1:2774)
  margin:  EdgeInsets.fromLTRB(0, 0, 3, 2.6),
  width:  12,
  height:  11.4,
  child:  
Image.network(
  "https://i.postimg.cc/kXckyZTr/star.png",
  width:  12,
  height:  11.4,
),
),
Container(
  // FY7 (1:2777)
  margin:  EdgeInsets.fromLTRB(0, 0, 8, 0),
  child:  
Text(
  "${snapshot.data![index].fields.rating}",
  style:  GoogleFonts.mulish(
    fontSize:  11,
    fontWeight:  FontWeight.w800,
    height:  1.255,
    color:  Color(0xff202244),
  ),
),
),
Container(
  // n2F (1:2778)
  margin:  EdgeInsets.fromLTRB(0, 0, 8, 1),
  child:  
Text(
  '|',
  style:  GoogleFonts.mulish(
    fontSize:  14,
    fontWeight:  FontWeight.w700,
    height:  1.255,
    color:  Color(0xff000000),
  ),
),
),
Container(
  // starLg3 (1:2774)
  margin:  EdgeInsets.fromLTRB(0, 0, 3, 2.6),
  width:  12,
  height:  11.4,
  child:  
Image.network(
  "https://i.postimg.cc/c1VvYfZY/user.png",
  width:  12,
  height:  11.4,
),
),
Text(
  // hrs36mins6Hq (1:2779)
  "${snapshot.data![index].fields.ratingDistTotal}",
  style:  GoogleFonts.mulish(
    fontSize:  11,
    fontWeight:  FontWeight.w800,
    height:  1.255,
    color:  Color(0xff202244),
  ),
  overflow: TextOverflow.ellipsis,
),
  ],
),
),
),
Positioned(
  // viewcertificatepjd (1:2780)
  left:  225,
  top:  107,
  child:  
Align(
  child:  
SizedBox(
  width:  113,
  height:  16,
  child:  
Text(
  'VIEW DETAIL',
  style:  GoogleFonts.mulish(
    fontSize:  12,
    fontWeight:  FontWeight.w800,
    height:  1.255,
    decoration:  TextDecoration.underline,
    color:  Color(0xff167f71),
    decorationColor:  Color(0xff167f71),
  ),
),
),
),
),
  ],
),
),
                      )
                    );
                  }
                }
              }
            )
          );
    }
}

// @override
// Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: const Text('Item'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         ),
//         drawer: const LeftDrawer(),
//         body: FutureBuilder(
//             future: fetchItem(),
//             builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.data == null) {
//                     return const Center(child: CircularProgressIndicator());
//                 } else {
//                     if (!snapshot.hasData) {
//                     return const Column(
//                         children: [
//                         Text(
//                             "Tidak ada data item.",
//                             style:
//                                 TextStyle(color: Color(0xff59A5D8), fontSize: 20),
//                         ),
//                         SizedBox(height: 8),
//                         ],
//                     );
//                 } else {
//                     return ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (_, index) => InkWell(
//                           onTap: () {
//                             // Navigasi ke halaman ItemInformations dengan membawa data item
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ItemInformation(
//                                   item: snapshot.data![index],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                             padding: const EdgeInsets.all(20.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "${snapshot.data![index].fields.name}",
//                                   style: const TextStyle(
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text("${snapshot.data![index].fields.amount}"),
//                                 const SizedBox(height: 10),
//                                 Text("${snapshot.data![index].fields.description}")
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                 }
//             }));
//     }
// }