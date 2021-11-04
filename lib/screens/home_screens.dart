import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context/*, listen:true*/);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: Text("Películas en cines"),
        elevation: 5,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),

            //Slider de peliculas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: "Populares",
            ),
          ],
        ),
      )
    );
  }
}