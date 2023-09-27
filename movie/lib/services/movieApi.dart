import 'dart:convert';

import 'package:movie/constants/constants.dart';
import 'package:movie/model/movieDetailModel.dart';

import '../model/movieModel.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  Future<List<Movie>> searchMovies(String searchTerm) async {  // search request
    final uri = Uri.parse("${Constants.BASE_URL}?apikey=${Constants.API_KEY}&s=$searchTerm");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey("Search") && result["Search"] is List) {
        Iterable list = result["Search"];
        return list.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        // gelmezse bos dondur
        return [];
      }
    } else {
      throw Exception("HATA");
    }
  }

  Future<List<Movie>> getSpiderman() async {  // static request
    final uri = Uri.parse("${Constants.BASE_URL}?apikey=${Constants.API_KEY}&s=${Constants.GODFATHER_REQUEST}");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey("Search") && result["Search"] is List) {
        Iterable list = result["Search"];
        return list.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        
        return [];
      }
    } else {
      throw Exception("Failed to load movies!");
    }
  }

  Future<List<Movie>> getAvengers() async {  //static request
    final uri = Uri.parse("${Constants.BASE_URL}?apikey=${Constants.API_KEY}&s=${Constants.AVENGERS_REQUEST}");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey("Search") && result["Search"] is List) {
        Iterable list = result["Search"];
        return list.map((movie) => Movie.fromJson(movie)).toList();
      } else {
       
        return [];
      }
    } else {
      throw Exception("HATA");
    }
  }

  Future<List<Movie>> getBatman() async { //static request
    final uri = Uri.parse("${Constants.BASE_URL}?apikey=${Constants.API_KEY}&s=${Constants.BATMAN_REQUEST}");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result.containsKey("Search") && result["Search"] is List) {
        Iterable list = result["Search"];
        return list.map((movie) => Movie.fromJson(movie)).toList();
      } else {
     
        return [];
      }
    } else {
      throw Exception("HATA");
    }
  }
 
 Future<MovieDetail> detailMovies(String click) async { // detail request
  final uri = Uri.parse("${Constants.BASE_URL}?apikey=${Constants.API_KEY}&i=$click");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    print("API Yanıtı: $result"); // API yanıtını loglama
    if (result.containsKey("Title")) {
      return MovieDetail.fromJson(result);
    } else {
      return MovieDetail();
    }
  } else {
    print("API Hatası: ${response.statusCode} - ${response.reasonPhrase}"); // API hatasını loglama
    throw Exception("HATA");
  }
}


}
