class Music {
  Music({
    required this.wrapperType,
    required this.kind,
    required this.artistId,
    required this.collectionId,
    required this.trackId,
    required this.artistName,
    required this.collectionName,
    required this.trackName,
    required this.collectionCensoredName,
    required this.trackCensoredName,
    required this.artistViewUrl,
    required this.collectionViewUrl,
    required this.trackViewUrl,
    required this.previewUrl,
    required this.artworkUrl30,
    required this.artworkUrl60,
    required this.artworkUrl100,
    required this.collectionPrice,
    required this.trackPrice,
    required this.releaseDate,
    required this.collectionExplicitness,
    required this.trackExplicitness,
    required this.discCount,
    required this.discNumber,
    required this.trackCount,
    required this.trackNumber,
    required this.trackTimeMillis,
    required this.country,
    required this.currency,
    required this.primaryGenreName,
    required this.isStreamable,
  });
  late final String wrapperType;
  late final String kind;
  late final int artistId;
  late final int collectionId;
  late final int trackId;
  late final String artistName;
  late final String collectionName;
  late final String trackName;
  late final String collectionCensoredName;
  late final String trackCensoredName;
  late final String artistViewUrl;
  late final String collectionViewUrl;
  late final String trackViewUrl;
  late final String previewUrl;
  late final String artworkUrl30;
  late final String artworkUrl60;
  late final String artworkUrl100;
  late final double collectionPrice;
  late final double trackPrice;
  late final String releaseDate;
  late final String collectionExplicitness;
  late final String trackExplicitness;
  late final int discCount;
  late final int discNumber;
  late final int trackCount;
  late final int trackNumber;
  late final int trackTimeMillis;
  late final String country;
  late final String currency;
  late final String primaryGenreName;
  late final bool isStreamable;

  Music.fromJson(Map<String, dynamic> json) {
    wrapperType = json['wrapperType'];
    kind = json['kind'];
    artistId = json['artistId'];
    collectionId = json['collectionId'];
    trackId = json['trackId'] ?? "";
    artistName = json['artistName'];
    collectionName = json['collectionName'];
    trackName = json['trackName'];
    collectionCensoredName = json['collectionCensoredName'];
    trackCensoredName = json['trackCensoredName'];
    artistViewUrl = json['artistViewUrl'];
    collectionViewUrl = json['collectionViewUrl'];
    trackViewUrl = json['trackViewUrl'];
    previewUrl = json['previewUrl'];
    artworkUrl30 = json['artworkUrl30'];
    artworkUrl60 = json['artworkUrl60'];
    artworkUrl100 = json['artworkUrl100'];
    collectionPrice = json['collectionPrice'];
    trackPrice = json['trackPrice'];
    releaseDate = json['releaseDate'];
    collectionExplicitness = json['collectionExplicitness'];
    trackExplicitness = json['trackExplicitness'];
    discCount = json['discCount'];
    discNumber = json['discNumber'];
    trackCount = json['trackCount'];
    trackNumber = json['trackNumber'];
    trackTimeMillis = json['trackTimeMillis'];
    country = json['country'];
    currency = json['currency'];
    primaryGenreName = json['primaryGenreName'];
    isStreamable = json['isStreamable'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['wrapperType'] = wrapperType;
    _data['kind'] = kind;
    _data['artistId'] = artistId;
    _data['collectionId'] = collectionId;
    _data['trackId'] = trackId;
    _data['artistName'] = artistName;
    _data['collectionName'] = collectionName;
    _data['trackName'] = trackName;
    _data['collectionCensoredName'] = collectionCensoredName;
    _data['trackCensoredName'] = trackCensoredName;
    _data['artistViewUrl'] = artistViewUrl;
    _data['collectionViewUrl'] = collectionViewUrl;
    _data['trackViewUrl'] = trackViewUrl;
    _data['previewUrl'] = previewUrl;
    _data['artworkUrl30'] = artworkUrl30;
    _data['artworkUrl60'] = artworkUrl60;
    _data['artworkUrl100'] = artworkUrl100;
    _data['collectionPrice'] = collectionPrice;
    _data['trackPrice'] = trackPrice;
    _data['releaseDate'] = releaseDate;
    _data['collectionExplicitness'] = collectionExplicitness;
    _data['trackExplicitness'] = trackExplicitness;
    _data['discCount'] = discCount;
    _data['discNumber'] = discNumber;
    _data['trackCount'] = trackCount;
    _data['trackNumber'] = trackNumber;
    _data['trackTimeMillis'] = trackTimeMillis;
    _data['country'] = country;
    _data['currency'] = currency;
    _data['primaryGenreName'] = primaryGenreName;
    _data['isStreamable'] = isStreamable;
    return _data;
  }
}
