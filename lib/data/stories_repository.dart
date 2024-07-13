import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:instagram_stories/domain/story.dart';

class StoriesRepository {
  final String endpoint = "https://api.npoint.io/cb8586681795a333feda";

  Future<List<Story>> fetchStories() async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List<dynamic> storiesData = json.decode(response.body);
      return storiesData.map((data) => Story.fromMap(data)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }
}

final storiesRepositoryProvider =
    Provider<StoriesRepository>((ref) => StoriesRepository());

final storiesProvider = FutureProvider<List<Story>>((ref) async {
  final storiesRepository = ref.read(storiesRepositoryProvider);
  return storiesRepository.fetchStories();
});
