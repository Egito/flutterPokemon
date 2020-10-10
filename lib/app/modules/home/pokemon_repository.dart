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
      shared.setStringList(GUARDADOS_KEY, [poke.toJson()]);
    } else {
      pokemons.add(poke.toJson());
      shared.setStringList(GUARDADOS_KEY, pokemons);
    }
  }

  Future<List<Pokemon>> getPokeGuardados() async {
    var shared = await SharedPreferences.getInstance();
    var pokemons = shared.getStringList(GUARDADOS_KEY);

    if (pokemons == null) return [];
    return pokemons.map<Pokemon>((json) => Pokemon.fromJson(json)).toList();
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
