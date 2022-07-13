import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unsplash/Provider/category_Provider.dart';
import 'package:unsplash/Provider/wallpaper_Provider.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  bool first = true;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    if (widget.first) {
      Provider.of<WallpaperProvider>(context, listen: false).randomPhoto();
      print(
          'first time list lenght:${Provider.of<WallpaperProvider>(context, listen: false).wallpaperList.length}');
      widget.first = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var categoryData = Provider.of<CategoryProvider>(context);
    var wallpaperData = Provider.of<WallpaperProvider>(context, listen: true);
    print(
        'two time list lenght:${Provider.of<WallpaperProvider>(context, listen: false).wallpaperList.length}');
    ;
    Provider.of<WallpaperProvider>(context, listen: false).randomPhoto();
    print(
        'three time list lenght:${Provider.of<WallpaperProvider>(context, listen: false).wallpaperList.length}');
    if (wallpaperData.wallpaperList.isNotEmpty) {
      setState(() {});
    }
    var appBar2 = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Pexels',
            style: TextStyle(color: Color(0xFF060607), fontSize: 33),
          ),
          const SizedBox(
            width: 3,
          ),
          Image.asset('assets/images/logo-pexcel.png'),
        ],
      ),
      elevation: 0,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar2,
      body: Container(
          width: double.infinity,
          child: Column(
            children: [
              searchBox(),
              catWidget(categoryData: categoryData),
              wallpaperData.wallpaperList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Consumer<WallpaperProvider>(
                          builder: ((context, value, child) => GridView(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: Platform.isWindows ? 3 : 2,
                                  childAspectRatio: .6,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                children: wallpaperData.wallpaperList.map(((e) {
                                  return GridTile(
                                      child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: Offset(2, 2),
                                          blurRadius: 10)
                                    ], borderRadius: BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: NetworkImage(e.src.portrait),
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                  ));
                                })).toList(),
                              )),
                          child: Container(),
                        ),
                      ),
                    )
            ],
          )),
      //  #b2158a
    );
  }
}

class searchBox extends StatefulWidget {
  searchBox({
    Key? key,
  }) : super(key: key);

  @override
  State<searchBox> createState() => _searchBoxState();
}

class _searchBoxState extends State<searchBox> {
  var item = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: item,
        onSubmitted: (_) {
          setState(() {
            Provider.of<WallpaperProvider>(context, listen: false)
                .searchWallpaper(item.text);
          });
        },
        keyboardType: TextInputType.url,
        maxLines: 1,
        showCursor: true,
        cursorColor: Color(0xFF05a081),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search',
            border: InputBorder.none),
      ),
    );
  }
}

class catWidget extends StatelessWidget {
  const catWidget({
    Key? key,
    required this.categoryData,
  }) : super(key: key);

  final CategoryProvider categoryData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onDoubleTap: () =>
                Provider.of<WallpaperProvider>(context, listen: false)
                    .searchWallpaper(categoryData.catList[index].catName),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 170,
                  height: 120,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(2, 2),
                        blurRadius: 10)
                  ]),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        categoryData.catList[index].imageUrl,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 170,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  child: Text(
                    categoryData.catList[index].catName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          );
        }),
        itemCount: categoryData.catList.length,
      ),
    );
  }
}
