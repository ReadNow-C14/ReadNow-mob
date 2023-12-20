// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:readnow_mobile/main/searchpage.dart';
import 'package:readnow_mobile/pinjam_buku/screens/list_borrowed_book.dart';
import 'package:readnow_mobile/wishlists/screens/list_wishlist.dart';

final widgets = [
  const SearchPage(),
  const BorrowedBookPage(),
  const MyWishlistPage(),
];

class BottomNav extends StatefulWidget {
  final int initialIndex; // Add this line

  const BottomNav({Key? key, this.initialIndex = 0}) : super(key: key); // Modify this line

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _currentIndex; // Modify this line

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Set initial index based on the parameter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff8bd0fc),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            backgroundColor: Color(0xff8bd0fc),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Borrow',
              backgroundColor: Color(0xff8bd0fc),
              activeIcon: Icon(Icons.book_rounded)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_rounded),
            label: 'Wishlist',
            backgroundColor: Color(0xff8bd0fc),
            activeIcon: Icon(Icons.favorite),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}