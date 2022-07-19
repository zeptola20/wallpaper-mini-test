import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:unsplash/Provider/wallpaper_Provider.dart';

class SearchBox extends StatefulWidget {
  SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  var wallpaperData;
  @override
  void initState() {
    super.initState();
    wallpaperData = Get.find<WallpaperProvider>();
  }

  var item = TextEditingController();
  Timer? searchOnStoppedTyping;
  void onChangeHandler(value) {
    const duration = Duration(milliseconds: 1500);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }
    searchOnStoppedTyping = Timer(duration, () {
      if (item.text != '') wallpaperData.searchWallpaper(item.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        maxLength: 25,
        controller: item,
        onChanged: (_) {
          onChangeHandler(item.text);
        },
        onSubmitted: (_) {
          wallpaperData.searchWallpaper(item.text);
        },
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        maxLines: 1,
        showCursor: true,
        cursorColor: const Color(0xFF05a081),
        decoration: InputDecoration(
            counter: SizedBox(),
            prefixIcon: IconButton(
                onPressed: () async {
                  await wallpaperData.searchWallpaper(wallpaperData.item);
                },
                icon: const Icon(
                  Icons.search_sharp,
                  color: Color(0xFF060607),
                )),
            hintText: 'Search',
            border: InputBorder.none),
      ),
    );
  }

  @override
  void dispose() {
    searchOnStoppedTyping?.cancel();
    super.dispose();
  }
}
