import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_photos/photos_model.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({
    super.key,
    required this.photos,
  });

  final Photos photos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(
        children: [
          Hero(
            tag: photos.title,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const CupertinoActivityIndicator(),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: photos.url,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: ListTile(
              title: const Text("Id"),
              subtitle: Text(photos.id.toString()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: ListTile(
              title: const Text("Album Id"),
              subtitle: Text(photos.albumId.toString()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: ListTile(
              title: const Text("Title"),
              subtitle: Text(photos.title.toString()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
