import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey='3af49382815e62ab34fe8d9c4604daa7';
  String _baseUrl='api.themoviedb.org';
  String _language='es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider(){
    print("MoviesProvider inicializado");

    this.getOnNowPlayingMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page=1]) async{

    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    return response.body;
  }

  getOnNowPlayingMovies() async{
    
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    //print(nowPlayingResponse.results[0].title);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners(); 
  }

  getPopularMovies() async{

    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results]; //Refresca las peliculas pero mantiene las anteriores
    //print(popularMovies[0]);
    notifyListeners();   
  }
}