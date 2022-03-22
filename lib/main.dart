import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_player_application/pages/feature_playlist/views/playlist_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) {
        final dio = Dio();
        dio.interceptors.add(LogInterceptor());
        return dio;
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlaylistPage(),
      ),
    );
  }
}
