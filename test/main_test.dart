import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_stories/presentation/widgets/story_list.dart';
import 'package:instagram_stories/main.dart';

void main() {
  testWidgets('StoriesApp displays title and StoryList widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: StoriesApp()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Instagram Stories Clone'), findsOneWidget);
    expect(find.byType(StoryList), findsOneWidget);
  });
}
