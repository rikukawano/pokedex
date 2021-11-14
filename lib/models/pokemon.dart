import 'dart:convert';

class Pokemon {
  final int id;
  final String name;
  // final Sprites sprites;
  final List<Stat> stats;
  final List<Type> types;

  Pokemon({
    required this.id,
    required this.name,
    // required this.sprites,
    required this.stats,
    required this.types,
  });

  static String _formatName(String name) {
    if (name.contains('nidoran') || name == 'mime-jr') {
      return name.replaceFirst(RegExp('-'), '_');
    } else if (name.contains('mr')) {
      return name.replaceFirst(RegExp('-'), '.');
    } else if (name.contains('tapu') || name.contains('type')) {
      return name.replaceFirst(RegExp('-'), '');
    } else if (name.contains('-') &&
        !(name == 'kommo-o' ||
            name == 'jangmo-o' ||
            name == 'hakamo-o' ||
            name == 'ho-oh')) {
      return name.split('-')[0];
    } else {
      return name;
    }
  }

  static Pokemon fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'].toInt(),
      name: _formatName(map['name']),
      // sprites: Sprites.fromMap(map['sprites']),
      stats: List<Stat>.from(map['stats'].map((x) => Stat.fromMap(x))),
      types: List<Type>.from(map['types']?.map((x) => Type.fromMap(x))),
    );
  }

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source));
}

// class Sprites {
//   final String frontDefault;

//   Sprites({
//     required this.frontDefault,
//   });

//   factory Sprites.fromMap(Map<String, dynamic> map) {
//     return Sprites(
//       frontDefault: map['front_default'],
//     );
//   }

//   factory Sprites.fromJson(String source) =>
//       Sprites.fromMap(json.decode(source));
// }

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
