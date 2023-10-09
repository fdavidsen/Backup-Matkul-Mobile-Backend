import 'dart:convert';
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

  Future<dynamic> getWeatherMedan() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=medan&appid=903507f17d707fecd352d38301efba77');
    http.Response result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      var responseBody = json.decode(result.body);
      var temp = responseBody['main']['temp'] - 273;
      print(temp);
      return temp;
    }
    return result.statusCode.toString();
  }
}
