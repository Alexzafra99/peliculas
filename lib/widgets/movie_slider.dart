import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key, required this.movies, this.title, required this.onNextPage
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
   
    super.initState();
  
    scrollController.addListener(() {
      
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        
       widget.onNextPage();
      }
      
    });
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if(this.widget.movies.length == 0){
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if(this.widget.title == null){

      return Container(
        width: double.infinity,
        height: 260,
      );
    }

    return Container(
      width: double.infinity,
      height: 215,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(this.widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ),
          
          SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index)=> _MoviePoster(movie: widget.movies[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;

  const _MoviePoster({
    Key? key, required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 210,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "details", arguments: "movie-instance"),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage("assets/no-image.jpg"), 
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 5), 

          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}