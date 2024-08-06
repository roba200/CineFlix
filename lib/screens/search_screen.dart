import 'dart:convert';
import 'package:cineflix/Model/Movie.dart';
import 'package:cineflix/Model/Series.dart';
import 'package:cineflix/components/custom_progress_indicator.dart';
import 'package:cineflix/components/movie_card.dart';
import 'package:cineflix/components/movie_popup.dart';
import 'package:cineflix/constants.dart';
import 'package:cineflix/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Movie> movies = [];
  List<Series> tvSeries = [];
  bool isLoading = false;

  Future<void> searchContent() async {
    final movieResponse = await http.get(
      Uri.parse(
          'http://localhost:9191/movie/search?name=${searchController.text}'),
    );

    final tvSeriesResponse = await http.get(
      Uri.parse(
          'http://localhost:9191/series/search?name=${searchController.text}'),
    );

    if (movieResponse.statusCode == 200) {
      final List moviesJson = json.decode(movieResponse.body);
      setState(() {
        movies = moviesJson.map((json) => Movie.fromJson(json)).toList();
      });
    } else {
      print('Failed to load movies: ${movieResponse.reasonPhrase}');
    }

    if (tvSeriesResponse.statusCode == 200) {
      final List tvSeriesJson = json.decode(tvSeriesResponse.body);
      setState(() {
        tvSeries = tvSeriesJson.map((json) => Series.fromJson(json)).toList();
      });
    } else {
      print('Failed to load TV series: ${tvSeriesResponse.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 19, 19, 19),
          leadingWidth: 400,
          toolbarHeight: 100,
          elevation: 0,
          leading: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/logo.png"))),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color.fromARGB(255, 19, 19, 19)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      onChanged: (value) {
                        searchContent();
                      },
                      style: TextStyle(color: white),
                      cursorColor: white,
                      controller: searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 229, 9, 20),
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 229, 9, 20),
                              width: 2,
                            )),
                        labelStyle: TextStyle(color: white),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 229, 9, 20),
                              width: 1,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: white, width: 0.3)),
                        labelText: 'Search',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: searchContent,
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
                      "Movies : ${movies.length} results found",
                      style: TextStyle(
                          color: white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  isLoading
                      ? Container(
                          height: 230,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: CustomProgressIndicator())
                      : Container(
                          height: 230,
                          child: movies.length > 0
                              ? ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior(),
                                  child: ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: movies.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: MovieCard(
                                          url: movies[index].posterUrl,
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    MoviePopUp(
                                                        movie: movies[index]));
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                  "No result Found, Try again with different keyword",
                                  style: TextStyle(color: white),
                                ))),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    child: Text(
                      "TV Series: ${tvSeries.length} results found",
                      style: TextStyle(
                          color: white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  isLoading
                      ? Container(
                          height: 230,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: CustomProgressIndicator())
                      : Container(
                          height: 230,
                          child: tvSeries.length > 0
                              ? ScrollConfiguration(
                                  behavior: MyCustomScrollBehavior(),
                                  child: ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tvSeries.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: MovieCard(
                                          url: tvSeries[index].posterUrl,
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    MoviePopUp(
                                                        series:
                                                            tvSeries[index]));
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                  "No result Found, Try again with different keyword",
                                  style: TextStyle(color: white),
                                ))),
                ],
              ),
            ),
          ),
        ));
  }
}
