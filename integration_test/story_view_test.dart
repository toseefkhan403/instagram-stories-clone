import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_stories/domain/story.dart';
import 'package:instagram_stories/presentation/widgets/story_view.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('StoryView displays stories and progress',
      (WidgetTester tester) async {
    final stories = [
      Story(imageUrl: 'https://picsum.photos/400/400', title: 'Story 1'),
      Story(imageUrl: 'https://picsum.photos/500/500', title: 'Story 2'),
    ];

    await mockNetworkImages(() async => tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: StoryView(stories: stories, initialIndex: 0),
            ),
          ),
        ));

    expect(find.text('Story 1'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    // tapping on the right side to go to the next story
    final size = tester.getSize(find.byType(Scaffold));
    await tester.tapAt(Offset(size.width * 0.8, size.height * 0.5));
    await tester.pumpAndSettle();

    // verify the next story is displayed
    expect(find.text('Story 2'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    // tap left
    await tester.tapAt(Offset(size.width * 0.2, size.height * 0.5));
    await tester.pumpAndSettle();

    expect(find.text('Story 1'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('StoryView auto moves to next page after 5 seconds',
      (WidgetTester tester) async {
    final stories = [
      Story(imageUrl: 'https://picsum.photos/400/400', title: 'Story 1'),
      Story(imageUrl: 'https://picsum.photos/500/500', title: 'Story 2'),
    ];

    await mockNetworkImages(() async => tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: StoryView(stories: stories, initialIndex: 0),
            ),
          ),
        ));

    expect(find.text('Story 1'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Story 2'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
