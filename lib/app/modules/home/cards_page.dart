import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedio/app/modules/domain/pokemon.dart';
import 'package:pokedio/app/modules/home/card_detalhe.dart';
import 'home_controller.dart';

class CardsPage extends StatefulWidget {
  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends ModularState<CardsPage, HomeController> {
  List<Pokemon> pokes = [];

  void initState() {
    loadPokemons();
    super.initState();
  }

  void loadPokemons() async {
    var allPokes = await controller.getAllPokemons();
    setState(() {
      pokes = allPokes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 0.72,
        crossAxisCount: 2,
        children: List.generate(pokes.length, (index) {
          var poke = pokes[index];
          return GestureDetector(
            onTap: () => detalharPokemon(poke),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Hero(
                tag: poke.uniqueId,
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
