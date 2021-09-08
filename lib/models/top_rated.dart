import 'result.dart';

class TopRated {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  TopRated({this.page, this.results, this.totalPages, this.totalResults});

  factory TopRated.fromJson(Map<String, dynamic> json) => TopRated(
        page: json['page'] as int?,
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages: json['total_pages'] as int?,
        totalResults: json['total_results'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'results': results?.map((e) => e.toJson()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}
