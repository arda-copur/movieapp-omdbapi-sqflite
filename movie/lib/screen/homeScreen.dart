// ignore_for_file: prefer_final_fields, unused_import, avoid_unnecessary_containers, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:movie/constants/constants.dart';
import 'package:movie/model/movieDetailModel.dart';
import 'package:movie/model/movieModel.dart';
import 'package:movie/screen/listScreen.dart';
import 'package:movie/services/movieApi.dart';
import 'package:movie/widgets/trendingWidget.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../helper/dbHelper.dart';
import '../widgets/moviesWidget.dart';
import '../widgets/sliderWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {  

  List<Movie> searchMovie = <Movie>[];
  


  late Future<List<Movie>> spidermanFilmler;
  late Future<List<Movie>> batmanFilmler;
  late Future<List<Movie>> avengersFilmler;
  TextEditingController _searchController = TextEditingController();
  final dbHelper = MovieDatabaseHelper();
  ServiceApi service = ServiceApi();

  @override
  void initState() {
    super.initState();
    spidermanFilmler = service.getSpiderman();
    batmanFilmler = service.getBatman();
    avengersFilmler = service.getAvengers();
    dbHelper.deleteAllMovies();
    
  }

 Future<void> searchAllMovie(String searchTerm) async {
  try {
    final movies = await service.searchMovies(searchTerm);  
    
    setState(() {
      searchMovie = movies;
    });

    await dbHelper.deleteAllMovies();
    

    for (var movie in searchMovie) {
      await dbHelper.insertMovie(movie);
    
    }
     
    final updatedMovies = await dbHelper.getMovies();
        for (int i = 0; i < updatedMovies.length; i++) {
      print(updatedMovies[i].title! + "///////" + updatedMovies[i].year! + "////////" + updatedMovies[i].imdbId!);
    }
    //   for (var detail in updatedMovies) {
    //           final movies = await service.detailMovies(detail.imdbId);
    //           await dbHelper.insertMovieDetail(movies);
    // }
    //   final updatedMoviesDetail = await dbHelper.getMovieDetails();
    // for (int i = 0; i < updatedMoviesDetail.length; i++) {
    //   print(" SQFLITE TABLO  " + updatedMoviesDetail[i].title! + "///////" + updatedMoviesDetail[i].actors! + "////////" + updatedMoviesDetail[i].imdbID!);
    // }

  } catch (error) {
    print("Hata oluştu: $error");
  }
}

  void textChange(String text) {
    
  }

  void onEditingComplete() {
    // Textfield giriş durdurma
    final text = _searchController.text;
    if (text.isNotEmpty) {
      searchAllMovie(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies App",
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () {
        FocusScope.of(context).unfocus();
         },
        child: Scaffold(
          backgroundColor: Colors.black45,
          appBar: AppBar(
            actions: [
              ElevatedButton(onPressed: () {
               Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => const ListScreen()),
              );
              },
               style: ElevatedButton.styleFrom(
                minimumSize: const Size(50, 50),
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),),
               backgroundColor: Colors.white, // 
               elevation: 4, 
                ),           
               child:const Text(Constants.Ara,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
              ),
            ],
            backgroundColor: Colors.transparent,
            title: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 12.0, right: 12.0, top: 5.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        contentPadding: const EdgeInsets.all(12),
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                        prefixIcon: InkWell(
                          onTap: onEditingComplete, // arama tamamlanınca cagır
                          child: const Icon(Icons.search),
                        ),
                        hintText: Constants.FilmAra,
                        hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      onEditingComplete: onEditingComplete, // textfield giris bitince gel
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Constants.Title1,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      child: FutureBuilder(
                        future: spidermanFilmler,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return TrendingSlider(
                              snapshot: snapshot,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.green,)
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      Constants.Title2,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: FutureBuilder(
                        future: batmanFilmler,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return MoviesSlider(
                              snapshot: snapshot,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.green,)
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      Constants.Title3,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: FutureBuilder(
                        future: avengersFilmler,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return MoviesSlider(
                              snapshot: snapshot,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.green,)
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
