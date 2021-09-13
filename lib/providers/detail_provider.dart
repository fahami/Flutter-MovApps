import 'package:flutter/material.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/constants/state.dart';
import 'package:movapps/models/details.dart';

class DetailProvider extends ChangeNotifier {
  late ApiServices apiServices;
  late int idMovies;

  DetailProvider({required this.apiServices, required this.idMovies}) {
    fetchDetail(idMovies);
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late Details _details;
  Details get result => _details;

  Future<dynamic> fetchDetail(int idMovies) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _message = "Sedang memuat...";
      final results = await apiServices.getDetails(idMovies);
      if (results == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Detail movie tidak ditemukan sama sekali';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _details = results;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Pastikan anda terhubung dengan internet ya...';
    }
  }
}
