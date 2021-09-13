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
                      : Image.network(
                          'https://image.tmdb.org/t/p/w200' + datas.posterPath!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: LinearProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
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
