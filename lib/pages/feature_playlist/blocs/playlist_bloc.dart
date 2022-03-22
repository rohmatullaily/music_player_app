import 'package:music_player_application/pages/feature_playlist/blocs/playlist_usecase.dart';
import 'package:music_player_application/pages/feature_playlist/entities/music.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'playlist_bloc.rxb.g.dart';

/// A contract class containing all events of the PlaylistBloC.
abstract class PlaylistBlocEvents {
  void searchArtist(String artistName);
  void selectMusic(Music music);
  void onDurationChanged(Duration duration);
}

/// A contract class containing all states of the PlaylistBloC.
abstract class PlaylistBlocStates {
  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<String> get errors;

  Stream<Result<List<Music>>> get data;
  Stream<Music> get selectedMusic;
  Stream<Duration> get currentDuration;
}

@RxBloc()
class PlaylistBloc extends $PlaylistBloc {

  late final IPlaylistUseCase _useCase;
  PlaylistBloc({required IPlaylistUseCase useCase, required Stream<Duration> onPlayerDurationChanged}) {
    _useCase = useCase;
    onPlayerDurationChanged.listen((event) {
      _$onDurationChangedEvent.add(event);
    })
    .disposedBy(_compositeSubscription);
  }

  @override
  Stream<Result<List<Music>>> _mapToDataState() => _$searchArtistEvent
      .startWith("celine dion")
      .debounceTime(const Duration(milliseconds: 200))
      .switchMap((value) async* {
        yield Result<List<Music>>.loading();
        yield await _useCase.getMusicList(artistName: value);
      })
      .setResultStateHandler(this)
      .shareReplay(maxSize: 1);

  @override
  Stream<Music> _mapToSelectedMusicState() => _$selectMusicEvent;

  @override
  Stream<Duration> _mapToCurrentDurationState() => _$onDurationChangedEvent;

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
