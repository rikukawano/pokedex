import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'providers/pokemon_provider.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
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
    final _pokemons = ref.watch(pokemonProvider);

    useEffect(() {
      ref.read(pokemonProvider.notifier).fetchPokemons();
    }, []);

    String _capitalize(String str) {
      return '${str[0].toUpperCase()}${str.substring(1)}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: GridView.builder(
        itemCount: _pokemons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, int index) {
          return Column(
            children: [
              Flexible(
                flex: 1,
                child: CachedNetworkImage(
                  imageUrl: _pokemons[index].sprites.frontDefault,
                  placeholder: (context, url) => Center(
                    child: const CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(
                _capitalize(_pokemons[index].name),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                '#${_pokemons[index].id.toString()}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
