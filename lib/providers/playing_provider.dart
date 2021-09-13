import 'package:flutter/material.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/constants/state.dart';
import 'package:movapps/models/results.dart';

class PlayingProvider extends ChangeNotifier {
  late ApiServices apiServices;
  int? page = 1;

  PlayingProvider({required this.apiServices, required this.page}) {
    fetchPlaying();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late Results _nowPlaying;
  Results get result => _nowPlaying;

  Future<dynamic> fetchPlaying() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _message = "Sedang memuat...";
      final results = await apiServices.getNowPlaying(page ?? 1);
      if (results.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Upcoming Movie tidak ditemukan sama sekali';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _nowPlaying = results;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Pastikan anda terhubung dengan internet ya...';
    }
  }
}
