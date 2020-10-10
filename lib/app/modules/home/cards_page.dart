import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedio/app/modules/domain/pokemon.dart';
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
  bool mostraExpandido = true;
  final PokemonRepository repository = HomeModule.to.get<PokemonRepository>();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.poke.name),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: null),
          IconButton(
              icon: Icon(Icons.person_add), onPressed: () => adicionaLista()),
        ],
      ),
      body: GestureDetector(
        onTap: () => {
          setState(() {
            mostraExpandido = !mostraExpandido;
          })
        },
        child: Center(
          child: Hero(
            tag: widget.poke.id,
            child: Image.network(
              mostraExpandido
                  ? widget.poke.imageUrlHiRes
                  : widget.poke.imageUrl,
            ),
          ),
        ),
      ),
    );
  }

  adicionaLista() {
    repository.adicionaLista(widget.poke);
    _key.currentState.showSnackBar(
      SnackBar(content: Text("Guardado!")),
    );
  }
}
