import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/m05/movie.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String _urlBase = 'https://api.themoviedb.org';
  final String _urlKey = '1abb3e68d878be1155d781ce812f80a8';

  Future<List?> getMovie(String filter) async {
    String popularMoviesUrl = '$_urlBase/3/movie/$filter?api_key=$_urlKey';
    print(popularMoviesUrl);

    var url = Uri.parse(popularMoviesUrl);
    http.Response result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      var responseBody = json.decode(result.body);
      var moviesMap = responseBody['results'];
      List movies = moviesMap.map((e) => Movie.fromJson(e)).toList();
      return movies;
    }
    return null;
  }
}
