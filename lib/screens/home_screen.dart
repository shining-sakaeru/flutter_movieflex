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
import 'package:flutter_movieflix/services/api_service.dart';
import 'package:flutter_movieflix/widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> movies = ApiService.getPopularMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: const Text(
          'Toonflix',
          style: TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: popularMakeList(snapshot)),
                const SizedBox(
                  height: 50,
                ),
                // Expanded(child: nowPlayingMakeList(snapshot)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView popularMakeList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return Movie(
          title: movie.title,
          id: movie.id.toString(),
          getFullPosterPath: movie.getFullPosterPath(),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}

// ListView nowPlayingMakeList(AsyncSnapshot<List<MovieModel>> snapshot) {
//   return ListView.separated(
//     scrollDirection: Axis.horizontal,
//     itemCount: snapshot.data!.length,
//     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//     itemBuilder: (context, index) {
//       var movie = snapshot.data![index];
//       return Movie(
//         title: movie.title,
//         id: movie.id.toString(),
//         getFullPosterPath: movie.getFullPosterPath(),
//       );
//     },
//     separatorBuilder: (context, index) => const SizedBox(width: 40),
//   );
// }
