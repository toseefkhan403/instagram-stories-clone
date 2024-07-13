import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagram_stories/data/stories_repository.dart';
import 'package:instagram_stories/presentation/widgets/story_view.dart';

class StoryList extends ConsumerWidget {
  const StoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storiesAsyncValue = ref.watch(storiesProvider);

    return storiesAsyncValue.when(
      data: (stories) {
        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StoryView(stories: stories, initialIndex: index)),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        margin: const EdgeInsets.all(4.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.purple,
                              Colors.pink,
                              Colors.orange,
                              Colors.yellow
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: CachedNetworkImageProvider(
                                stories[index].imageUrl),
                          ),
                        ),
                      ),
                      Text(
                        stories[index].title,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
