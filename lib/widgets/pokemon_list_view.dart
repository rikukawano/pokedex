import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/providers/pokemon_provider.dart';
import '/widgets/pokemon_details_card.dart';

class PokemonListView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pokemons = ref.watch(pokemonProvider);

    useEffect(() {
      ref.read(pokemonProvider.notifier).fetchPokemons();
    }, []);

    final _errorPokemons = useState([]);

    String _getUrl(String name) => name == 'sirfetchd'
        ? 'https://projectpokemon.org/images/sprites-models/swsh-normal-sprites/sirfetchd.gif'
        : 'https://projectpokemon.org/images/normal-sprite/$name.gif';

    return Scaffold(
      backgroundColor: const Color(0x202124),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          itemCount: _pokemons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (BuildContext context, int index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: CachedNetworkImage(
              alignment: Alignment.bottomCenter,
              imageUrl: _getUrl(_pokemons[index].name),
              placeholder: (context, url) => Center(
                child: const CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) {
                if (index == 890)
                  _errorPokemons.value.forEach((name) => print('⚠️$name'));
                _errorPokemons.value.add(_pokemons[index].name);
                return const Icon(
                  Icons.error,
                  color: Colors.white,
                );
              },
              imageBuilder:
                  (BuildContext context, ImageProvider imageProvider) =>
                      InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        alignment: Alignment.bottomCenter),
                  ),
                ),
                onTap: () => showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'barrierLabel',
                  pageBuilder: (ctx, anim1, anim2) => PokemonDetailsCard(
                    name: _pokemons[index].name,
                    stats: _pokemons[index].stats,
                    image: imageProvider,
                  ),
                  transitionBuilder: (ctx, anim1, anim2, child) =>
                      BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2 * anim1.value,
                      sigmaY: 2 * anim1.value,
                    ),
                    child: FadeTransition(
                      child: child,
                      opacity: anim1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
