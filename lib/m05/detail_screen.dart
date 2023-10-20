import 'package:flutter/material.dart';
import 'package:latihan_mobile_backend/m05/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    String path;

    if (movie.posterPath.isNotEmpty) {
      path = imgPath + movie.posterPath;
    } else {
      path = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   height: MediaQuery.of(context).size.height,
              //   child: Image.network(path),
              // ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(movie.overview),
              )
            ],
          ),
        ),
      ),
    );
  }
}
