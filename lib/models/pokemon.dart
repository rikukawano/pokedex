import 'dart:convert';

class Pokemon {
  final int id;
  final String name;
  final Sprites sprites;
  final List<Type> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.sprites,
    required this.types,
  });

  Pokemon copyWith({
    int? id,
    String? name,
    Sprites? sprites,
    List<Type>? types,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      sprites: sprites ?? this.sprites,
      types: types ?? this.types,
    );
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id']?.toInt(),
      name: map['name'],
      sprites: Sprites.fromMap(map['sprites']),
      types: List<Type>.from(map['types']?.map((x) => Type.fromMap(x))),
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

  Sprites copyWith({
    String? frontDefault,
  }) {
    return Sprites(
      frontDefault: frontDefault ?? this.frontDefault,
    );
  }

  factory Sprites.fromMap(Map<String, dynamic> map) {
    return Sprites(
      frontDefault: map['front_default'],
    );
  }

  factory Sprites.fromJson(String source) =>
      Sprites.fromMap(json.decode(source));
}

class Types {
  final Type type;
  Types({
    required this.type,
  });

  Types copyWith({
    Type? type,
  }) {
    return Types(
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.toMap(),
    };
  }

  factory Types.fromMap(Map<String, dynamic> map) {
    return Types(
      type: Type.fromMap(map['type']),
    );
  }

  factory Types.fromJson(String source) => Types.fromMap(json.decode(source));
}

class Type {
  final String name;
  Type({
    required this.name,
  });

  Type copyWith({
    String? name,
  }) {
    return Type(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      name: map['name'],
    );
  }

  factory Type.fromJson(String source) => Type.fromMap(json.decode(source));
}
