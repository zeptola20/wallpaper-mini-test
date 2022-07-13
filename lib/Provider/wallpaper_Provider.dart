import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:unsplash/models/wallpaper.dart';
import 'package:http/http.dart' as http;

class WallpaperProvider with ChangeNotifier {
  final String _apiKey =
      '563492ad6f917000010000011c649aa03fc3487bbe60c4d64707811f';
  List<WallpaperModel> wallpaperList = [];
  List<WallpaperModel> _wallpaperList = [];
  // List  wallpaperList = [..._wallpaperList];
  void addWallpaper(WallpaperModel wallpaper) {
    _wallpaperList.add(wallpaper);
  }

  void randomPhoto() async {
    try {
      var url = Uri.parse('https://api.pexels.com/v1/curated');
      var response = await http.get(url, headers: {'Authorization': _apiKey});
      var jsonData = jsonDecode(response.body);
      print(jsonData.toString());
      List data = jsonData['photos'];

      for (var i = 0; i < data.length; i++) {
        if (wallpaperList.isNotEmpty) notifyListeners();
        addWallpaper(WallpaperModel(
          photographer: data[i]['photographer'],
          photographer_url: data[i]['photographer_url'],
          photographer_id: data[i]['photographer_id'],
          src: SrcModel(
            original: data[i]['src']['original'],
            large2x: data[i]['src']['large2x'],
            large: data[i]['src']['large'],
            medium: data[i]['src']['medium'],
            small: data[i]['src']['small'],
            portrait: data[i]['src']['portrait'],
            landscape: data[i]['src']['landscape'],
            tiny: data[i]['src']['tiny'],
          ),
          liked: data[i]['liked'] ?? false,
          alt: data[i]['alt'],
        ));
      }
      ;
      wallpaperList = _wallpaperList;
      notifyListeners();
    } catch (e) {
      print('we have big errror');
      print(e);
    }
  }

  void searchWallpaper(String item) async {
    wallpaperList = [];
    var url = Uri.parse('https://api.pexels.com/v1/search?query=$item');
    var response =
        await http.get(url, headers: {'Authorization': _apiKey}).then((value) {
      var jsonData = jsonDecode(value.body);

      List data = jsonData['photos'];

      for (var i = 0; i < data.length; i++) {
        addWallpaper(WallpaperModel(
          photographer: data[i]['photographer'],
          photographer_url: data[i]['photographer_url'],
          photographer_id: data[i]['photographer_id'],
          src: SrcModel(
            original: data[i]['src']['original'],
            large2x: data[i]['src']['large2x'],
            large: data[i]['src']['large'],
            medium: data[i]['src']['medium'],
            small: data[i]['src']['small'],
            portrait: data[i]['src']['portrait'],
            landscape: data[i]['src']['landscape'],
            tiny: data[i]['src']['tiny'],
          ),
          liked: data[i]['liked'] ?? false,
          alt: data[i]['alt'],
        ));
      }
      wallpaperList = _wallpaperList;
      notifyListeners();
      print('***************************************************************');
      print(wallpaperList.length);
    });

    print('mehdi:${wallpaperList.length}');
  }
}
