import 'package:movapps/models/trailer_result.dart';

class Trailer {
  int id;
  List<TrailerResult> results;

  Trailer({required this.id, required this.results});

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
        id: json['id'] as int,
        results: (json['results'] as List<dynamic>)
            .map((e) => TrailerResult.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'results': results.map((e) => e.toJson()).toList(),
      };
}
