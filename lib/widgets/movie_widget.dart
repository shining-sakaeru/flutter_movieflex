import 'package:flutter/material.dart';
import 'package:flutter_movieflix/screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final String id, title, getFullPosterPath, overview;
  const Movie({
    super.key,
    required this.id,
    required this.title,
    required this.getFullPosterPath,
    required this.overview,
    // required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              id: id,
              getFullPosterPath: getFullPosterPath,
              overview: overview,
              // name: name,
            ),
            fullscreenDialog: false,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
              child: Image.network(getFullPosterPath),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          )
        ],
      ),
    );
  }
}
