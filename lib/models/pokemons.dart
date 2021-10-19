import 'dart:convert';

class Pokemons {
  final int count;
  final String next;
  final List<PokemonResource> pokemonResource;

  Pokemons({
    required this.count,
    required this.next,
    required this.pokemonResource,
  });

  Pokemons copyWith({
    int? count,
    String? next,
    List<PokemonResource>? pokemonResource,
  }) {
    return Pokemons(
      count: count ?? this.count,
      next: next ?? this.next,
      pokemonResource: pokemonResource ?? this.pokemonResource,
    );
  }

  factory Pokemons.fromMap(Map<String, dynamic> map) {
    return Pokemons(
      count: map['count']?.toInt(),
      next: map['next'],
      pokemonResource: List<PokemonResource>.from(
          map['pokemonResource']?.map((x) => PokemonResource.fromMap(x))),
    );
  }

  factory Pokemons.fromJson(String source) =>
      Pokemons.fromMap(json.decode(source));
}

class PokemonResource {
  final String name;
  final String url;

  PokemonResource({
    required this.name,
    required this.url,
  });

  PokemonResource copyWith({
    String? name,
    String? url,
  }) {
    return PokemonResource(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory PokemonResource.fromMap(Map<String, dynamic> map) {
    return PokemonResource(
      name: map['name'],
      url: map['url'],
    );
  }

  factory PokemonResource.fromJson(String source) =>
      PokemonResource.fromMap(json.decode(source));
}
