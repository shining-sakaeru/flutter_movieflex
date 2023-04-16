// 세부정보 화면에는 다음이 표시되어야 합니다.
// 영화의 포스터.
// 영화의 제목.
// 영화의 등급.
// 영화의 개요.
// 영화의 장르.

import 'package:flutter_movieflix/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movieflix/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, id, getFullPosterPath, overview;

  const DetailScreen({
    super.key,
    required this.title,
    required this.id,
    required this.getFullPosterPath,
    required this.overview,
    // required this.name,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  // Future iniyPref() async {
  //   prefs = await sharedPreferences.getIntance();
  // }
  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Back to list',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              widget.getFullPosterPath,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Hero(
                  tag: widget.id,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                FutureBuilder(
                  future: movie,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Storyline',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Adult=${snapshot.data!.adult}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // for (int i = 0; i < snapshot.data!.genres.length; i++)
                          // Text(
                          //   snapshot.data!.instance.genres,
                          //   [i]['name']}${i == snapshot.data!.genres.length - 1 ? '' : ', '}',
                          // ),
                          Text(
                            snapshot.data!.overview,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }
                    return const Text('...');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
