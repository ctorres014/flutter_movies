import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movie_provider.dart';

class DataSearch extends SearchDelegate{

  final movieProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del AppBar
    return 
      IconButton(
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
    // Crea los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(''),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Las sugerencias que aparecen cuando la persona escribe
     if ( query.isEmpty ) {
      return Container();
    }

     return FutureBuilder(
      future: movieProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

          if( snapshot.hasData ) {
            
            final movies = snapshot.data;

            return ListView(
              children: movies.map( (movie) {
                  return ListTile(
                    leading: FadeInImage(
                      image: NetworkImage( movie.getPosterImage() ),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text( movie.title ),
                    subtitle: Text( movie.originalTitle ),
                    onTap: (){
                      close( context, null);
                      movie.uniqueId = '';
                      Navigator.pushNamed(context, 'detail', arguments: movie);
                    },
                  );
              }).toList()
            );

          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }

      },
    );


  }
  
}