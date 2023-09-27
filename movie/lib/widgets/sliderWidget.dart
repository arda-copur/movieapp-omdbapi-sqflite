// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:movie/model/movieModel.dart';
import 'package:movie/screen/detailScreen.dart';

class MoviesSlider extends StatelessWidget {
  MoviesSlider({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                 Navigator.push(
                             context,
                            MaterialPageRoute(builder: (context) =>   DetailScreen( imdbId:snapshot.data[index].imdbId,)),
                          );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.network(snapshot.data[index].poster!),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
