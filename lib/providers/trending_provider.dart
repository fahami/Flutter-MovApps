import 'package:flutter/material.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/constants/state.dart';
import 'package:movapps/models/results.dart';

class TopRatedProvider extends ChangeNotifier {
  late ApiServices apiServices;
  int? page = 1;

  TopRatedProvider({required this.apiServices, this.page}) {
    fetchTopRated(page ?? 1);
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late Results _topRated;
  Results get result => _topRated;

  Future<dynamic> fetchTopRated(int pages) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _message = "Sedang memuat...";
      final results = await apiServices.getTopRated(pages);
      if (results.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Upcoming Movie tidak ditemukan sama sekali';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _topRated = results;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Pastikan anda terhubung dengan internet ya...';
    }
  }
}
