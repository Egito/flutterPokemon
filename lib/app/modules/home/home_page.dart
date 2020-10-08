import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedio/app/modules/domain/pokemon.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  List<Pokemon> pokemons = [
    Pokemon(
        id: 'xx',
        imageUrl: '',
        imageUrl1HiRes: 'xx',
        name: 'Magneton',
        types: ["Lightning"]),
    Pokemon(
        id: 'xy',
        imageUrl: '',
        imageUrl1HiRes: 'xy',
        name: 'Alakazan',
        types: ["Psychic"]),
    Pokemon(
        id: 'xz',
        imageUrl: '',
        imageUrl1HiRes: 'xz',
        name: 'Fighting',
        types: ["Hariyama"]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 0.72,
        crossAxisCount: 2,
        children: List.generate(pokemons.length, (index) {
          var poke = pokemons[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Hero(
              tag: poke.id,
              child: Image.network(poke.imageUrl),
            ),
          );
        }),
      ),
    );
  }
}
