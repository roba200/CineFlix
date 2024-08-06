import 'package:cineflix/Model/Movie.dart';
import 'package:cineflix/Model/Series.dart';
import 'package:cineflix/components/custom_button.dart';
import 'package:cineflix/components/youtube_player%20.dart';
import 'package:cineflix/constants.dart';
import 'package:flutter/material.dart';

class MoviePopUp extends StatefulWidget {
  final Movie? movie;
  final Series? series;
  const MoviePopUp({super.key, this.movie, this.series});

  @override
  State<MoviePopUp> createState() => _MoviePopUpState();
}

class _MoviePopUpState extends State<MoviePopUp> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      elevation: 0,
      scrollable: true,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: height - 200,
        width: width - 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.series == null
                ? widget.movie!.backdropUrl
                : widget.series!.backdropUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.darken),
          ),
        ),
        child: Container(
          color: Colors.transparent,
          height: 20,
          width: 20,
          child: SizedBox(
            width: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 60, right: 600),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.series == null
                          ? widget.movie!.name
                          : widget.series!.name,
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
                      widget.series == null
                          ? widget.movie!.year
                          : widget.series!.year,
                      style: TextStyle(
                        color: white,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.series == null
                          ? widget.movie!.description
                          : widget.series!.description,
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
                                  builder: (context) => YoutubePlayerWidget(
                                      url: widget.series == null
                                          ? widget.movie!.videoUrl
                                          : widget.series!.videoUrl)));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
