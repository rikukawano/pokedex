import 'dart:io';
import 'package:http/http.dart' as http;

class PokemonApiClient {
  final String _baseUrl = "https://pokeapi.co/api/v2/pokemon/";

  // GET request
  Future<dynamic> get(int pokemonId) async {
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + pokemonId.toString()));
      return _parseResponse(response.statusCode, response.body);
    } on SocketException {
      throw Exception("No Internet Connection");
    }
  }

  String _parseResponse(int httpStatus, String responseBody) {
    switch (httpStatus) {
      case 200:
      case 201:
        return responseBody;
      case 400:
        throw Exception('400 Bad Request');
      case 401:
        throw Exception('401 Unauthorized');
      case 403:
        throw Exception('403 Forbidden');
      case 404:
        throw Exception('404 Not Found');
      case 405:
        throw Exception('405 Method Not Allowed');
      case 500:
        throw Exception('500 Internal Server Error');
      default:
        throw Exception('Http status $httpStatus unknown error.');
    }
  }
}
