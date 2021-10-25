import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'providers/pokemon_provider.dart';
import 'models/pokemon.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PokemonListView(),
    );
  }
}

class PokemonListView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pokemonProvider = ref.watch(pokemonProvider);
    final List<Pokemon> _pokemons = _pokemonProvider.pokemons;

    useEffect(() {
      ref.read(pokemonProvider.notifier).fetchPokemons();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: GridView.builder(
        itemCount: _pokemons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, int index) {
          return SizedBox(
            height: 100,
            child: CachedNetworkImage(
              imageUrl: _pokemons[index].sprites.frontDefault,
              placeholder: (context, url) => Center(
                child: const CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
