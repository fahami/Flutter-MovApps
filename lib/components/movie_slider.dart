import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:movapps/models/result.dart';

class MovieSlider extends StatelessWidget {
  final List<Result> result;

  const MovieSlider({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: result.length,
      itemBuilder: (context, index) {
        final Result datas = result[index];
        return InkWell(
          onTap: () => Get.toNamed('/detail', arguments: datas),
          child: Container(
            width: 150,
            child: Card(
              child: Wrap(
                children: [
                  datas.posterPath == null
                      ? Icon(Icons.movie)
                      : CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w200' +
                              datas.posterPath!,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, loadingProgress) {
                            return Center(
                              child: LinearProgressIndicator(
                                value: loadingProgress.totalSize != null
                                    ? loadingProgress.downloaded /
                                        loadingProgress.totalSize!
                                    : null,
                              ),
                            );
                          },
                        ),
                  ListTile(
                    title: Text(
                      datas.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(Jiffy(datas.releaseDate).yMMMd),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
