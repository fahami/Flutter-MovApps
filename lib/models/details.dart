import 'belongs_to_collection.dart';
import 'genre.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'spoken_language.dart';

class Details {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Details({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        adult: json['adult'] as bool?,
        backdropPath: json['backdrop_path'] as String?,
        belongsToCollection: json['belongs_to_collection'] == null
            ? null
            : BelongsToCollection.fromJson(
                json['belongs_to_collection'] as Map<String, dynamic>),
        budget: json['budget'] as int?,
        genres: (json['genres'] as List<dynamic>?)
            ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
            .toList(),
        homepage: json['homepage'] as String?,
        id: json['id'] as int?,
        imdbId: json['imdb_id'] as String?,
        originalLanguage: json['original_language'] as String?,
        originalTitle: json['original_title'] as String?,
        overview: json['overview'] as String?,
        popularity: json['popularity'] as double?,
        posterPath: json['poster_path'] as String?,
        productionCompanies: (json['production_companies'] as List<dynamic>?)
            ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
            .toList(),
        productionCountries: (json['production_countries'] as List<dynamic>?)
            ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
            .toList(),
        releaseDate: json['release_date'] as String?,
        revenue: json['revenue'] as int?,
        runtime: json['runtime'] as int?,
        spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
            ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: json['status'] as String?,
        tagline: json['tagline'] as String?,
        title: json['title'] as String?,
        video: json['video'] as bool?,
        voteAverage: json['vote_average'] as double?,
        voteCount: json['vote_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'belongs_to_collection': belongsToCollection?.toJson(),
        'budget': budget,
        'genres': genres?.map((e) => e.toJson()).toList(),
        'homepage': homepage,
        'id': id,
        'imdb_id': imdbId,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'production_companies':
            productionCompanies?.map((e) => e.toJson()).toList(),
        'production_countries':
            productionCountries?.map((e) => e.toJson()).toList(),
        'release_date': releaseDate,
        'revenue': revenue,
        'runtime': runtime,
        'spoken_languages': spokenLanguages?.map((e) => e.toJson()).toList(),
        'status': status,
        'tagline': tagline,
        'title': title,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };
}
