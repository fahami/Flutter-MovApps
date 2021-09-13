import 'package:flutter/material.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/constants/state.dart';
import 'package:movapps/models/trailer.dart';

class TrailerProvider extends ChangeNotifier {
  late ApiServices apiServices;
  late int idMovies;

  TrailerProvider({required this.apiServices, required this.idMovies}) {
    fetchTrailer(idMovies);
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late Trailer _trailer;
  Trailer get trailer => _trailer;

  Future<dynamic> fetchTrailer(int idMovies) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _message = "Sedang memuat...";
      final results = await apiServices.getTrailer(idMovies);
      if (results.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Trailer tidak ditemukan sama sekali';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _trailer = results;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Sistem error, mohon coba lagi lain waktu';
    }
  }
}
