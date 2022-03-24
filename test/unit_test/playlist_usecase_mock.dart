import 'package:music_player_application/pages/feature_playlist/blocs/playlist_usecase.dart';
import 'package:music_player_application/pages/feature_playlist/entities/music.dart';
import 'package:rx_bloc/rx_bloc.dart';

class PlaylistUseCaseMock implements IPlaylistUseCase {
  late final Result<List<Music>> result;
  PlaylistUseCaseMock({required this.result});

  @override
  Future<Result<List<Music>>> getMusicList({required String artistName}) async {
    return result;
  }
}
