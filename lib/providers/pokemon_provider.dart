import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/pokemon_api_client.dart';

// State
class PokemonState {
  List<Pokemon> pokemons = [];
}

// ViewModel for managing state
class PokemonViewModel extends StateNotifier<PokemonState> {
  PokemonViewModel() : super(PokemonState());

  Future<void> fetchPokemons() async {
    const int maxNumber = 385;
    for (int i = 1; i <= maxNumber; i++) {
      try {
        final responseBody = await PokemonApiClient().get(i);
        state = [...state as Iterable, Pokemon.fromJson(responseBody)]
            as PokemonState;
      } catch (e) {
        print(e);
      }
    }
  }
}

// Provider
final pokemonProvider = StateNotifierProvider<PokemonViewModel, PokemonState>(
    (_) => PokemonViewModel());
