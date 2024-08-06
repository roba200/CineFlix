import 'dart:convert';
import 'package:cineflix/Model/Series.dart';
import 'package:cineflix/components/custom_progress_indicator.dart';
import 'package:cineflix/components/movie_popup.dart';
import 'package:http/http.dart' as http;
import 'package:cineflix/Model/Movie.dart';
import 'package:cineflix/components/movie_card.dart';
import 'package:cineflix/constants.dart';
import 'package:cineflix/main.dart';
import 'package:flutter/material.dart';

class TVScreen extends StatefulWidget {
  const TVScreen({super.key});

  @override
  State<TVScreen> createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> {
  late Future<List<Movie>> actionMovies;
  late Future<List<Movie>> animationMovies;
  late Future<List<Movie>> adventureMovies;
  late Future<List<Movie>> comedyMovies;
  late Future<List<Movie>> horrorMovies;

  Future<List<Movie>> fetchMovies(String category) async {
    final response = await http.get(Uri.parse(
        'http://localhost:9191/series/gettvseries?category=${category}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load Movies');
    }
  }

  @override
  void initState() {
    super.initState();
    actionMovies = fetchMovies('action');
    animationMovies = fetchMovies('animation');
    adventureMovies = fetchMovies('adventure');
    comedyMovies = fetchMovies('comedy');
    horrorMovies = fetchMovies('horror');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                "Action",
                style: TextStyle(
                    color: white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder<List<Movie>>(
                  future: actionMovies,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: MovieCard(
                                url: movies[index].posterUrl,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          MoviePopUp(movie: movies[index]));
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container(
                        alignment: Alignment.center,
                        height: 250,
                        child: CustomProgressIndicator());
                    ;
                  }),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                "Animation",
                style: TextStyle(
                    color: white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder<List<Movie>>(
                  future: animationMovies,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: MovieCard(
                                url: movies[index].posterUrl,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          MoviePopUp(movie: movies[index]));
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container(
                        alignment: Alignment.center,
                        height: 250,
                        child: CustomProgressIndicator());
                    ;
                  }),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                "Adventure",
                style: TextStyle(
                    color: white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder<List<Movie>>(
                  future: adventureMovies,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: MovieCard(
                                url: movies[index].posterUrl,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          MoviePopUp(movie: movies[index]));
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container(
                        alignment: Alignment.center,
                        height: 250,
                        child: CustomProgressIndicator());
                    ;
                  }),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                "Comedy",
                style: TextStyle(
                    color: white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder<List<Movie>>(
                  future: comedyMovies,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: MovieCard(
                                url: movies[index].posterUrl,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          MoviePopUp(movie: movies[index]));
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container(
                        alignment: Alignment.center,
                        height: 250,
                        child: CustomProgressIndicator());
                  }),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                "Horror",
                style: TextStyle(
                    color: white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder<List<Movie>>(
                  future: horrorMovies,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: MovieCard(
                                url: movies[index].posterUrl,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          MoviePopUp(movie: movies[index]));
                                },
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container(
                        alignment: Alignment.center,
                        height: 250,
                        child: CustomProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
