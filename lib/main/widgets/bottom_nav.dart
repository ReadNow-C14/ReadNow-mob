import 'package:flutter/material.dart';
import 'package:readnow_mobile/main/searchpage.dart';
import 'package:readnow_mobile/pinjam_buku/screens/list_borrowed_book.dart';
import 'package:readnow_mobile/wishlists/screens/list_wishlist.dart';

int _currentIndex = 0;
List<bool> isSelected = [true, false, false, false];
final widgets = [
  // TODO: Search Page
  const Center(
    child: Text(
      'Harusnya Home',
      style: TextStyle(fontSize: 40),
    ),
  ),
  // const Center(
  //   child: Text(
  //     'Harusnya Search',
  //     style: TextStyle(fontSize: 40),
  //   ),
  // ),
  const SearchPage(),
  const BorrowedBookPage(),
  const MyWishlistPage(),
];

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('ReadNow'),
      //   foregroundColor: Colors.black,
      // ),
      body: widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Color(0xff8bd0fc),
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
