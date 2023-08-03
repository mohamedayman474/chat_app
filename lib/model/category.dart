import 'package:flutter/foundation.dart';

class Category{
  static String musicId='music';
  static String moviesId='movies';
  static String sportsId='sports';
  String id;
 late String image;
  late String title;
  Category(this.id,this.image,this.title);
  Category.fromId(this.id){
    image='assets/images/$id.png';
    title=id;
  }
  static List<Category> getCategories(){
    return [
      Category.fromId(musicId),
    Category.fromId(moviesId),
    Category.fromId(sportsId)
    ];
  }
}