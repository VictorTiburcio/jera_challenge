import 'package:dio/dio.dart';

import '../utils/constants.dart';

class TheMovieDBService {
  static final Dio dio = Dio();

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
}
