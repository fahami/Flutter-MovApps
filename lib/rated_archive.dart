import 'package:flutter/material.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/constants/state.dart';
import 'package:movapps/providers/trending_provider.dart';
import 'package:provider/provider.dart';

import 'components/movie_grid.dart';
import 'models/result.dart';

class RatedArchive extends StatefulWidget {
  @override
  _RatedArchiveState createState() => _RatedArchiveState();
}

class _RatedArchiveState extends State<RatedArchive> {
  ScrollController _scrollController = new ScrollController();
  List<Result> bunchMovies = [];
  bool isLoading = false;
  int currentPage = 1;
  void _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    var response = await ApiServices().getTopRated(currentPage);
    currentPage++;
    List<Result> tempList = [];
    for (var i = 0; i < response.results.length; i++) {
      tempList.add(response.results[i]);
    }
    setState(() {
      isLoading = false;
      bunchMovies.addAll(tempList);
    });
  }

  @override
  void initState() {
    super.initState();
    _getMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => TopRatedProvider(apiServices: ApiServices(), page: 1),
        child: Container(
          child: Consumer<TopRatedProvider>(
            builder: (context, topRated, child) {
              if (topRated.state == ResultState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (topRated.state == ResultState.NoData) {
                return Center(
                  child: Text(topRated.message),
                );
              } else if (topRated.state == ResultState.HasData) {
                return MovieGrid(
                  movies: bunchMovies,
                  scrollController: _scrollController,
                  isLoading: isLoading,
                  totalResults: topRated.result.totalResults,
                );
              } else if (topRated.state == ResultState.Error) {
                return Center(
                  child: Text(topRated.message),
                );
              } else {
                return Text('');
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
