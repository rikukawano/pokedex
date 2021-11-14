import 'package:flutter/material.dart';

import '/models/pokemon.dart';

class PokemonDetailsCard extends StatelessWidget {
  final String name;
  final List<Stat> stats;
  final ImageProvider<Object> image;

  const PokemonDetailsCard({
    required this.name,
    required this.stats,
    required this.image,
  });

  String _capitalize(String str) {
    // if (str == 'nidoran_m') {
    //   str.replaceFirst(RegExp('_f'), '♂');
    // } else if (str == 'nidoran-f') {
    //   str.replaceFirst(RegExp('_f'), '♀');
    // }
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        height: 550,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          border: Border.all(
            color: Color(0xE6FFFFFF),
            width: 5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _header(context),
            const SizedBox(height: 32),
            _pokemonImage(context),
            const SizedBox(height: 32),
            _statsList(context, stats),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _capitalize(name),
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'HP',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(width: 4),
            _barMeter(stats[0].baseStat),
            const SizedBox(width: 8),
            Text(
              '60/255',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ],
    );
  }

  Widget _barMeter(int statNum) => Flexible(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withOpacity(0.22)),
            ),
            FractionallySizedBox(
              widthFactor: statNum / 255,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF8DC48F),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _pokemonImage(BuildContext ctx) => Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              alignment: Alignment.center,
              scale: 0.7,
            ),
          ),
        ),
      );

  Widget _statsList(BuildContext ctx, List<Stat> stats) {
    final List<Widget> children = [];
    for (var i = 1; i < stats.length; i++) {
      children.add(_stat(ctx, stats[i].stat.name, stats[i].baseStat));
      if (i < stats.length - 1) children.add(const SizedBox(height: 12));
    }
    return Column(
      children: children,
    );
  }

  Widget _stat(BuildContext ctx, String title, int statNum) {
    // Shorten long stat titles like special-attack
    if (title.contains('special'))
      title = 'Sp.' + _capitalize(title.split('-')[1]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _capitalize(title),
          style: Theme.of(ctx).textTheme.bodyText2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _barMeter(statNum),
            const SizedBox(width: 8),
            Text(
              '$statNum/255',
              style: Theme.of(ctx).textTheme.caption,
            ),
          ],
        )
      ],
    );
  }
}
