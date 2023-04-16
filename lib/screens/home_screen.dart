// Home 스크린은 아래와 같은 기능을 갖고있어야 합니다.
// 가장 인기 있는 영화 목록이 표시되어야 합니다.
// 극장에서 상영 중인 영화 목록이 표시되어야 합니다.
// 곧 개봉할 영화 목록이 표시되어야 합니다.

// movie를 탭하면 세부정보 화면으로 이동해야 합니다.

/*
가장 인기 있는 영화
https://movies-api.nomadcoders.workers.dev/popular

극장에서 상영 중인 영화
https://movies-api.nomadcoders.workers.dev/now-playing

곧 개봉하는 영화
https://movies-api.nomadcoders.workers.dev/coming-soon

영화에 대한 세부 정보
https://movies-api.nomadcoders.workers.dev/movie?id=1 (아이디를 세부 정보를 보려는 영화의 아이디로 바꾸세요).
*/

import 'package:flutter/material.dart';
import 'package:flutter_movieflix/models/movie_model.dart';
import 'package:flutter_movieflix/screens/detail_screen.dart';
import 'package:flutter_movieflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies =
      ApiService.getMovies("popular");
  final Future<List<MovieModel>> nowPlaying =
      ApiService.getMovies("nowPlaying");
  final Future<List<MovieModel>> upcoming = ApiService.getMovies("upcoming");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'TOONFLIX',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Text(
                'Popular Movies',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 230,
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot, 300, 180);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const Text(
                'Now in Cinemas',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 210,
                child: FutureBuilder(
                  future: nowPlaying,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot, 150, 150);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: FutureBuilder(
                  future: upcoming,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot, 150, 150);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView makeList(
      AsyncSnapshot<List<MovieModel>> snapshot, double width, double height) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final movie = snapshot.data![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                    title: movie.title, poster: movie.poster, id: movie.id),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${movie.poster}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: width,
                child: Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
    );
  }
}
