import 'package:flutter_modular/flutter_modular.dart';

import 'package:dio/native_imp.dart';
import 'package:pokedio/app/modules/domain/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pokemon_repository.g.dart';

@Injectable()
class PokemonRepository extends Disposable {
  static const GUARDADOS_KEY = 'GUARDADOS_KEY';
  final DioForNative client;

  PokemonRepository(this.client);

  @override
  void dispose() {
    //dispose will be called automatically
  }

  adicionaLista(Pokemon poke) async {
    var shared = await SharedPreferences.getInstance();
    var pokemons = shared.getStringList(GUARDADOS_KEY);

    if (pokemons == null || pokemons.isEmpty) {
      shared.setStringList(GUARDADOS_KEY, [poke.toJson(CardType.Selecao)]);
    } else {
      pokemons.add(poke.toJson(CardType.Selecao));
      shared.setStringList(GUARDADOS_KEY, pokemons);
    }
  }

  Future<List<Pokemon>> getSelPokemons() async {
    var shared = await SharedPreferences.getInstance();
    var pokemons = shared.getStringList(GUARDADOS_KEY);

    if (pokemons == null) return [];
    await atualizaListaAntiga(pokemons);
    return shared
        .getStringList(GUARDADOS_KEY)
        .map<Pokemon>((json) => Pokemon.fromJson(json))
        .toList();
  }

// Atualizando os pokes ja guardados
  atualizaListaAntiga(List<String> pokemons) async {
    var pokesAntigos =
        pokemons.map<Pokemon>((e) => Pokemon.fromJson(e)).toList();

    var dRecarr = pokesAntigos.firstWhere((e) => e.cardType == CardType.Publico,
        orElse: () => null);

    if (dRecarr != null) {
      var shared = await SharedPreferences.getInstance();
      shared.setStringList(GUARDADOS_KEY, []);
      for (Pokemon poke in pokesAntigos) {
        await adicionaLista(poke);
      }
    }
  }

  Future<List<Pokemon>> getAllPokemons() async {
    final response = await client.get('https://api.pokemontcg.io/v1/cards');
    if (response != null && response.statusCode <= 300) {
      var pokes = response.data['cards'];
      return pokes.map<Pokemon>((json) => Pokemon.fromMapJson(json)).toList();
    }
    return [];
  }
}
