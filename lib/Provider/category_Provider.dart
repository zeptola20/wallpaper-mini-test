import 'package:flutter/material.dart';

import 'package:unsplash/models/categori_model.dart';

class CategoryProvider with ChangeNotifier {
  final List<CategoryModel> _catList = [
    CategoryModel(
        catName: 'Fashion',
        imageUrl:
            'https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        id: 1),
    CategoryModel(
        catName: 'Sky',
        imageUrl:
            'https://images.pexels.com/photos/844297/pexels-photo-844297.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        id: 2),
    CategoryModel(
        catName: 'Moon',
        imageUrl:
            'https://images.pexels.com/photos/47367/full-moon-moon-bright-sky-47367.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        id: 3),
    CategoryModel(
        catName: 'Sea',
        imageUrl:
            'https://images.pexels.com/photos/1001682/pexels-photo-1001682.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        id: 4),
    CategoryModel(
        catName: 'Stars',
        imageUrl:
            'https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        id: 5),
    CategoryModel(
        catName: 'Girl',
        imageUrl:
            'https://images.pexels.com/photos/1758144/pexels-photo-1758144.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        id: 6),
    CategoryModel(
        catName: 'City',
        imageUrl:
            'https://images.pexels.com/photos/1034662/pexels-photo-1034662.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        id: 7),
  ];
  List<CategoryModel> get catList {
    return [..._catList];
   
  }
}
