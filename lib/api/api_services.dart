import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movapps/models/details.dart';
import 'package:movapps/models/results.dart';
import 'package:movapps/models/trailer.dart';

class ApiServices {
  static final String _base = "https://api.themoviedb.org/3/movie/";
  static final String _apiKey = "?api_key=e1d8626fca32945f124ea2720d0cf5c0";
  static final String _lang = "&language=en-US";
  static final String _auth = "$_apiKey$_lang";
  static final String _popular = _base + "popular" + _auth;
  static final String _nowPlay = _base + "now_playing" + _auth;
  static final String _topRated = _base + "top_rated" + _auth;
  static final String _upComing = _base + "upcoming" + _auth;
  static final String _search =
      "https://api.themoviedb.org/3/search/movie$_apiKey";

  Future<Results> getNowPlaying(int page) async {
    final req = await http.get(Uri.parse(_nowPlay + '&page=$page'));
    return req.statusCode == 200
        ? Results.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon now playing');
  }

  Future<Results> getTopRated(int page) async {
    final req = await http.get(Uri.parse(_topRated + '&page=$page'));
    return req.statusCode == 200
        ? Results.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon top rated');
  }

  Future<Results> getPopular(int page) async {
    final req = await http.get(Uri.parse(_popular + '&page=$page'));
    return req.statusCode == 200
        ? Results.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon');
  }

  Future<Results> getUpcoming(int page) async {
    final response = await http.get(Uri.parse(_upComing + '&page=$page'));
    return response.statusCode == 200
        ? Results.fromJson(jsonDecode(response.body))
        : throw Exception('API tidak merespon upcoming');
  }

  Future<Details> getDetails(int id) async {
    final req = await http.get(Uri.parse(_base + '$id' + _auth));
    return req.statusCode == 200
        ? Details.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon detail film');
  }

  Future<Trailer> getTrailer(int id) async {
    final req = await http.get(Uri.parse(_base + '$id/videos' + _auth));
    return req.statusCode == 200
        ? Trailer.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon detail film');
  }

  Future<Results> getSearch(String query, int page) async {
    final req = await http
        .get(Uri.parse(_search + '&query=$query' + _lang + '&page=$page'));
    return req.statusCode == 200
        ? Results.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon pencarian film');
  }
}
