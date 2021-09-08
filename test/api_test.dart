import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movapps/models/details.dart';
import 'package:movapps/models/now_playing.dart';
import 'package:movapps/models/popular.dart';
import 'package:movapps/models/top_rated.dart';
import 'package:movapps/models/upcoming.dart';

final _base = "https://api.themoviedb.org/3/movie/";
final _apiKey = "e1d8626fca32945f124ea2720d0cf5c0";
final _lang = "id-ID";
final _auth = "?api_key=$_apiKey&language=$_lang";
final _popular = _base + "popular" + _auth;
final _nowPlay = _base + "now_playing" + _auth;
final _topRated = _base + "top_rated" + _auth;
final _upComing = _base + "upcoming" + _auth;

Future<NowPlaying?> getNowPlaying(http.Client client, {int page = 1}) async {
  final req = await client.get(Uri.parse(_nowPlay + '&page=$page)'));
  print(req.body);
  req.statusCode == 200
      ? NowPlaying.fromJson(json.decode(req.body))
      : throw Exception('API tidak merespon now playing');
}

Future<TopRated?> getTopRated(http.Client client, {int page = 1}) async {
  final req = await client.get(Uri.parse(_topRated + '&page=$page)'));
  req.statusCode == 200
      ? TopRated.fromJson(json.decode(req.body))
      : throw Exception('API tidak merespon top rated');
}

Future<Popular?> getPopular(http.Client client, {int page = 1}) async {
  final req = await client.get(Uri.parse(_popular + '&page=$page)'));
  return req.statusCode == 200
      ? Popular.fromJson(json.decode(req.body))
      : throw Exception('API tidak merespon');
}

Future<Upcoming?> getUpcoming(http.Client client, {int page = 1}) async {
  final req = await client.get(Uri.parse(_upComing + '&page=$page)'));
  req.statusCode == 200
      ? Upcoming.fromJson(json.decode(req.body))
      : throw Exception('API tidak merespon upcoming');
}

Future<Details?> getDetails(http.Client client, int id) async {
  final req = await client.get(Uri.parse(_base + '$id' + _auth));
  return req.statusCode == 200
      ? Details.fromJson(json.decode(req.body))
      : throw Exception('API tidak merespon detail film');
}
