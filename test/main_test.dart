import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_stories/presentation/widgets/story_list.dart';
import 'package:instagram_stories/main.dart';

void main() {
  testWidgets('StoriesApp displays title and StoryList widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: StoriesApp()));

    // Verify the AppBar is present
    expect(find.byType(AppBar), findsOneWidget);

    // Verify the app title is displayed
    expect(find.text('Instagram Stories Clone'), findsOneWidget);

    // Verify the StoryList widget is present in the widget tree
    expect(find.byType(StoryList), findsOneWidget);
  });
}
