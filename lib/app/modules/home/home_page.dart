import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedio/app/modules/home/cards_my_page.dart';
import 'package:pokedio/app/modules/home/cards_page.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  int _currIndex = 0;

  List<Widget> pags = [
    CardsPage(),
    Container(),
    CardsMyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currIndex,
          onTap: (index) => trocaPag(index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.all_inclusive), title: Text('Cards')),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), title: Text('Favoritos')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Guadados')),
          ],
        ),
        body: IndexedStack(
          index: _currIndex,
          children: pags,
        ));
  }

  trocaPag(i) {
    setState(() {
      _currIndex = i;
    });
  }
}
