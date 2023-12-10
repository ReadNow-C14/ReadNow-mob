import 'package:flutter/material.dart';
import 'package:readnow_mobile/main/searchpage.dart';
import 'package:readnow_mobile/wishlists/screens/list_wishlist.dart';

// TODO: will be deleted later
class TemporaryLeftDrawerWishlist extends StatelessWidget {
  const TemporaryLeftDrawerWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Column(
              children: [
                Text(
                  'ReadNow',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                ),
                Text(
                  "Explore the world of books",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Home'),
            onTap: () {
              // TODO: navigate to My Wishlist
              Navigator.pop(context);
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const SearchPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border_rounded),
            title: const Text('My Wishlist'),
            onTap: () {
              // TODO: navigate to My Wishlist
              Navigator.pop(context);
              Navigator.push(
                context, 
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => MyWishlistPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            }
          ),
          ListTile(
            leading: const Icon(Icons.book_rounded),
            title: const Text('My Borrowed Books'),
            onTap: () {
              // TODO: navigate to My Borrowed Books
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}