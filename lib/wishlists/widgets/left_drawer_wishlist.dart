import 'package:flutter/material.dart';

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
            leading: const Icon(Icons.bookmark_border_rounded),
            title: const Text('My Wishlist'),
            onTap: () {
              // TODO: navigate to My Wishlist
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_rounded),
            title: const Text('My Borrowed Books'),
            onTap: () {
              // TODO: navigate to My Wishlist
            },
          ),
        ],
      ),
    );
  }
}