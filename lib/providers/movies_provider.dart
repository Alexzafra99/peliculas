import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey='3af49382815e62ab34fe8d9c4604daa7';
  String _baseUrl='api.themoviedb.org';
  String _language='es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
  int _nowPlayingPage = 0;

  MoviesProvider(){
    print("MoviesProvider inicializado");

    this.getOnNowPlayingMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page=1]) async{

    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    return response.body;
  }

  getOnNowPlayingMovies() async{
    
    _nowPlayingPage++;
    
    final jsonData = await this._getJsonData('3/movie/now_playing', _nowPlayingPage);
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    //print(nowPlayingResponse.results[0].title);

    onDisplayMovies = [...onDisplayMovies, ...nowPlayingResponse.results];
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

  Future<List<Cast>> getMoviesCast(int movieId) async{

    if(moviesCast.containsKey(movieId)){

      return moviesCast[movieId]!;
    }
    
    //print("pidiendo");

    final jsonData = await this._getJsonData('3/movie/$movieId/credits', _popularPage);
    final creditsResponse = CreditsResponse.fromJson(jsonData);
  
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async{

    final url = Uri.https(_baseUrl, "3/search/movie", {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);

    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

}