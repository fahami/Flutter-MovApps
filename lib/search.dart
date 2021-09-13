import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/components/movie_grid.dart';
import 'package:provider/provider.dart';

import 'constants/state.dart';
import 'models/result.dart';
import 'providers/search_provider.dart';

class SearchMovies extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search movies...';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = 'Indonesia',
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    int currentPage = 1;
    bool isLoading = false;
    List<Result> bunchMovies = [];
    List<Result> tempList = [];
    return ChangeNotifierProvider(
      create: (_) =>
          SearchProvider(apiService: ApiServices(), query: query, page: 1),
      child: Consumer<SearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(
              child: Container(child: Text(state.message)),
            );
          } else if (state.state == ResultState.HasData) {
            final List<Result> movies = state.searches.results;

            void _getMore() async {
              print("Sekarang halaman: $currentPage");
              if (!isLoading) {
                isLoading = true;
              }
              currentPage++;
              Provider.of<SearchProvider>(context, listen: false)
                  .fetchSearch(query, currentPage);
              var response =
                  Provider.of<SearchProvider>(context, listen: false).searches;
              currentPage++;

              for (var i = 0; i < response.results.length; i++) {
                tempList.add(response.results[i]);
                print(response.results[i].title);
              }

              isLoading = false;
              bunchMovies.addAll(tempList);
              print(bunchMovies.length);
            }

            // _getMore();
            ScrollController scrollController = new ScrollController();
            scrollController.addListener(() {
              if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent) {
                print('mentok');
                _getMore();
              }
            });
            return MovieGrid(
              scrollController: scrollController,
              movies: movies,
              isLoading: isLoading,
              totalResults: state.searches.totalResults,
            );
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Container(child: Text(state.message)),
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Container(child: Text(state.message)),
            );
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
