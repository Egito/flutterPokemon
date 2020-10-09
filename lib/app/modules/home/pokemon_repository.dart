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

    print(shared.getStringList(GUARDADOS_KEY));
  }

  Future fetchPost() async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }
}
