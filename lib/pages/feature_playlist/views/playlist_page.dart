import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:music_player_application/pages/feature_playlist/blocs/playlist_usecase.dart';
import 'package:music_player_application/pages/feature_playlist/entities/music.dart';
import 'package:music_player_application/pages/feature_playlist/entities/player_menu.dart';
import 'package:provider/provider.dart';

import '../blocs/playlist_bloc.dart';

class PlaylistPage extends StatelessWidget {
  AudioPlayer audioPlayer = AudioPlayer();
  PlaylistPage({
    Key? key,
  }) : super(key: key);

  var btnIcon = Icons.play_arrow;

  Widget _buildDataContainer() =>
      RxResultBuilder<PlaylistBlocType, List<Music>>(
        state: (bloc) => bloc.states.data,
        buildLoading: (ctx, bloc) => const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        )),
        buildError: (ctx, error, bloc) => Text(error.toString()),
        buildSuccess: (ctx, state, bloc) => ListView.builder(
          shrinkWrap: true,
          itemCount: state.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {},
            child: Card(
              color: const Color(0xff000000),
              child: ListTile(
                  onTap: () {
                    bloc.events.selectMusic(state[index]);
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      state[index].artworkUrl100,
                    ),
                  ),
                  title: Text(
                    state[index].trackName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state[index].artistName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        state[index].collectionName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                  trailing: RxBlocBuilder<PlaylistBlocType, Music>(
                      state: (bloc) => bloc.states.selectedMusic,
                      builder: (context, selectedState, bloc) {
                        var trackIdState = state[index].trackId;
                        var trackIdSelected = selectedState.data?.trackId;
                        return RxBlocBuilder<PlaylistBlocType, PlayerMenu>(
                            state: (bloc) => bloc.states.isPlaying,
                            builder: (context, playingState, bloc) {
                              return Container(
                                  margin: const EdgeInsets.all(17.0),
                                  child: trackIdState == trackIdSelected &&
                                          playingState.data == PlayerMenu.play
                                      ? Icon(
                                          Icons.pause,
                                          color: Colors.blueGrey.shade200,
                                        )
                                      : Icon(
                                          Icons.play_arrow,
                                          color: Colors.blueGrey.shade200,
                                        ));
                            });
                      })),
            ),
          ),
        ),
      );

  Widget _buildErrorListener() => RxBlocListener<PlaylistBlocType, String>(
        state: (bloc) => bloc.states.errors,
        listener: (context, errorMessage) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage ?? ''),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );

  Widget _buildPlayerListener() => RxBlocListener<PlaylistBlocType, Music>(
        state: (bloc) => bloc.states.selectedMusic,
        listener: (context, state) async {
          if (state != null) {
            int result = await audioPlayer.play(state.previewUrl);
            if (result == 1) {
              RxBlocProvider.of<PlaylistBlocType>(context)
                  .events
                  .isPlay(PlayerMenu.play);
            }
          }
        },
      );

  Widget _buildPlayerContainer() => RxBlocBuilder<PlaylistBlocType, PlayerMenu>(
      state: (bloc) => bloc.states.isPlaying,
      builder: (context, state, bloc) {
        if (state.data == PlayerMenu.play) {
          btnIcon = Icons.pause;
        } else {
          btnIcon = Icons.play_arrow;
        }
        return state.data == PlayerMenu.play
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 40.0,
                        color: Colors.white,
                        onPressed: () {
                          RxBlocProvider.of<PlaylistBlocType>(context)
                              .events
                              .previousSong();
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          audioPlayer.stop();
                          RxBlocProvider.of<PlaylistBlocType>(context)
                              .events
                              .isPlay(PlayerMenu.stop);
                        },
                        icon: Icon(
                          btnIcon,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        iconSize: 40.0,
                        color: Colors.white,
                        onPressed: () {
                          RxBlocProvider.of<PlaylistBlocType>(context)
                              .events
                              .nextSong();
                        },
                        icon: const Icon(
                          Icons.skip_next,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container();
      });

  @override
  Widget build(BuildContext context) {
    return RxBlocProvider<PlaylistBlocType>(
      create: (context) => PlaylistBloc(
          useCase: PlaylistUseCase(dioClient: context.read()),
          onPlayerDurationChanged: audioPlayer.onDurationChanged),
      child: Builder(
          builder: (context) => Scaffold(
                body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff000000),
                        Color(0xffffffff),
                        Color(0xff000000),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 22.0,
                            right: 22.0,
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Music Player",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.search),
                              title: TextField(
                                  decoration: const InputDecoration(
                                      hintText: 'Search Artist',
                                      border: InputBorder.none),
                                  onChanged: (v) {
                                    audioPlayer.stop();
                                    RxBlocProvider.of<PlaylistBlocType>(context)
                                        .events
                                        .isPlay(PlayerMenu.stop);
                                    RxBlocProvider.of<PlaylistBlocType>(context)
                                        .events
                                        .searchArtist(v);
                                  }),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: _buildDataContainer(),
                          ),
                        ),
                        _buildPlayerContainer(),
                        _buildErrorListener(),
                        _buildPlayerListener(),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
