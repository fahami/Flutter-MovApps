import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movapps/models/now_playing.dart';
import 'api_test.dart';
import 'parsing_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('API Test', () {
    late MockClient client;
    final _base = "https://api.themoviedb.org/3/movie/";
    final _apiKey = "e1d8626fca32945f124ea2720d0cf5c0";
    final _lang = "id-ID";
    final _idMovie = "588228";
    final _auth = "?api_key=$_apiKey&language=$_lang";
    final _popular = _base + "popular" + _auth;
    final _nowPlay = _base + "now_playing" + _auth;
    final _topRated = _base + "top_rated" + _auth;
    final _upComing = _base + "upcoming" + _auth;
    setUp(() {
      client = MockClient();
    });
    test('Parsing Now Playing', () async {
      when(client.get(Uri.parse(_nowPlay)))
          .thenAnswer((_) async => http.Response('''
          {
            "dates": {
                "maximum": "2021-09-06",
                "minimum": "2021-07-20"
            },
            "page": 1,
            "results": [
                {
                    "adult": false,
                    "backdrop_path": "/yizL4cEKsVvl17Wc1mGEIrQtM2F.jpg",
                    "genre_ids": [
                        28,
                        878,
                        12
                    ],
                    "id": 588228,
                    "original_language": "en",
                    "original_title": "The Tomorrow War",
                    "overview": "",
                    "popularity": 3368.737,
                    "poster_path": "/34nDCQZwaEvsy4CFO5hkGRFDCVU.jpg",
                    "release_date": "2021-09-03",
                    "title": "The Tomorrow War",
                    "video": false,
                    "vote_average": 7.8,
                    "vote_count": 271
                }
            ],
            "total_pages": 60,
            "total_results": 1192
          }
          ''', 200));
      // getNowPlaying(client)
      expect(await getNowPlaying(client), isA<NowPlaying>());
    });
  });
}
