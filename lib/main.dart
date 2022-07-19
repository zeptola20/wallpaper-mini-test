import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:unsplash/Provider/category_Provider.dart';
import 'package:unsplash/Provider/wallpaper_Provider.dart';
import 'package:unsplash/screens/home_screen.dart';
import 'package:unsplash/screens/imageView_screen.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        ImageView.routeName: (context) => ImageView(),
      },
      theme: ThemeData(
        textTheme: TextTheme(headline6: TextStyle(color: Color(0xFF060607))),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
