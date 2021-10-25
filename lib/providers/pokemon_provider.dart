import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/pokemon_api_client.dart';

// // State
// class PokemonState {
//   List<Pokemon> pokemons = [];
// }

// ViewModel for managing state
class PokemonViewModel extends StateNotifier<List<Pokemon>> {
  PokemonViewModel([List<Pokemon>? pokemons]) : super(pokemons ?? []);

  Future<void> fetchPokemons() async {
    const int maxNumber = 100;
    for (int i = 1; i <= maxNumber; i++) {
      try {
        final responseBody = await PokemonApiClient().get(i);
        state = [...state, Pokemon.fromJson(responseBody)];
      } catch (e) {
        print(e);
      }
    }
  }
}

// Provider
final pokemonProvider = StateNotifierProvider<PokemonViewModel, List<Pokemon>>(
    (ref) => PokemonViewModel());
