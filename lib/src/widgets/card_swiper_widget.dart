import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  CardSwiper({ @required this.movies});

  @override
  Widget build(BuildContext context) {

    // Manejamos el tamaño del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7, //double.infinity, // Usa todo el ancho posible
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context,int index){

            movies[index].uniqueId = '${movies[index].id}-card';
            return Hero(
                      tag: movies[index].uniqueId,
                      child: ClipRRect( // Administra el border radius
                      borderRadius: BorderRadius.circular(20.0),
                      child: GestureDetector(
                                  child: FadeInImage(
                                    image: NetworkImage(movies[index].getPosterImage()),
                                    placeholder: AssetImage('assets/img/no-image.jpg'),
                                    fit: BoxFit.cover,
                                    ),
                                  onTap: () {
                                    Navigator.pushNamed(context, 'detail', arguments: movies[index]);
                                  },
                      )
              ),
            );
          },
          itemCount: movies.length,
          // pagination: new SwiperPagination(),
          // control: new SwiperControl(),
        ),
   );
  }
}