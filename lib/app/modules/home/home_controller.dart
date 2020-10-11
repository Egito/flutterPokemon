import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedio/app/modules/domain/pokemon.dart';
import 'package:pokedio/app/modules/home/home_module.dart';
import 'package:pokedio/app/modules/home/pokemon_repository.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final PokemonRepository pokesRepo = HomeModule.to.get<PokemonRepository>();

  @observable
  List<Pokemon> pokemons = ObservableList();

  @action
  atualizarPokemon() async {
    pokemons = await _atualizarPokemons();
  }

  List<Pokemon> getSelPokemons() => pokemons;

  Future<List<Pokemon>> _atualizarPokemons() {
    return pokesRepo.getSelPokemons();
  }

  Future<List<Pokemon>> getAllPokemons() {
    return pokesRepo.getAllPokemons();
  }

  adicionaLista(Pokemon poke) {
    pokesRepo.adicionaLista(poke);
    atualizarPokemon();
  }
}
