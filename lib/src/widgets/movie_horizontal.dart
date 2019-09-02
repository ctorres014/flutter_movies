import 'package:flutter/material.dart';

import 'package:peliculas/src/models/movie_model.dart';


class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({ @required this.movies,  @required this.nextPage });

  // Crear un listener para escuchar los cambios que sucedan en el PageView
  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });
    
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, i) {
          return _createCard(context, movies[i]);
        },
        // children: _cards(context)
      ),
    );


  }


  // List<Widget> _cards(context) {
  //   return movies.map( (movie) { // Mediante el Map recibimos una nueva instancia de la lista
     
  //   }).toList();
  // }

  Widget _createCard(BuildContext context, Movie movie) {

     movie.uniqueId = '${movie.id}-poster';

     final card = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                image: NetworkImage(movie.getPosterImage()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
              ),
            ),
            SizedBox(),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

}