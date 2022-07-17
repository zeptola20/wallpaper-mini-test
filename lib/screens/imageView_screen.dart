import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:unsplash/Provider/wallpaper_Provider.dart';
import 'package:unsplash/screens/home_screen.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key}) : super(key: key);
  static const routeName = '/pageRooute';

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    final data = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      body: Stack(children: [
        Hero(
            tag: data,
            child: SizedBox(
              height: he,
              width: wi,
              child: Image.network(
                data,
                fit: BoxFit.cover,
              ),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FutureBuilder(
                    future: loading
                        ? Provider.of<WallpaperProvider>(context,listen: false)
                            .saveGallery(data)
                        : null,
                    builder: (context, snopshot) {
                      if (snopshot.connectionState == ConnectionState.done) {
                        return elevateButton(context, ' Saved', false);
                      } else if (snopshot.connectionState ==
                          ConnectionState.none) {
                        return elevateButton(context, 'Save to Gallery', false);
                      } else if (snopshot.connectionState ==
                          ConnectionState.waiting) {
                        return   elevateButton(context, 'Saving..', false);
                      } else if (snopshot.hasError) {
                       return elevateButton(context, 'Save to Gallery', true);
                      }
                      return SizedBox();
                    }),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF05a081))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Color(0xFF060607)),
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  ElevatedButton elevateButton(BuildContext context, String text, bool temp) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF05a081))),
        onPressed: () async {
          setState(() {
            loading = true;
          });
          if (temp) {
            const snakBar = SnackBar(content: Text('failed!'));
            ScaffoldMessenger.of(context).showSnackBar(snakBar);
          }
        },
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ));
  }
}
