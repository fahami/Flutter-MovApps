import 'package:flutter/material.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/constants/state.dart';
import 'package:movapps/models/results.dart';

class UpcomingProvider extends ChangeNotifier {
  late ApiServices apiServices;
  int page = 1;
  UpcomingProvider({required this.apiServices, required this.page}) {
    fetchUpcoming(page);
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late Results _upcomingResults;
  Results get result => _upcomingResults;

  Future<dynamic> fetchUpcoming(int page) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _message = "Sedang memuat...";
      final results = await apiServices.getUpcoming(page);
      if (results.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Upcoming Movie tidak ditemukan sama sekali';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _upcomingResults = results;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Sistem error, mohon coba lagi lain waktu';
    }
  }
}
