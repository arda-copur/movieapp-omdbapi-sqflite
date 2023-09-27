// ignore_for_file: unnecessary_string_interpolations, unused_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie/constants/constants.dart';
import 'package:movie/model/movieModel.dart';
import 'package:movie/screen/detailScreen.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    Key? key,
    required this.snapshot, 
  }) : super(key: key);

  final AsyncSnapshot snapshot;
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 0.55,
            enlargeCenterPage: true,
            pageSnapping: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 1)),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return GestureDetector(
            onTap: () {
               Navigator.push(
                             context,
                            MaterialPageRoute(builder: (context) =>   DetailScreen( imdbId: snapshot.data[itemIndex].imdbId,)),
                          );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.network(
                  snapshot.data[itemIndex].poster!,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
