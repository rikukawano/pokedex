import 'dart:convert';

class Pokemon {
  final int id;
  final String name;
  final Sprites sprites;

  Pokemon({
    required this.id,
    required this.name,
    required this.sprites,
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
