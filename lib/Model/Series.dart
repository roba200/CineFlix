class Series {
  int id;
  String name;
  String posterUrl;
  String backdropUrl;
  String description;
  String rating;
  String category;
  String videoUrl;
  String year;

  Series(
      {required int this.id,
      required String this.name,
      required String this.posterUrl,
      required String this.backdropUrl,
      required String this.description,
      required String this.rating,
      required String this.category,
      required String this.videoUrl,
      required String this.year});

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'],
      name: json['name'],
      posterUrl: json['posterUrl'],
      backdropUrl: json['backdropUrl'],
      description: json['description'],
      rating: json['rating'],
      category: json['category'],
      videoUrl: json['videoUrl'],
      year: json['year'],
    );
  }
}
