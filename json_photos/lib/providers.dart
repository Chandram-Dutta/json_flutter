import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_photos/photos_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Future<List<Photos>> getPhotos(GetPhotosRef ref) async {
  final res =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
  List<Photos> photosList = [];
  if (res.statusCode == 200) {
    for (var photos in jsonDecode(res.body)) {
      photosList.add(Photos.fromJson(photos));
    }
  } else {
    Exception("Failure");
  }

  return photosList;
}
