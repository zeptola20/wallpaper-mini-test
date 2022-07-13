class WallpaperModel {
  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel src;
  bool liked;
  String alt;
  WallpaperModel({
    required this.photographer,
    required this.photographer_url,
    required this.photographer_id,
    required this.src,
    required this.liked,
    required this.alt,
  });
}

class SrcModel {
  String original;
  String large2x;
  String large;
  String medium;
  String small;
  String portrait;
  String landscape;
  String tiny;
  SrcModel({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });
}
