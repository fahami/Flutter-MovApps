import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movapps/api/api_services.dart';
import 'package:movapps/playing_archive.dart';
import 'package:movapps/popular_archive.dart';
import 'package:movapps/providers/playing_provider.dart';
import 'package:movapps/providers/popular_provider.dart';
import 'package:movapps/providers/trending_provider.dart';
import 'package:movapps/providers/upcoming_provider.dart';
import 'package:movapps/rated_archive.dart';
import 'package:movapps/search.dart';
import 'package:movapps/upcoming_archive.dart';
import 'package:provider/provider.dart';

import 'components/movie_slider.dart';
import 'constants/state.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: SearchMovies()),
              icon: Icon(Icons.search))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Fahmi Ali'),
              accountEmail: null,
              currentAccountPicture: Image.asset('assets/avatar.png'),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () => Get.offNamed('/'),
            ),
            ListTile(
              title: Text('Now Playing'),
              leading: Icon(Icons.play_circle),
              onTap: () => Get.to(() => NowPlayArchive()),
            ),
            ListTile(
              title: Text('Top Rated'),
              leading: Icon(Icons.trending_up),
              onTap: () => Get.to(() => RatedArchive()),
            ),
            ListTile(
              title: Text('Upcoming'),
              leading: Icon(Icons.ondemand_video),
              onTap: () => Get.to(() => UpcomingArchive()),
            ),
            Divider(),
            ListTile(
              title: Text('About'),
              leading: Icon(Icons.info),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('MovApps'),
                    content: Text('Movie Apps Utilizing TMDB API'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close')),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Now Playing'),
                      TextButton(
                          onPressed: () => Get.to(() => NowPlayArchive()),
                          child: Text('MORE'))
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ChangeNotifierProvider(
                    create: (_) =>
                        PlayingProvider(apiServices: ApiServices(), page: 1),
                    child: Consumer<PlayingProvider>(
                      builder: (context, playing, child) {
                        if (playing.state == ResultState.Loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (playing.state == ResultState.NoData) {
                          return Text(playing.message);
                        } else if (playing.state == ResultState.HasData) {
                          return MovieSlider(result: playing.result.results);
                        } else if (playing.state == ResultState.Error) {
                          return Text(playing.message);
                        } else {
                          return Center(child: Text(''));
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Top Rated Movies'),
                      TextButton(
                          onPressed: () => Get.to(() => RatedArchive()),
                          child: Text('MORE'))
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ChangeNotifierProvider(
                    create: (_) =>
                        TopRatedProvider(apiServices: ApiServices(), page: 1),
                    child: Consumer<TopRatedProvider>(
                      builder: (context, topRated, child) {
                        if (topRated.state == ResultState.Loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (topRated.state == ResultState.NoData) {
                          return Text(topRated.message);
                        } else if (topRated.state == ResultState.HasData) {
                          return MovieSlider(result: topRated.result.results);
                        } else if (topRated.state == ResultState.Error) {
                          return Text(topRated.message);
                        } else {
                          return Center(child: Text(''));
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Popular Movies'),
                      TextButton(
                        onPressed: () => Get.to(() => PopularArchive()),
                        child: Text('MORE'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ChangeNotifierProvider(
                    create: (_) =>
                        PopularProvider(apiServices: ApiServices(), page: 1),
                    child: Consumer<PopularProvider>(
                      builder: (context, popular, child) {
                        if (popular.state == ResultState.Loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (popular.state == ResultState.NoData) {
                          return Text(popular.message);
                        } else if (popular.state == ResultState.HasData) {
                          return MovieSlider(
                            result: popular.result.results,
                          );
                        } else if (popular.state == ResultState.Error) {
                          return Text(popular.message);
                        } else {
                          return Center(child: Text(''));
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Upcoming Movies'),
                      TextButton(
                          onPressed: () => Get.to(() => UpcomingArchive()),
                          child: Text('MORE'))
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ChangeNotifierProvider(
                    create: (_) =>
                        UpcomingProvider(apiServices: ApiServices(), page: 1),
                    child: Consumer<UpcomingProvider>(
                      builder: (context, upcoming, child) {
                        if (upcoming.state == ResultState.Loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (upcoming.state == ResultState.NoData) {
                          return Text(upcoming.message);
                        } else if (upcoming.state == ResultState.HasData) {
                          return MovieSlider(result: upcoming.result.results);
                        } else if (upcoming.state == ResultState.Error) {
                          return Text(upcoming.message);
                        } else {
                          return Center(child: Text(''));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
