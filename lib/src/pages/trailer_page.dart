import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/models/video_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

class TrailersPage extends StatelessWidget {
  final PeliculasProvider peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    //final trailer = peliculasProvider.getVideos(pelicula.id.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text(pelicula.title),
        ),
        body: _body(context, pelicula));
  }

  Widget _body(BuildContext context, Pelicula pelicula) {
    return FutureBuilder(
        future: peliculasProvider.getVideos(pelicula.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
          if (snapshot.hasData) {
            final video = snapshot.data;
            return ListView(
              children: video.map((v) {
                return ListTile(
                  leading: Icon(Icons.movie),
                  title: Text(v.name),
                  subtitle: Text(v.type),
                  onTap: () {
                    Navigator.pushNamed(context, "video", arguments: v);
                  },
                );
              }).toList(),
            );
          } else {
            return Container(
                padding: EdgeInsets.only(top: 40.0),
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
