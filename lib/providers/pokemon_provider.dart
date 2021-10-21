import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/pokemon_api_client.dart';

// data class stored in state
class Pokemons {
  List<Pokemon> pokemons = [];
}

// state
class PokemonsState extends StateNotifier<Pokemons> {
  PokemonsState() : super(Pokemons());

  Future<void> fetchPokemons() async {
    const int maxNumber = 385;
    for (int i = 1; i <= maxNumber; i++) {
      try {
        final responseBody = await PokemonApiClient().get(i);
        state.pokemons.add(Pokemon.fromJson(responseBody));
      } catch (e) {
        print(e);
      }
    }
  }
}

// provider
final pokemonProvider = StateNotifierProvider((_) => PokemonsState());
