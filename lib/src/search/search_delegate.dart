import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();
  String seleccion = "";
  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del appbar (ej. ícono para limpiar campo)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Ícono a la izquierda del appbar al presionar el ícono de búsqueda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Resultado
    return Center(
        child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.amberAccent,
            child: Text(seleccion)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapchot) {
        if (snapchot.hasData) {
          final peliculas = snapchot.data;
          return ListView(
            children: peliculas.map((p) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(p.getPosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(p.title),
                subtitle: Text(p.originalTitle),
                onTap: () {
                  close(context, null);
                  p.uniqueId = "";
                  Navigator.pushNamed(context, "detalle", arguments: p);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  /* @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias
    // Filtro
    final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (BuildContext context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      },
    );
  } */
}
