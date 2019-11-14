import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/src/models/actores_model.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = "f34dd916baf982a8cc7269a92eb4570d";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";
  int _popularesPage = 0;
  bool _cargando = false;
  List<Pelicula> _populares = new List();
  // Streams
  // broadcast() ==> Varios escuchadores
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();
  // Para insertar y escuchar datos
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStram =>
      _popularesStreamController.stream;
  // Cerrar los streams
  void dispose() {
    _popularesStreamController?.close();
  }

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
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, "3/movie/popular", {
      "api_key": _apiKey,
      "language": _language,
      "page": _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;

    return resp;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, "3/movie/$movieId/credits",
        {"api_key": _apiKey, "language": _language});
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    List<Actor> actores = new List();

    decodeData["cast"].forEach((c) {
      final temporal = Actor.fromJson(c);
      actores.add(temporal);
      return actores;
    });

    return actores;
  }
}
