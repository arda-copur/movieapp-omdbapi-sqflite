import 'package:movie/model/movieDetailModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/movieModel.dart';

class MovieDatabaseHelper {
  static final MovieDatabaseHelper _instance = MovieDatabaseHelper._privateConstructor();
  static Database? _database;

  MovieDatabaseHelper._privateConstructor();

  factory MovieDatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'movie_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE movies(
            imdb TEXT,
            title TEXT,
            poster TEXT,
            year TEXT
          )
        ''');
         db.execute('''
          CREATE TABLE movie_details(
            imdb TEXT PRIMARY KEY,
            title TEXT,
            year TEXT,
            rated TEXT,
            released TEXT,
            runtime TEXT,
            genre TEXT,
            director TEXT,
            writer TEXT,
            actors TEXT,
            plot TEXT,
            language TEXT,
            country TEXT,
            awards TEXT,
            poster TEXT,
            metascore TEXT,
            imdbRating TEXT,
            imdbVotes TEXT,
            type TEXT,
            dVD TEXT,
            boxOffice TEXT,
            production TEXT,
            website TEXT,
            response TEXT
          )
        ''');
      },
    );
  }

 

Future<void> insertMovie(Movie movie) async { // ekle
  final db = await database;
  await db.insert('movies', movie.toMap());
}

  Future<List<Movie>> getMovies() async {  // getir
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('movies');

    return List.generate(maps.length, (i) { //mapi cevir
      return Movie(
        imdbId: maps[i]['imdb'],
        title: maps[i]['title'],
        poster: maps[i]['poster'],
        year: maps[i]['year'],
      );
    });
  }

  Future<void> deleteAllMovies() async {
    final db = await database;
    await db.delete('movies');
  }
  

  Future<void> insertMovieDetail(MovieDetail movieDetail) async {
  final db = await database;
  await db.insert('movie_details', movieDetail.toJson());
}

Future<MovieDetail?> getMovieDetailByImdbId(String imdbId) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'movie_details',
    where: 'imdb = ?',
    whereArgs: [imdbId],
  );

  if (maps.isNotEmpty) {
    return MovieDetail.fromJson(maps.first);
  } else {
    return null;
  }
}


  
// Future<Database> _detailDatabase() async {
//     final path = join(await getDatabasesPath(), 'movie_detail_database.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           CREATE TABLE moviesdetail(
//             imdbID TEXT,
//             title TEXT,
//             year TEXT,
//             rated TEXT,
//             released TEXT,
//             runtime TEXT,
//             genre TEXT,
//             director TEXT,
//             writer TEXT,
//             actors TEXT,
//             plot TEXT,
//             language TEXT,
//             country TEXT,
//             awards TEXT,
//             poster TEXT,
//             metascore TEXT,
//             imdbRating TEXT,
//             imdbVotes TEXT,
//             type TEXT,
//             dVD TEXT,
//             boxOffice TEXT,
//             production TEXT,
//             website TEXT,
//             response TEXT
//           )
//         ''');
//       },
//     );
//   }

//   Future<void> insertMovieDetail(MovieDetail movieDetail) async {
//     final db = await _detailDatabase();
//     await db.insert('moviesdetail', movieDetail.toJson(),
//       );
//   }

//   Future<List<MovieDetail>> getMovieDetails() async {
//     final db = await _detailDatabase();
//     final List<Map<String, dynamic>> maps = await db.query('moviesdetail');

//     return List.generate(maps.length, (i) {
//       return MovieDetail.fromJson(maps[i]);
//     });
//   }

//   Future<void> deleteAllMovieDetails() async {
//     final db = await _detailDatabase();
//     await db.delete('moviesdetail');
//   }

}

