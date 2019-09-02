import 'package:flutter/material.dart';

import 'package:peliculas/src/providers/movie_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';



class HomePage extends StatelessWidget {
  final movieProvider = new MoviesProvider();


  @override
  Widget build(BuildContext context) {
    // Llamamos al API
    movieProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
                // query: 'Hola'
              );
            },
          )
        ],
      ),
      body: Column( 
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _swiperCards(),
          _footer(context)
        ],
      )
    );
  }

 Widget _swiperCards() {
   return FutureBuilder(
     future: movieProvider.getInCinemas(),
     builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
       if(snapshot.hasData) {
        return  CardSwiper( movies: snapshot.data );
       } else {
         return Container(
           child: Center(
             child: CircularProgressIndicator(),
           ),
         ); 
       }

     },
   );
 }


Widget  _footer(context) {
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text('Populares', style: Theme.of(context).textTheme.subhead,),
          padding: EdgeInsets.only(left: 20.0),
          ),
        SizedBox(height: 5.0,),
        StreamBuilder(
          stream: movieProvider.popularsStream,
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if(snapshot.hasData) {
              return MovieHorizontal( movies: snapshot.data, nextPage: movieProvider.getPopulars, );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    ),
  );
}


}