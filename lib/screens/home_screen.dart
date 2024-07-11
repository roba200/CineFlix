import 'dart:convert';
import 'dart:math';

import 'package:cineflix/Model/Movie.dart';
import 'package:cineflix/Model/Series.dart';
import 'package:cineflix/components/custom_button.dart';
import 'package:cineflix/components/movie_card.dart';
import 'package:cineflix/components/youtube_player%20.dart';
import 'package:cineflix/constants.dart';
import 'package:cineflix/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> futureMovies;
  late Future<List<Series>> futureSeries;
  late int selectedMovieIndex;
  final ScrollController _scrollController = ScrollController();
  bool isMovie = true;

  Future<List<Movie>> fetchMovies() async {
    final response =
        await http.get(Uri.parse('http://localhost:9191/movie/movies'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load Movies');
    }
  }

  Future<List<Series>> fetchSeries() async {
    final response =
        await http.get(Uri.parse('http://localhost:9191/series/getseries'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((series) => Series.fromJson(series)).toList();
    } else {
      throw Exception('Failed to load Series');
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovies();
    futureSeries = fetchSeries();
    int randomValue = Random().nextInt(3);
    selectedMovieIndex = randomValue;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: FutureBuilder(
          future: isMovie ? fetchMovies() : fetchSeries(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List selectedMovie = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 600,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.darken),
                            image: NetworkImage(
                              selectedMovie[selectedMovieIndex].backdropUrl,
                            ))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 127,
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 500,
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedMovie[selectedMovieIndex].name,
                              style: TextStyle(
                                  letterSpacing: 4,
                                  color: white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              selectedMovie[selectedMovieIndex].year,
                              style: TextStyle(
                                color: white,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              selectedMovie[selectedMovieIndex].description,
                              style: TextStyle(
                                color: white,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: CustomButton(
                                text: "Start watching",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              YoutubePlayerWidget(
                                                  url: selectedMovie[
                                                          selectedMovieIndex]
                                                      .videoUrl)));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    child: Text(
                      "Movies",
                      style: TextStyle(
                          color: white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: FutureBuilder<List<Movie>>(
                        future: futureMovies,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Movie> movies = snapshot.data!;
                            return ScrollConfiguration(
                              behavior: MyCustomScrollBehavior(),
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: MovieCard(
                                      url: movies[index].posterUrl,
                                      onTap: () {
                                        setState(() {
                                          isMovie = true;
                                        });
                                        selectedMovieIndex = index;
                                        _scrollToTop();
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    child: Text(
                      "TV shows",
                      style: TextStyle(
                          color: white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: FutureBuilder<List<Series>>(
                          future: futureSeries,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Series> series = snapshot.data!;
                              return ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: series.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: MovieCard(
                                      url: series[index].posterUrl,
                                      onTap: () {
                                        setState(() {
                                          isMovie = false;
                                        });
                                        selectedMovieIndex = index;
                                        _scrollToTop();
                                      },
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
