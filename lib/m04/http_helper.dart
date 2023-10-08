import 'dart:io';

import 'package:http/http.dart' as http;

class HttpHelper {
  final String _urlBase = 'https://api.themoviedb.org';
  final String _urlKey = '1abb3e68d878be1155d781ce812f80a8';

  Future<String> getMovie(String filter) async {
    String popularMoviesUrl = '$_urlBase/3/movie/$filter?api_key=$_urlKey';
    print(popularMoviesUrl);

    var url = Uri.parse(popularMoviesUrl);
    http.Response result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    return result.statusCode.toString();
  }
}
