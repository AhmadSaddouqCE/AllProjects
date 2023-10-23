import 'dart:convert';
import 'package:http/http.dart' as http;

class Category {

  final String name;
  final int numOfCourses;
  
  final String image;

  Category(this.name, this.numOfCourses, this.image);

 
}


  

List<Category> categories = categoriesData
    .map((item) => Category(item['name'] as String, item['courses'] as int,
        item['image'] as String))
    .toList();

    

var categoriesData =
 [
  {"name": "Violin",'courses': 17, 'image': "images/playing-guitar.jpg"},
  {"name": "Piano", 'courses': 25, 'image': "images/playing-piano.jpg"},
  {"name": "Violin", 'courses': 13, 'image': "images/playing-violin.jpg"},
  {"name": "Oud", 'courses': 17, 'image': "images/playing-oud.jpg"},
  {"name": "Voice", 'courses': 10, 'image': "images/Voice.jpg"},
];
