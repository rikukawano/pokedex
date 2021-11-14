import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/pokemon_list_view.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Press Start 2P',
              bodyColor: Colors.white.withOpacity(0.87),
              displayColor: Colors.white.withOpacity(0.87),
              fontSizeFactor: 0.9,
            ),
      ),
      home: PokemonListView(),
    );
  }
}
