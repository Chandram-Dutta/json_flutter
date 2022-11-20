import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_post/provider.dart';
import 'package:json_post/routes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'JSON Posts',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
          brightness: Brightness.dark,
        ),
      ),
      routerConfig: router,
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Posts'),
        actions: [
          IconButton(
            onPressed: () => ref.refresh(postListProvider.future),
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
      body: ref.watch(postListProvider).when(
            data: (data) {
              return RefreshIndicator(
                onRefresh: () => ref.refresh(postListProvider.future),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(data[index].title),
                          subtitle: Text(data[index].body),
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                ),
              );
            },
            error: (error, stacktrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            loading: () => Center(
              child: CupertinoActivityIndicator(
                radius: 30,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
    );
  }
}
