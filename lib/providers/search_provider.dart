import 'package:flutter/material.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/constants/state.dart';
import 'package:movapps/models/results.dart';

class SearchProvider extends ChangeNotifier {
  late ApiServices apiService;

  SearchProvider({required this.apiService, required query, required page}) {
    fetchSearch(query, page);
  }
  late String query;
  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late Results _searches;
  Results get searches => _searches;

  Future<dynamic> fetchSearch(String query, int page) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _message = "Sedang memuat...";
      final search = await apiService.getSearch(query, page);
      if (search.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Film tidak ditemukan, gunakan kata kunci lainnya';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searches = search;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Sistem error, mohon coba lagi lain waktu';
    }
  }
}
