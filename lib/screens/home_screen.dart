import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:unsplash/Provider/wallpaper_Provider.dart';
import 'package:unsplash/Widgets/search_box.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var apiData = Get.put(WallpaperProvider());
  @override
  void initState() {
    super.initState();
    apiData.randomPhoto();
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
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
            SearchBox(),
            GetX<WallpaperProvider>(builder: (controller) {
              return controller.loading.value
                  ? const Padding(
                      padding: EdgeInsets.only(top: 80.0),
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child:
                              CircularProgressIndicator(color: Colors.green)),
                    )
                  : Expanded(
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
                                  controller.wallpaperModel?.photos?.length ??
                                      0,
                              itemBuilder: (context, index) {
                                return Hero(
                                  tag: controller.wallpaperModel!.photos![index]
                                      .src!.portrait
                                      .toString(),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        controller.wallpaperModel!
                                            .photos![index].src!.portrait!,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      )),
                                );
                              })),
                    );
            })
          ],
        ));
  }
}







  // FutureBuilder(
            //     future: apiData.randomPhoto(),
            //     builder: (context, AsyncSnapshot<dynamic> snopshot) {
            //       if (snopshot.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       } else if (snopshot.connectionState == ConnectionState.done) {
            //         if (apiData.error.value) {
            //           return Padding(
            //             padding: const EdgeInsets.all(16.0),
            //             child: CustomErrorWidget(
            //                 wi: wi, he: he, wallpaperData: apiData),
            //           );
            //         } else if (snopshot.hasData) {
            //           return Expanded(
            //             child: Container(
            //                 margin: const EdgeInsets.only(top: 10, bottom: 10),
            //                 padding: const EdgeInsets.symmetric(horizontal: 16),
            //                 child: GridView.builder(
            //                     shrinkWrap: true,
            //                     gridDelegate:
            //                         SliverGridDelegateWithFixedCrossAxisCount(
            //                       crossAxisCount: Platform.isWindows ? 3 : 2,
            //                       childAspectRatio: .6,
            //                       mainAxisSpacing: 10,
            //                       crossAxisSpacing: 10,
            //                     ),
            //                     itemCount: snopshot.data?.totalResults - 1 ?? 0,
            //                     itemBuilder: (context, index) {
            //                       return Hero(
            //                         tag: snopshot
            //                             .data!.photos![index].src!.portrait
            //                             .toString(),
            //                         child: ClipRRect(
            //                             borderRadius: BorderRadius.circular(10),
            //                             child: Image.network(
            //                               snopshot.data!.photos![index].src!
            //                                   .portrait!,
            //                               fit: BoxFit.cover,
            //                               filterQuality: FilterQuality.high,
            //                             )),
            //                       );
            //                     })),
            //           );
            //         }
            //       }
            //       return const Text("hi");
            //     }),