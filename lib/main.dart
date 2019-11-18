import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/home_page.dart';
import 'package:peliculas_app/src/pages/pelicula_detalle_page.dart';
import 'package:peliculas_app/src/pages/trailer_page.dart';
import 'package:peliculas_app/src/pages/video_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Películas",
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => HomePage(),
        "detalle": (BuildContext context) => PeliculaDetalle(),
        "trailer": (BuildContext context) => TrailersPage(),
        "video": (BuildContext context) => VideoPage()
      },
    );
  }
}
