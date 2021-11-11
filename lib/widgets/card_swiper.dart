import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class CardSwiper extends StatefulWidget {

  final List<Movie> movies;
  final Function onNextPage;

  const CardSwiper({
    Key? key, required this.movies, required this.onNextPage
  }) : super(key: key);

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {

/*   final SwiperController swiperController = new SwiperController();

  @override
  void initState() {
    
    super.initState();

    swiperController.addListener(() {
      
      print(swiperController.index);

      /* if(swiperController.index == widget.movies.length-4){

        widget.onNextPage();
      }
 */
    });
  } 

  @override
  void dispose() {
    
    super.dispose();
  } */

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

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: widget.movies.length,
        layout: SwiperLayout.STACK,
        //controller: swiperController,
        //autoplay: true,
        loop: false,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: ( _ , int index){

          final movie = widget.movies[index];
           
           /* print(index);
           print(widget.movies.length);
           print(widget.movies[index].title); */
          
          if(index == widget.movies.length-4){
            
            widget.onNextPage();
          }

          movie.heroId = "swiper-${movie.id}";

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, "details", arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage("assets/no-image.jpg"), 
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover
                ),
              ),
            ),
          );
        }
      )
    );
  }
}