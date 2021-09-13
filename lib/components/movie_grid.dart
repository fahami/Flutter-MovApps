import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:movapps/models/result.dart';

class MovieGrid extends StatelessWidget {
  final ScrollController scrollController;
  final bool isLoading;
  final int totalResults;
  final List<Result> movies;
  const MovieGrid(
      {Key? key,
      required this.scrollController,
      required this.movies,
      required this.isLoading,
      required this.totalResults})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      itemCount: movies.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final Result datas = movies[index];
        if (index == movies.length - 1) {
          return new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Center(
              child: new Opacity(
                opacity: isLoading ? 1.0 : 00,
                child: new CircularProgressIndicator(),
              ),
            ),
          );
        } else if (index == totalResults) {
          return new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Center(
              child: new Opacity(
                opacity: isLoading ? 1.0 : 00,
                child: new Text('Semua hasil sudah ditampilkan'),
              ),
            ),
          );
        } else {
          return InkWell(
            onTap: () => Get.toNamed('/detail', arguments: datas),
            child: Container(
              margin: EdgeInsets.all(6),
              child: GridTile(
                header: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      color: Colors.amber,
                      child: Text(
                        datas.voteAverage.toString(),
                      ),
                    ),
                  ],
                ),
                footer: Container(
                    padding: EdgeInsets.all(6),
                    color: Colors.blue,
                    child: Text(
                      datas.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                child: datas.posterPath == null
                    ? Icon(Icons.movie)
                    : Image.network(
                        'https://image.tmdb.org/t/p/w200' + datas.posterPath!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
              ),
            ),
          );
        }
      },
    );
  }
}
