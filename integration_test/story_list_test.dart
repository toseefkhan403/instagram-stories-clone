import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_stories/data/stories_repository.dart';
import 'package:instagram_stories/domain/story.dart';
import 'package:instagram_stories/presentation/widgets/story_list.dart';
import 'package:instagram_stories/presentation/widgets/story_view.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStoriesRepository extends Mock implements StoriesRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FutureProvider<List<Story>>((ref) async => []));
  });

  testWidgets('StoryList displays stories and navigates to StoryView',
      (WidgetTester tester) async {
    final mockRepository = MockStoriesRepository();

    // Sample stories data
    final stories = [
      Story(imageUrl: 'https://example.com/image1.jpg', title: 'Story 1'),
      Story(imageUrl: 'https://example.com/image2.jpg', title: 'Story 2'),
    ];

    // mock repository to return the sample stories
    when(() => mockRepository.fetchStories()).thenAnswer((_) async => stories);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storiesProvider.overrideWithProvider(
            FutureProvider((ref) async => stories),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: StoryList(),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    expect(find.text('Story 1'), findsOneWidget);
    expect(find.text('Story 2'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsNWidgets(2));

    // tap on the first story and verify navigation to StoryView
    await tester.tap(find.text('Story 1'));
    await tester.pumpAndSettle();
    expect(find.byType(StoryView), findsOneWidget);
    expect(find.text('Story 1'), findsOneWidget);
  });

  testWidgets('StoryList displays error message on error',
      (WidgetTester tester) async {
    final mockRepository = MockStoriesRepository();

    when(() => mockRepository.fetchStories())
        .thenThrow(Exception('Failed to load stories'));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storiesProvider.overrideWithProvider(
            FutureProvider(
                (ref) async => throw Exception('Failed to load stories')),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: StoryList(),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(
        find.text('Error: Exception: Failed to load stories'), findsOneWidget);
  });
}
