import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:youtube_id_scraper/youtube_id_scraper.dart';
import 'package:youtube_player_iframe_plus/youtube_player_iframe_plus.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String url;
  YoutubePlayerWidget({super.key, required this.url});

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  YoutubePlayerController? _controller;

  String? extractYouTubeId(String url) {
    RegExp regExp = RegExp(
      r'(?:v=|\/)([0-9A-Za-z_-]{11}).*',
      caseSensitive: false,
      multiLine: false,
    );

    Match? match = regExp.firstMatch(url);
    return match?.group(1);
  }

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
        initialVideoId: extractYouTubeId(widget.url)!,
        params: YoutubePlayerParams(
          desktopMode: false,
          autoPlay: true,
          mute: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: _controller!,
      child: YoutubePlayerIFramePlus(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
