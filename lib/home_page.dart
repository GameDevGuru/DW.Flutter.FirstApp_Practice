import 'package:flutter/material.dart';
import 'kanto_map_page.dart';
import 'pokedex_page.dart';
import 'create_pokemon_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = [
    KantoMapPage(pageTitle: "Kanto Map"),
    PokedexPage(pageTitle: "Your Pokemon!"),
    CreatePokemonPage(pageTitle: "Create Your Pokemon!")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pages
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        onTap: (index) => setState(() => _currentPageIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Kanto Map'),
          BottomNavigationBarItem(icon: Icon(Icons.catching_pokemon), label: 'Pokedex'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create Pokemon')
        ],
      ),
    );
  }
}

