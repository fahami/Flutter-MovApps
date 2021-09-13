import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/constants/state.dart';
import 'package:movapps/constants/text_style.dart';
import 'package:movapps/models/result.dart';
import 'package:movapps/providers/detail_provider.dart';
import 'package:movapps/providers/trailer_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Result dataMovies = Get.arguments;
  var currency = NumberFormat.compactSimpleCurrency(locale: "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => DetailProvider(
                    apiServices: ApiServices(),
                    idMovies: dataMovies.id,
                  )),
          ChangeNotifierProvider(
            create: (_) => TrailerProvider(
              apiServices: ApiServices(),
              idMovies: dataMovies.id,
            ),
          )
        ],
        child: Consumer<DetailProvider>(
          builder: (context, detail, child) {
            if (detail.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (detail.state == ResultState.NoData) {
              return Center(
                child: Text(detail.message),
              );
            } else if (detail.state == ResultState.HasData) {
              return Stack(
                children: [
                  dataMovies.posterPath == null
                      ? Container()
                      : SizedBox.expand(
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/' +
                                dataMovies.posterPath!,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Text(
                            dataMovies.title,
                            style: heroText,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Consumer<TrailerProvider>(
                            builder: (context, trailer, child) {
                              if (trailer.state == ResultState.HasData) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Wrap(
                                      children: [
                                        Text(
                                          'Trailer',
                                          style: titleCard,
                                        ),
                                        SizedBox(
                                          height: 32,
                                        ),
                                        YoutubePlayerIFrame(
                                          controller: YoutubePlayerController(
                                            initialVideoId:
                                                trailer.trailer.results[0].key,
                                            params: YoutubePlayerParams(
                                              showControls: true,
                                              showFullscreenButton: true,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else if (trailer.state == ResultState.Error) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return Text('');
                              }
                            },
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton.icon(
                                          onPressed: null,
                                          icon: Icon(Icons.calendar_today),
                                          label: Text(
                                              Jiffy(dataMovies.releaseDate)
                                                  .yMMMd),
                                        ),
                                        TextButton.icon(
                                          onPressed: null,
                                          icon: Icon(Icons.paid),
                                          label: Text(
                                              detail.result.budget == 0
                                                  ? "Not Specified"
                                                  : currency.format(
                                                      detail.result.budget),
                                              overflow: TextOverflow.ellipsis),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton.icon(
                                            onPressed: null,
                                            icon: Icon(Icons.timer),
                                            label: Text(
                                                detail.result.runtime == 0
                                                    ? "Not Specified"
                                                    : detail.result.runtime
                                                            .toString() +
                                                        ' minutes')),
                                        TextButton.icon(
                                            onPressed: null,
                                            icon: Icon(Icons.star),
                                            label: Text(dataMovies.voteAverage
                                                .toString()))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          detail.result.overview == ''
                              ? Text('')
                              : Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Wrap(
                                      children: [
                                        Text(
                                          'Overview',
                                          style: titleCard,
                                        ),
                                        SizedBox(
                                          height: 32,
                                        ),
                                        Text(
                                          detail.result.overview,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (detail.state == ResultState.Error) {
              return Center(
                child: Text(detail.message),
              );
            } else {
              return Text('');
            }
          },
        ),
      ),
    );
  }
}
