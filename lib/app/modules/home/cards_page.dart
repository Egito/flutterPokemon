import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedio/app/modules/domain/pokemon.dart';
import 'package:pokedio/app/modules/home/card_detalhe.dart';
import 'package:pokedio/app/modules/home/pokemon_repository.dart';
import 'package:pokedio/app/modules/home/home_module.dart';
import 'home_controller.dart';

class CardsPage extends StatefulWidget {
  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends ModularState<CardsPage, HomeController> {
  final PokemonRepository repository = HomeModule.to.get<PokemonRepository>();
  List<Pokemon> pokemons = [];

  void initState() {
    loadPokemons();
    super.initState();
  }

  void loadPokemons() async {
    var allPokemons = await repository.getAllPokemons();
    setState(() {
      pokemons = allPokemons;
    });
  }

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
