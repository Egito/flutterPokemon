import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedio/app/modules/domain/pokemon.dart';
import 'package:pokedio/app/modules/home/card_detalhe.dart';
import 'package:pokedio/app/modules/home/cards_page.dart';
import 'package:pokedio/app/modules/home/pokemon_repository.dart';
import 'package:pokedio/app/modules/home/home_module.dart';
import 'home_controller.dart';

class CardsMyPage extends StatefulWidget {
  @override
  _CardsMyPageState createState() => _CardsMyPageState();
}

class _CardsMyPageState extends ModularState<CardsMyPage, HomeController> {
  final PokemonRepository repository = HomeModule.to.get<PokemonRepository>();
  List<Pokemon> pokemons = [];

  void initState() {
    loadPokemons();
    super.initState();
  }

  void loadPokemons() async {
    var pokeGuardados = await repository.getPokeGuardados();
    setState(() {
      pokemons = pokeGuardados;
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
