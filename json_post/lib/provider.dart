import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:json_post/post_model.dart';

final postListProvider = FutureProvider<List>(
  (ref) async {
    final res =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    List<Post> posts = [];
    if (res.statusCode == 200) {
      for (var element in jsonDecode(res.body)) {
        posts.add(Post.fromJSON(element));
      }
    } else {
      throw Exception('Failure');
    }
    return posts;
  },
);
