import 'dart:convert';

class Pokemon {
  final int id;
  final String name;
  final Sprites sprites;
  final List<StatItem> stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.sprites,
    required this.stats,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'].toInt(),
      name: map['name'],
      sprites: Sprites.fromMap(map['sprites']),
    );
  }

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source));
}

class Sprites {
  final String frontDefault;

  Sprites({
    required this.frontDefault,
  });

  factory Sprites.fromMap(Map<String, dynamic> map) {
    return Sprites(
      frontDefault: map['front_default'],
    );
  }

  factory Sprites.fromJson(String source) =>
      Sprites.fromMap(json.decode(source));
}

class StatItem {
  final int baseStat;
  final int effort;
  final Stat stat;
  StatItem({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory StatItem.fromMap(Map<String, dynamic> map) {
    return StatItem(
      baseStat: map['base_stat']?.toInt(),
      effort: map['effort']?.toInt(),
      stat: Stat.fromMap(map['stat']),
    );
  }

  factory StatItem.fromJson(String source) =>
      StatItem.fromMap(json.decode(source));
}

class Stat {
  final String name;
  final String url;
  Stat({
    required this.name,
    required this.url,
  });

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      name: map['name'],
      url: map['url'],
    );
  }

  factory Stat.fromJson(String source) => Stat.fromMap(json.decode(source));
}
