import 'dart:convert';

import 'package:music_player_application/pages/feature_playlist/blocs/playlist_bloc.dart';
import 'package:music_player_application/pages/feature_playlist/entities/music.dart';
import 'package:music_player_application/pages/feature_playlist/entities/music_response.dart';
import 'package:music_player_application/pages/feature_playlist/entities/player_menu.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_test/rx_bloc_test.dart';
import 'package:rxdart/rxdart.dart';

import 'playlist_usecase_mock.dart';
import 'raw_music.dart';

void main() {
  final onDurationChanged = PublishSubject<Duration>();
  final musicResponse = MusicResponse.fromJson(json.decode(musicListRaw));

  final successBloc = PlaylistBloc(
      useCase:
          PlaylistUseCaseMock(result: Result.success(musicResponse.results)),
      onPlayerDurationChanged: onDurationChanged);

  final errorBloc = PlaylistBloc(
      useCase: PlaylistUseCaseMock(
          result: Result.error(Exception(["Cant receive music"]))),
      onPlayerDurationChanged: onDurationChanged);

  rxBlocTest<PlaylistBloc, Result<List<Music>>>(
    'searchArtist',
    build: () async => successBloc,
    act: (bloc) async => bloc..searchArtist("one direction"),
    state: (bloc) => bloc.states.data,
    expect: [
      Result<List<Music>>.loading(),
      Result.success(musicResponse.results)
    ],
  );

  rxBlocTest<PlaylistBloc, Result<List<Music>>>(
    'searchArtist but receive error',
    build: () async => errorBloc,
    act: (bloc) async => bloc..searchArtist("one direction"),
    state: (bloc) => bloc.states.data,
    expect: [
      Result<List<Music>>.loading(),
      Result.error(Exception(["Cant receive music"]))
    ],
  );

  rxBlocTest<PlaylistBloc, bool>(
    'searchArtist and loading',
    build: () async => successBloc,
    act: (bloc) async => bloc..searchArtist("one direction"),
    state: (bloc) => bloc.states.isLoading,
    expect: [true, false],
  );

  rxBlocTest<PlaylistBloc, String>(
    'searchArtist but receive error',
    build: () async => errorBloc,
    act: (bloc) async => bloc..searchArtist("one direction"),
    state: (bloc) => bloc.states.errors,
    expect: ["Exception: [Cant receive music]"],
  );

  rxBlocTest<PlaylistBloc, PlayerMenu>(
    'isPlay',
    build: () async => successBloc,
    act: (bloc) async => bloc..isPlay(PlayerMenu.play),
    state: (bloc) => bloc.states.isPlaying,
    expect: [PlayerMenu.play],
  );

  rxBlocTest<PlaylistBloc, Music>(
    'select music',
    build: () async => successBloc,
    act: (bloc) async => bloc..selectMusic(musicResponse.results[0]),
    state: (bloc) => bloc.states.selectedMusic,
    expect: [musicResponse.results[0]],
  );

  rxBlocTest<PlaylistBloc, Music>(
    'play next music',
    build: () async => successBloc,
    act: (bloc) async => bloc..nextSong(),
    state: (bloc) => bloc.states.selectedMusic,
    expect: [musicResponse.results[0], musicResponse.results[1]],
  );

  rxBlocTest<PlaylistBloc, Music>(
    'play next music on error data',
    build: () async => errorBloc,
    act: (bloc) async => bloc..nextSong(),
    state: (bloc) => bloc.states.selectedMusic,
    expect: [],
  );

  rxBlocTest<PlaylistBloc, Music>(
    'play prev music',
    build: () async => successBloc,
    act: (bloc) async => bloc..previousSong(),
    state: (bloc) => bloc.states.selectedMusic,
    expect: [musicResponse.results[1], musicResponse.results[0]],
  );

  rxBlocTest<PlaylistBloc, Music>(
    'play prev music on error data',
    build: () async => errorBloc,
    act: (bloc) async => bloc..previousSong(),
    state: (bloc) => bloc.states.selectedMusic,
    expect: [],
  );

  rxBlocTest<PlaylistBloc, Duration>(
    'on duration changed',
    build: () async {
      onDurationChanged.add(const Duration(seconds: 1));
      return successBloc;
    },
    act: (bloc) async => bloc..onDurationChanged(const Duration(seconds: 1)),
    state: (bloc) => bloc.states.currentDuration,
    expect: [const Duration(seconds: 1)],
  );
}
