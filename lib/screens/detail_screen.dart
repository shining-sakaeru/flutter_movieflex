// 세부정보 화면에는 다음이 표시되어야 합니다.
// 영화의 포스터.
// 영화의 제목.
// 영화의 등급.
// 영화의 개요.
// 영화의 장르.

import 'package:flutter_movieflix/models/movie_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String title, id, getFullPosterPath;

  const DetailScreen({
    super.key,
    required this.title,
    required this.id,
    required this.getFullPosterPath,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.blue,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
