import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash/Provider/category_Provider.dart';
import 'package:unsplash/Provider/wallpaper_Provider.dart';
import 'dart:io' show Platform;

import 'package:unsplash/screens/imageView_screen.dart';

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
    var he = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
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
        body: Column(
          children: [
            searchBox(),
            /*  FutureBuilder(
              builder: (context, snopshot) {
                if (snopshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snopshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        const FittedBox(
                            child: Text('Somthing going wrong..!',
                                style: TextStyle(
                                    color: Color(0xFF060607),
                                    fontSize: 33,
                                    fontWeight: FontWeight.w500))),
                        SizedBox(
                          width: wi * .8,
                          height: he * .6,
                          child: ClipRRect(
                              child: Image.asset('assets/images/erorr.jpg')),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF05a081))),
                            onPressed: () async {
                              await wallpaperData
                                  .searchWallpaper(wallpaperData.item);
                            },
                            child: const Text(
                              'Try Again',
                              style: TextStyle(color: Color(0xFF060607)),
                            ))
                      ],
                    ),
                  );
                } else if (snopshot.connectionState == ConnectionState.done) {
                  var value =
                      Provider.of<WallpaperProvider>(context, listen: false);
                  return Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Platform.isWindows ? 3 : 2,
                              childAspectRatio: .6,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount:
                                value.wallpaperModel?.photos?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Hero(
                                tag: value.wallpaperModel!.photos![index].src!
                                    .portrait!,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      ImageView.routeName,
                                      arguments: value.wallpaperModel!
                                          .photos![index].src!.portrait!,
                                    );
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        value.wallpaperModel!.photos![index]
                                            .src!.portrait!,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      )),
                                ),
                              );
                            })),
                  );
                }
                return SizedBox();
              },
              future: Future.delayed(Duration.zero).then((value) =>
                  Provider.of<WallpaperProvider>(context, listen: false)
                      .wallpaperModel),
            ),*/
            wallpaperData.error
                ? Center(
                    child: Column(
                      children: [
                        const FittedBox(
                            child: Text('Somthing going wrong..!',
                                style: TextStyle(
                                    color: Color(0xFF060607),
                                    fontSize: 33,
                                    fontWeight: FontWeight.w500))),
                        SizedBox(
                          width: wi * .8,
                          height: he * .6,
                          child: ClipRRect(
                              child: Image.asset('assets/images/erorr.jpg')),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF05a081))),
                            onPressed: () async {
                              await wallpaperData
                                  .searchWallpaper(wallpaperData.item);
                            },
                            child: const Text(
                              'Try Again',
                              style: TextStyle(color: Color(0xFF060607)),
                            ))
                      ],
                    ),
                  )
                :
                //   catWidget(categoryData: categoryData),
                wallpaperData.loading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : wallpaperData.wallpaperModel!.photos!.isEmpty
                        ? Center(
                            child: SizedBox(
                              width: wi * .8,
                              height: he * .6,
                              child: Image.asset(
                                'assets/images/nothing-found.jpg',
                              ),
                            ),
                          )
                        : Consumer<WallpaperProvider>(
                            builder: ((context, value, child) => Expanded(
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
                                          itemCount: value.wallpaperModel
                                                  ?.photos?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            return Hero(
                                              tag: value
                                                  .wallpaperModel!
                                                  .photos![index]
                                                  .src!
                                                  .portrait!,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    ImageView.routeName,
                                                    arguments: value
                                                        .wallpaperModel!
                                                        .photos![index]
                                                        .src!
                                                        .portrait!,
                                                  );
                                                },
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
                                              ),
                                            );
                                          })),
                                )),
                          ),
          ],
        )

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
    var wallpaperData = Provider.of<WallpaperProvider>(context, listen: false);
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
          Future.delayed(Duration(seconds: 1)).then((value) {
            if (item.text != '')
              Provider.of<WallpaperProvider>(context, listen: false)
                  .searchWallpaper(item.text);
          });
        },
        onSubmitted: (_) {
          Provider.of<WallpaperProvider>(context, listen: false)
              .searchWallpaper(item.text);
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

