// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'playlist_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class PlaylistBlocType extends RxBlocTypeBase {
  PlaylistBlocEvents get events;
  PlaylistBlocStates get states;
}

/// [$PlaylistBloc] extended by the [PlaylistBloc]
/// {@nodoc}
abstract class $PlaylistBloc extends RxBlocBase
    implements PlaylistBlocEvents, PlaylistBlocStates, PlaylistBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [searchArtist]
  final _$searchArtistEvent = PublishSubject<String>();

  /// Тhe [Subject] where events sink to by calling [selectMusic]
  final _$selectMusicEvent = PublishSubject<Music>();

  /// Тhe [Subject] where events sink to by calling [onDurationChanged]
  final _$onDurationChangedEvent = PublishSubject<Duration>();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [data] implemented in [_mapToDataState]
  late final Stream<Result<List<Music>>> _dataState = _mapToDataState();

  /// The state of [selectedMusic] implemented in [_mapToSelectedMusicState]
  late final Stream<Music> _selectedMusicState = _mapToSelectedMusicState();

  /// The state of [currentDuration] implemented in [_mapToCurrentDurationState]
  late final Stream<Duration> _currentDurationState =
      _mapToCurrentDurationState();

  @override
  void searchArtist(String artistName) => _$searchArtistEvent.add(artistName);

  @override
  void selectMusic(Music music) => _$selectMusicEvent.add(music);

  @override
  void onDurationChanged(Duration duration) =>
      _$onDurationChangedEvent.add(duration);

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<Result<List<Music>>> get data => _dataState;

  @override
  Stream<Music> get selectedMusic => _selectedMusicState;

  @override
  Stream<Duration> get currentDuration => _currentDurationState;

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  Stream<Result<List<Music>>> _mapToDataState();

  Stream<Music> _mapToSelectedMusicState();

  Stream<Duration> _mapToCurrentDurationState();

  @override
  PlaylistBlocEvents get events => this;

  @override
  PlaylistBlocStates get states => this;

  @override
  void dispose() {
    _$searchArtistEvent.close();
    _$selectMusicEvent.close();
    _$onDurationChangedEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
