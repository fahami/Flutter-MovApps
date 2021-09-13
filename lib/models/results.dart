import 'result.dart';

class Results {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  Results(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults});

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        page: json['page'] as int,
        results: (json['results'] as List<dynamic>)
            .map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages: json['total_pages'] as int,
        totalResults: json['total_results'] as int,
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'results': results.map((e) => e.toJson()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}
