import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey='3af49382815e62ab34fe8d9c4604daa7';
  String _baseUrl='api.themoviedb.org';
  String _language='es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider(){
    print("MoviesProvider inicializado");

    this.getOnNowPlayingMovies();
    this.getPopularMovies();
  }

  getOnNowPlayingMovies() async{
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    
    //print(nowPlayingResponse.results[0].title);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners(); 
  }

  getPopularMovies() async{

    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    popularMovies = [...popularMovies, ...popularResponse.results]; //Refresca las peliculas pero mantiene las anteriores
    
    //sprint(popularMovies[0]);

    notifyListeners();   
  }
}