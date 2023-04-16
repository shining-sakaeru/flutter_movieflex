class MovieDetailModel {
  final String title, about, genre, age;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
