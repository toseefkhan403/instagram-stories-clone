import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_stories/presentation/widgets/story_list.dart';

void main() {
  runApp(const ProviderScope(child: StoriesApp()));
}

class StoriesApp extends StatelessWidget {
  const StoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Instagram Stories Clone',
            style: TextStyle(fontFamily: 'Instagram-Font'),
          ),
        ),
        body: const StoryList(),
      ),
    );
  }
}
