// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:movie/helper/dbHelper.dart';
import 'package:movie/model/movieDetailModel.dart';
import 'package:movie/services/movieApi.dart';
import 'package:animated_flip_card/animated_flip_card.dart';

class DetailScreen extends StatefulWidget {
  final String imdbId;

  const DetailScreen({required this.imdbId, Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetail> movieDetail;
  final dbHelper = MovieDatabaseHelper();
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    final snackBarText =
        isLiked ? "Film favorilerinize eklendi" : "Film favorilerinizden kaldırıldı";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarText),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    movieDetail = ServiceApi().detailMovies(widget.imdbId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[300],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: toggleLike,
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
          )
        ],
        backgroundColor: Colors.amber[400],
        title: const Padding(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            'Detay Sayfası',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder<MovieDetail>(
        future: movieDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Veriler alınamıyor: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Veri bulunamadı.'));
          } else {
            final movieDetail = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: AnimatedFlipCard(
                      front: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/32/32041.png",
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                      back: Image.network(
                        "${movieDetail.poster}",
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const CustomSizedBox(),
                Text('IMDB ID: ${movieDetail.imdbID}', style: CustomTextStyle()),
                const CustomSizedBox(),
                Text("Yönetmen : ${movieDetail.director}",
                    style: CustomTextStyle()),
                const CustomSizedBox(),
                Text("Oyuncular : ${movieDetail.actors}",
                    style: CustomTextStyle()),
                const CustomSizedBox(),
                Text("Ülke : ${movieDetail.country}",
                    style: CustomTextStyle()),
                const CustomSizedBox(),
                Text("Puan : ${movieDetail.imdbRating}",
                    style: CustomTextStyle()),
                const CustomSizedBox(),
                Text("Dil : ${movieDetail.language}",
                    style: CustomTextStyle()),
                const CustomSizedBox(),
                Text("Süre : ${movieDetail.runtime}",
                    style: CustomTextStyle()),
              ],
            );
          }
        },
      ),
    );
  }

  TextStyle CustomTextStyle() => const TextStyle(color: Colors.black);
}

class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 10, height: 10);
  }
}
