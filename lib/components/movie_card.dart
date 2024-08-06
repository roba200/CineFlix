import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  final String url;
  final Function()? onTap;
  const MovieCard({super.key, required this.url, this.onTap});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: GestureDetector(
        child: Container(
          height: 250,
          width: 170,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.darken),
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.url))),
        ),
      ),
    );
  }
}
