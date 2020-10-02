class Constants {
  static const String apiKey = '77cb354ace491c54370b95b201d4c770';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String language = 'en-US';
  static const String popularMoviesUrl =
      '$baseUrl/movie/popular?api_key=$apiKey&language=$language&include_adult=false';
  static const String imagesBaseUrl = 'https://image.tmdb.org/t/p';
  static const String lowQualityImageCode = 'w500';
  static const String lowQualityImageBaseUrl =
      '$imagesBaseUrl/$lowQualityImageCode';
  static const String searchMovieUrl =
      '$baseUrl/search/movie?api_key=$apiKey&language=$language&include_adult=false&query=';
  static const String suggestedMoviesUrl =
      '$baseUrl/movie/{movie_id}/similar?api_key=$apiKey&language=$language&include_adult=false';
}
