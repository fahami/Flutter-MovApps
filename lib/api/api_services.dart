import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movapps/models/details.dart';
import 'package:movapps/models/now_playing.dart';
import 'package:movapps/models/popular.dart';
import 'package:movapps/models/top_rated.dart';
import 'package:movapps/models/upcoming.dart';

class ApiServices {
  static final _base = "https://api.themoviedb.org/3/movie/";
  static final _apiKey = "e1d8626fca32945f124ea2720d0cf5c0";
  static final _lang = "id-ID";
  static final _auth = "?api_key=$_apiKey&language=$_lang";
  static final _popular = _base + "popular" + _auth;
  static final _nowPlay = _base + "now_playing" + _auth;
  static final _topRated = _base + "top_rated" + _auth;
  static final _upComing = _base + "upcoming" + _auth;

  Future<NowPlaying?> getNowPlaying({int page = 1}) async {
    final req = await http.get(Uri.parse(_nowPlay + '&page=$page)'));
    req.statusCode == 200
        ? NowPlaying.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon now playing');
  }

  Future<TopRated?> getTopRated({int page = 1}) async {
    final req = await http.get(Uri.parse(_topRated + '&page=$page)'));
    req.statusCode == 200
        ? TopRated.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon top rated');
  }

  Future<Popular?> getPopular({int page = 1}) async {
    final req = await http.get(Uri.parse(_popular + '&page=$page)'));
    return req.statusCode == 200
        ? Popular.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon');
  }

  Future<Upcoming?> getUpcoming({int page = 1}) async {
    final req = await http.get(Uri.parse(_upComing + '&page=$page)'));
    req.statusCode == 200
        ? Upcoming.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon upcoming');
  }

  Future<Details?> getDetails(int id) async {
    final req = await http.get(Uri.parse(_base + '$id' + _auth));
    return req.statusCode == 200
        ? Details.fromJson(jsonDecode(req.body))
        : throw Exception('API tidak merespon detail film');
  }
}
