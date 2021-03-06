// Generated by https://quicktype.io
class Movies {
    List<Movie> items = new List();

    Movies();

    Movies.fromJsonList(List<dynamic> jsonList) {
      if(jsonList == null) return;

      for(var item in jsonList) {
        // Mapeamos los datos vienen del API
        // con las propiedades de la clase movie
        final movie = new Movie.fromJsonMap(item);
        items.add(movie);
      }

    }
}

class Movie {
  String uniqueId;
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Movie({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });


  // fromJsonMap para cuando quiero generar una instancia de pelicula
  // que viene en un formato JSON
  Movie.fromJsonMap( Map<String, dynamic> json ) {
    voteCount         = json['vote_count'];
    id                = json['id'];
    video             = json['video'];
    voteAverage       = json['vote_average'] / 1; // Se realiza la division porque espera un double y puede que en algun caso devuelva un entero
    title             = json['title'];
    popularity        = json['popularity'] / 1;
    posterPath        = json['poster_path'];
    originalLanguage  = json['original_language'];
    originalTitle     = json['original_title'];
    genreIds          = json['genre_ids'].cast<int>(); // Realizamos el cast porque espera un entero
    backdropPath      = json['backdrop_path'];
    adult             = json['adult'];
    overview          = json['overview'];
    releaseDate       = json['release_date'];
  }


  getPosterImage() {
    if(posterPath == null) {
      return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeqNvfcaUYt6DeAJx2HZ4AkQfEuqAFkWcKJK5YIwHjWbfBcLkW';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

   getBackgroundImage() {
    if(backdropPath == null) {
      return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeqNvfcaUYt6DeAJx2HZ4AkQfEuqAFkWcKJK5YIwHjWbfBcLkW';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }

}

