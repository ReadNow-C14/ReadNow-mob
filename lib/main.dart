import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/main/searchpage.dart';
import 'package:readnow_mobile/review_buku/models/reviewBuku.dart';
import 'package:readnow_mobile/review_buku/screens/review_buku.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'ReadNow',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 171, 183)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const ReviewPage(bookid: 10,),
      ),
    );
  }
}
