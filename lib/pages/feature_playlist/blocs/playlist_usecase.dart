import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:music_player_application/pages/feature_playlist/entities/music.dart';
import 'package:music_player_application/pages/feature_playlist/entities/music_response.dart';
import 'package:rx_bloc/rx_bloc.dart';

abstract class IPlaylistUseCase {
  Future<Result<List<Music>>> getMusicList({required String artistName});
}

class PlaylistUseCase implements IPlaylistUseCase {
  late final Dio _dioClient;

  PlaylistUseCase({required Dio dioClient}) : _dioClient = dioClient;

  @override
  Future<Result<List<Music>>> getMusicList({required String artistName}) async {
    try {
      final response = await _dioClient.get(
          "https://itunes.apple.com/search?term=$artistName&limit=25&media=music");
      if (response.statusCode == 200 && response.data != null) {
        final stringData = (response.data as String? ?? "");
        if (stringData.isNotEmpty) {
          final musicResponse = MusicResponse.fromJson(json.decode(stringData));
          return Result.success(musicResponse.results);
        }
      }
      return Result.error(Exception([response.statusMessage]));
    } catch (e) {
      return Result.error(Exception([e]));
    }
  }
}
