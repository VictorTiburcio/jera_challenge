class Movie {
  int id;
  String title;
  String overview;
  String releaseDate;
  String voteAverage;
  String posterPath;
  bool watched;

  Movie(this.title, this.overview, this.releaseDate, this.voteAverage,
      this.posterPath,
      {this.watched = false});

  Movie.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    overview = map['overview'];
    releaseDate = map['release_date'];
    voteAverage = '${map['vote_average']}';
    posterPath = map['poster_path'];
    if (map['watched'] != null) {
      watched = map['watched'] == 1 ? true : false;
    } else {
      watched = false;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'title': title,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'poster_path': posterPath,
      'watched': watched == true ? 1 : 0,
    };

    return map;
  }
}
