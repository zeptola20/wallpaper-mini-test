import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash/Provider/category_Provider.dart';
import 'package:unsplash/Provider/wallpaper_Provider.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WallpaperProvider>(context, listen: false).randomPhoto();
    });
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    var categoryData = Provider.of<CategoryProvider>(context);
    var wallpaperData = Provider.of<WallpaperProvider>(context, listen: true);
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
        body: Consumer<WallpaperProvider>(
            builder: ((context, value, child) => Column(
                  children: [
                    searchBox(),
                    //   catWidget(categoryData: categoryData),
                    value.loading
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        :Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              Platform.isWindows ? 3 : 2,
                                          childAspectRatio: .6,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                        ),
                                        itemCount: value.wallpaperModel?.photos
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          return value.wallpaperModel!.photos!
                                                  .isEmpty
                                              ? const Center(
                                                  child: Text('Nothing found!'),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors
                                                                .grey.shade300,
                                                            offset:
                                                                const Offset(
                                                                    2, 2),
                                                            blurRadius: 1)
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        value
                                                            .wallpaperModel!
                                                            .photos![index]
                                                            .src!
                                                            .portrait!,
                                                        fit: BoxFit.cover,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                      )),
                                                );
                                        })),
                              )
                  ],
                ))

            //  #b2158a
            ));
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
        color: const Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        maxLength: 25,
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
        cursorColor: const Color(0xFF05a081),
        decoration: InputDecoration(
            counter: Container(),
            prefixIcon: Icon(Icons.search),
            hintText: 'Search',
            border: InputBorder.none),
      ),
    );
  }
}

// class catWidget extends StatelessWidget {
//   const catWidget({
//     Key? key,
//     required this.categoryData,
//   }) : super(key: key);

//   final CategoryProvider categoryData;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemBuilder: ((context, index) {
//           return GestureDetector(
//             onDoubleTap: () =>
//                 Provider.of<WallpaperProvider>(context, listen: false)
//                     .searchWallpaper(categoryData.catList[index].catName),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   width: 170,
//                   height: 120,
//                   decoration: BoxDecoration(boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.shade300,
//                         offset: const Offset(2, 2),
//                         blurRadius: 10)
//                   ]),
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image(
//                       fit: BoxFit.cover,
//                       image: NetworkImage(
//                         categoryData.catList[index].imageUrl,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 170,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.black26,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 Text(
//                   categoryData.catList[index].catName,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                       color: Colors.white),
//                 )
//               ],
//             ),
//           );
//         }),
//         itemCount: categoryData.catList.length,
//       ),
//     );
//   }

