import 'package:music_player_application/pages/feature_playlist/blocs/playlist_usecase.dart';
import 'package:music_player_application/pages/feature_playlist/entities/music.dart';
import 'package:music_player_application/pages/feature_playlist/entities/player_menu.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'playlist_bloc.rxb.g.dart';

/// A contract class containing all events of the PlaylistBloC.
abstract class PlaylistBlocEvents {
  void searchArtist(String artistName);
  void selectMusic(Music music);
  void nextSong();
  void previousSong();
  void onDurationChanged(Duration duration);
  void isPlay(PlayerMenu isPlay);
}

/// A contract class containing all states of the PlaylistBloC.
abstract class PlaylistBlocStates {
  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<String> get errors;

  Stream<Result<List<Music>>> get data;
  Stream<Music> get selectedMusic;
  Stream<PlayerMenu> get isPlaying;
  Stream<Duration> get currentDuration;
}

@RxBloc()
class PlaylistBloc extends $PlaylistBloc {
  late final IPlaylistUseCase _useCase;
  Music? _currentSelectedMusic;

  PlaylistBloc(
      {required IPlaylistUseCase useCase,
      required Stream<Duration> onPlayerDurationChanged}) {
    _useCase = useCase;
    onPlayerDurationChanged.listen((event) {
      _$onDurationChangedEvent.add(event);
    }).disposedBy(_compositeSubscription);
  }

  @override
  Stream<Result<List<Music>>> _mapToDataState() => _$searchArtistEvent
      .startWith("one direction")
      .debounceTime(const Duration(milliseconds: 200))
      .switchMap((value) async* {
        yield Result<List<Music>>.loading();
        yield await _useCase.getMusicList(artistName: value);
      })
      .setResultStateHandler(this)
      .shareReplay(maxSize: 1);

  @override
  Stream<Music> _mapToSelectedMusicState() => Rx.merge([
        _$selectMusicEvent,
        _$nextSongEvent.withLatestFrom<Result<List<Music>>, List<Music>>(data,
            (t, s) {
          if (s is ResultSuccess<List<Music>>) {
            return s.data;
          }
          return [];
        }).switchMap((musics) async* {
          if (_currentSelectedMusic != null) {
            final currentIndex = musics.indexOf(_currentSelectedMusic!);
            if (currentIndex >= 0 && currentIndex + 1 < musics.length) {
              yield musics[currentIndex + 1];
            }
          }
        }),
        _$previousSongEvent
            .withLatestFrom<Result<List<Music>>, List<Music>>(data, (t, s) {
          if (s is ResultSuccess<List<Music>>) {
            return s.data;
          }
          return [];
        }).switchMap((musics) async* {
          if (_currentSelectedMusic != null) {
            final currentIndex = musics.indexOf(_currentSelectedMusic!);
            if (currentIndex - 1 >= 0) {
              yield musics[currentIndex - 1];
            }
          }
        })
      ]).doOnData((event) {
        _currentSelectedMusic = event;
      }).shareReplay(maxSize: 1);

  @override
  Stream<PlayerMenu> _mapToIsPlayingState() => _$isPlayEvent;

  @override
  Stream<Duration> _mapToCurrentDurationState() => _$onDurationChangedEvent;

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
