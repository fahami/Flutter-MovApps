import 'genre.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'spoken_language.dart';

class Details {
  bool adult;
  int budget;
  List<Genre> genres;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Details({
    required this.adult,
    required this.budget,
    required this.genres,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        adult: json['adult'] as bool,
        budget: json['budget'] as int,
        genres: (json['genres'] as List<dynamic>)
            .map((e) => Genre.fromJson(e as Map<String, dynamic>))
            .toList(),
        id: json['id'] as int,
        imdbId: json['imdb_id'] as String,
        originalLanguage: json['original_language'] as String,
        originalTitle: json['original_title'] as String,
        overview: json['overview'] as String,
        popularity: json['popularity'] as double,
        posterPath: json['poster_path'] as String,
        productionCompanies: (json['production_companies'] as List<dynamic>)
            .map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
            .toList(),
        productionCountries: (json['production_countries'] as List<dynamic>)
            .map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
            .toList(),
        releaseDate: json['release_date'] as String,
        revenue: json['revenue'] as int,
        runtime: json['runtime'] == null ? 0 : json['runtime'],
        spokenLanguages: (json['spoken_languages'] as List<dynamic>)
            .map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: json['status'] as String,
        tagline: json['tagline'] as String,
        title: json['title'] as String,
        video: json['video'] as bool,
        voteAverage: json['vote_average'] as double,
        voteCount: json['vote_count'] as int,
      );

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'budget': budget,
        'genres': genres.map((e) => e.toJson()).toList(),
        'id': id,
        'imdb_id': imdbId,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'production_companies':
            productionCompanies.map((e) => e.toJson()).toList(),
        'production_countries':
            productionCountries.map((e) => e.toJson()).toList(),
        'release_date': releaseDate,
        'revenue': revenue,
        'runtime': runtime,
        'spoken_languages': spokenLanguages.map((e) => e.toJson()).toList(),
        'status': status,
        'tagline': tagline,
        'title': title,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };
}
