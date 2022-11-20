import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_photos/detail_page.dart';
import 'package:json_photos/photos_model.dart';
import 'package:json_photos/providers.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JSON Photos"),
      ),
      body: ref.watch(getPhotosProvider).when(
            data: (data) {
              return NarrowView(
                data: data,
              );
            },
            error: (error, stacktrace) => Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(error.toString()),
              ),
            ),
            loading: () => const Center(
              child: CupertinoActivityIndicator(
                radius: 30,
              ),
            ),
          ),
    );
  }
}

class NarrowView extends StatelessWidget {
  const NarrowView({Key? key, required this.data}) : super(key: key);

  final List<Photos> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: const Text("Detail"),
                    ),
                    body: DetailPage(
                      photos: data[index],
                    ),
                  ),
                ),
              ),
              child: Card(
                child: ListTile(
                  leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: Hero(
                      tag: data[index].title,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const CupertinoActivityIndicator(),
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: data[index].url,
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: Text(data[index].title),
                ),
              ),
            ),
          );
        });
  }
}
