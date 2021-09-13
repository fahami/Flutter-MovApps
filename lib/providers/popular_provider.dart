import 'package:flutter/material.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/constants/state.dart';
import 'package:movapps/models/results.dart';

class PopularProvider extends ChangeNotifier {
  late ApiServices apiServices;
  int page = 1;
  PopularProvider({required this.apiServices, required this.page}) {
    fetchPopular(page);
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late Results _popular;
  Results get result => _popular;

  Future<dynamic> fetchPopular(int page) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _message = "Sedang memuat...";
      final results = await apiServices.getPopular(page);
      if (results.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Film populer tidak ditemukan sama sekali';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _popular = results;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Sistem error, mohon coba lagi lain waktu';
    }
  }
}
