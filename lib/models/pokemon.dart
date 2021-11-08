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

class Stat {
  final int baseStat;
  final int effort;
  final StatItem stat;
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      baseStat: map['base_stat']?.toInt(),
      effort: map['effort']?.toInt(),
      stat: StatItem.fromMap(map['stat']),
    );
  }

  factory Stat.fromJson(String source) => Stat.fromMap(json.decode(source));
}

class StatItem {
  final String name;
  final String url;
  StatItem({
    required this.name,
    required this.url,
  });

  factory StatItem.fromMap(Map<String, dynamic> map) {
    return StatItem(
      name: map['name'],
      url: map['url'],
    );
  }

  factory StatItem.fromJson(String source) =>
      StatItem.fromMap(json.decode(source));
}

class Type {
  final int slot;
  final TypeItem type;
  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      slot: map['slot']?.toInt(),
      type: TypeItem.fromMap(map['type']),
    );
  }

  factory Type.fromJson(String source) => Type.fromMap(json.decode(source));
}

class TypeItem {
  final String name;
  final String url;
  TypeItem({
    required this.name,
    required this.url,
  });

  factory TypeItem.fromMap(Map<String, dynamic> map) {
    return TypeItem(
      name: map['name'],
      url: map['url'],
    );
  }

  factory TypeItem.fromJson(String source) =>
      TypeItem.fromMap(json.decode(source));
}
