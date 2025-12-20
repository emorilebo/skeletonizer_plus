import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skeletonizer_plus/skeletonizer_plus.dart';

void main() {
  group('SliverSkeletonizerPlus', () {
    testWidgets('shows skeleton when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverSkeletonizerPlus(
                  enabled: true,
                  child: const SliverToBoxAdapter(
                    child: Text('Hello World'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(SliverSkeletonizerPlus), findsOneWidget);
    });

    testWidgets('hides skeleton when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverSkeletonizerPlus(
                  enabled: false,
                  child: const SliverToBoxAdapter(
                    child: Text('Hello World'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('renders custom bones', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverSkeletonizerPlus.custom(
                  enabled: true,
                  bones: const [
                    BoneText(words: 3),
                    BoneCircle(radius: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(SliverSkeletonizerPlus), findsOneWidget);
    });
  });
}


