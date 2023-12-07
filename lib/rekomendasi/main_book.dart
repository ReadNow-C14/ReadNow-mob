

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:readnow_mobile/book/models/book.dart';
// import 'package:http/http.dart' as http;

// class ItemPage extends StatefulWidget {
//     const ItemPage({Key? key}) : super(key: key);

//     @override
//     _ItemPageState createState() => _ItemPageState();
// }

// class BookInventory {
//   static final List<Book> _books = _ItemPageState.fetchItem();

//   static void addBook(Book book) {
//     _books.add(book);
//   }

//   static List<Book> get books => _books;
// }

// class _ItemPageState extends State<ItemPage> {
//     Future<List<Book>> fetchItem() async {
//     // final request = context.watch<CookieRequest>();
//     var url = Uri.parse('https://readnow-c14-tk.pbp.cs.ui.ac.id/json/');
//     // melakukan decode response menjadi bentuk json
//     var response = await http.get(
//         url,
//         headers: {"Content-Type": "application/json"},
//     );

//     // melakukan decode response menjadi bentuk json
//     var data = jsonDecode(utf8.decode(response.bodyBytes));

//     // melakukan konversi data json menjadi object Product
//     List<Book> list_product = [];
//     for (var d in data) {
//         if (d != null) {
//             list_product.add(Book.fromJson(d));
//         }
//     }
//     return list_product;


// }

// static final Future<List<Book>> _books = fetchItem();
// static List<Book> get books => _books;

// @override
// Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: const Text('Item'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         ),
//         // drawer: const LeftDrawer(),
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
//                     return GridView.builder(
//                       gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                     ),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (_, index) => GridTile(
//                         child: Column(
//                           children: [
//                             Image.network("${snapshot.data![index].fields.imageUrl}"),
//                             Text("${snapshot.data![index].fields.title}"),
//                             Text("${snapshot.data![index].fields.authors}"),
//                           ],
//                         )
//                             ));
//                     }
//                 }
//             }));
//     }
// }