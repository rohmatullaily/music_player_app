import 'package:music_player_application/pages/feature_playlist/entities/music.dart';

class MusicResponse {
  MusicResponse({
    required this.resultCount,
    required this.results,
  });
  late final int resultCount;
  late final List<Music> results;

  MusicResponse.fromJson(Map<String, dynamic> json){
    resultCount = json['resultCount'];
    results = List.from(json['results']).map((e)=>Music.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['resultCount'] = resultCount;
    _data['results'] = results.map((e)=>e.toJson()).toList();
    return _data;
  }
}