import 'dates.dart';
import 'result.dart';

class NowPlaying {
  Dates? dates;
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  NowPlaying({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory NowPlaying.fromJson(Map<String, dynamic> json) => NowPlaying(
        dates: json['dates'] == null
            ? null
            : Dates.fromJson(json['dates'] as Map<String, dynamic>),
        page: json['page'] as int?,
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages: json['total_pages'] as int?,
        totalResults: json['total_results'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'dates': dates?.toJson(),
        'page': page,
        'results': results?.map((e) => e.toJson()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}
