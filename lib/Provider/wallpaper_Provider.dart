import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:unsplash/models/wallpaper.dart';
import 'package:http/http.dart' as http;

class WallpaperProvider with ChangeNotifier {
  bool loading = false;
  bool error = false;
  String item = 'curated';
  final String _apiKey =
      '563492ad6f917000010000011c649aa03fc3487bbe60c4d64707811f';

  WallpaperModel? wallpaperModel;

  Future<void> randomPhoto() async {
    try {
      loading = true;
      notifyListeners();
      var url = Uri.parse('https://api.pexels.com/v1/curated');
      var response = await http.get(url,
          headers: {'Authorization': _apiKey}).timeout(Duration(seconds: 10));
      wallpaperModel = WallpaperModel.fromJson(json.decode(response.body));
      if (response.statusCode != 200) {
        error = true;
        notifyListeners();
      }
      loading = false;
      notifyListeners();
    } catch (e) {
      error = true;
      notifyListeners();
    }
  }
Future<void>saveGallery(String data)async{
  await GallerySaver.saveImage(data);
}
  Future<void> searchWallpaper(String item) async {
    this.item = item;
    if (item == 'curated') error = false;
    try {
      loading = true;
      notifyListeners();
      var url;
      if (item == 'curated') {
        url = Uri.parse('https://api.pexels.com/v1/curated');
      } else {
        url = Uri.parse('https://api.pexels.com/v1/search?query=$item');
      }
      var response = await http.get(url,
          headers: {'Authorization': _apiKey}).timeout(Duration(seconds: 10));

      wallpaperModel = WallpaperModel.fromJson(json.decode(response.body));
      if (response.statusCode != 200) {
        error = true;
        notifyListeners();
      }

      loading = false;
      notifyListeners();
    } catch (e) {
      error = true;
      notifyListeners();
    }
    error = false;
  }
}
