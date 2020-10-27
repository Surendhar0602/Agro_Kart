import 'package:flutter/material.dart';
import 'package:project/HomePage.dart';
import 'package:project/ProductPage.dart';
import 'package:project/savedpage.dart';
import 'package:project/searchpage.dart';
import 'package:project/PriceTable.dart';

class BottomNavigationBarController extends StatefulWidget {
@override
_BottomNavigationBarControllerState createState() =>
    _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState extends State<BottomNavigationBarController> {
  final List<Widget> pages = [
    HomePage(),
    SavedTab(),

    Tables(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 0;
  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
    onTap: (int index) => setState(() => _selectedIndex = index),
    currentIndex: _selectedIndex,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home,color: Colors.green,), title: Text('Home',style: TextStyle(color: Colors.green),)),
      BottomNavigationBarItem(
          icon: Icon(Icons.add,color: Colors.green), title: Text('Saved',style: TextStyle(color: Colors.green))),
      BottomNavigationBarItem(
          icon: Icon(Icons.search,color: Colors.green,), title: Text('Search',style: TextStyle(color: Colors.green))),
    BottomNavigationBarItem(
          icon: Icon(Icons.details,color: Colors.green,), title: Text('Prices',style: TextStyle(color: Colors.green))),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
