import 'package:dio/dio.dart';

import '../models/movie.dart';
import '../utils/constants.dart';
import 'watch_list_service.dart';

class TheMovieDBService {
  static final Dio dio = Dio();
  final WatchListService watchListService = WatchListService();

  Future<Response> popularMovies() async {
    dio.options.baseUrl = Constants.popularMoviesUrl;
    try {
      Response response = await dio.get('');
      return response;
    } catch (e) {
      print(e.response);
      return e.response;
    }
  }

  Future<Response> search(String search) async {
    dio.options.baseUrl = Constants.searchMovieUrl;
    try {
      Response response = await dio.get(search);
      return response;
    } catch (e) {
      print(e.response);
      return e.response;
    }
  }

  Future<List<Response>> suggestedMovies() async {
    List<Response> responses = [];
    List<Movie> movies = await watchListService.loadWatchList();
    for (Movie movie in movies) {
      dio.options.baseUrl = Constants.suggestedMoviesUrl
          .replaceFirst('{movie_id}', '${movie.id}');
      try {
        responses.add(await dio.get(''));
      } catch (e) {
        print(e.response);
        return e.response;
      }
    }
    return responses;
  }
}
