// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie/model/movieModel.dart';
import 'package:movie/helper/dbHelper.dart';
import 'package:movie/screen/detailScreen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final dbHelper = MovieDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Film Listesi'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: dbHelper.getMovies(), // dbden verileri getir
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Veriler alınamıyor: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('Veri bulunamadı.');
          } else {
            final movies = snapshot.data;
            return AnimationLimiter(
              child: ListView.builder(
                itemCount: movies!.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 800),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: ListTile(
                          title: Text(movie.title
                          ),
                          subtitle: Text("Imdb Id :  ${movie.imdbId} "),
                          leading: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            imdbId: movie.imdbId,
                                          )
                                          ),
                                );
                              },
                              child: Image.network(movie.poster)),
                          trailing: Text("Vizyon Yılı : ${movie.year}"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
