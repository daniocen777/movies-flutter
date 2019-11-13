import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apiKey = "f34dd916baf982a8cc7269a92eb4570d";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    List<Pelicula> peliculas = new List();
    decodeData["results"].forEach((c) {
      final temporal = Pelicula.fromJson(c);
      peliculas.add(temporal);
    });

    return peliculas;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {"api_key": _apiKey, "language": _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(
        _url, "3/movie/popular", {"api_key": _apiKey, "language": _language});

    return await _procesarRespuesta(url);
  }
}
