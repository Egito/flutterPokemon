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
        id: "neo4",
        name: "Neo Destiny",
        imageUrl: "https://images.pokemontcg.io/neo4/symbol.png",
        imageUrl1HiRes: "https://images.pokemontcg.io/neo4/logo.png",
        types: ["Lightning"]),
    Pokemon(
        id: "neo3",
        name: "Neo Revelation",
        imageUrl: "https://images.pokemontcg.io/neo3/symbol.png",
        imageUrl1HiRes: "https://images.pokemontcg.io/neo3/logo.png",
        types: ["Lightning"]),
    Pokemon(
        id: "si1",
        name: "Southern Islands",
        imageUrl: "https://images.pokemontcg.io/si1/symbol.png",
        imageUrl1HiRes: "https://images.pokemontcg.io/si1/logo.png",
        types: ["Lightning"]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 0.72,
        crossAxisCount: 2,
        children: List.generate(pokemons.length, (index) {
          var poke = pokemons[index];
          return GestureDetector(
            onTap: () => detalharPokemon(poke),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Hero(
                tag: poke.id,
                child: Image.network(poke.imageUrl),
              ),
            ),
          );
        }),
      ),
    );
  }

  detalharPokemon(Pokemon poke) {
    Navigator.of(context).push(
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return PaginaDetalhe(poke: poke);
    }));
  }
}

class PaginaDetalhe extends StatefulWidget {
  final Pokemon poke;

  PaginaDetalhe({this.poke});

  @override
  _PaginaDetalheState createState() => _PaginaDetalheState();
}

class _PaginaDetalheState extends State<PaginaDetalhe> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.poke.id,
      child: Image.network(widget.poke.imageUrl),
    );
  }
}