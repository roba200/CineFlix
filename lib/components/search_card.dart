import 'package:cineflix/Model/Movie.dart';
import 'package:cineflix/Model/Series.dart';
import 'package:cineflix/components/movie_card.dart';
import 'package:cineflix/constants.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  final Movie? movie;
  final Series? series;
  const SearchCard({super.key, this.movie, this.series});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 400,
      width: size.width,
      decoration: BoxDecoration(),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.series == null
                    ? widget.movie!.posterUrl
                    : widget.series!.posterUrl))),
      ),
    );
  }
}
