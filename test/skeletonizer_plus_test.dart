import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skeletonizer_plus/skeletonizer_plus.dart';

void main() {
  group('SkeletonizerPlus', () {
    testWidgets('shows skeleton when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonizerPlus(
              enabled: true,
              child: const Text('Hello World'),
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonizerPlus), findsOneWidget);
    });

    testWidgets('hides skeleton when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonizerPlus(
              enabled: false,
              child: const Text('Hello World'),
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
            body: SkeletonizerPlus.custom(
              enabled: true,
              bones: const [
                BoneText(words: 3),
                BoneCircle(radius: 20),
                BoneRect(width: 100, height: 20),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonizerPlus), findsOneWidget);
    });

    testWidgets('applies theme colors correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            body: SkeletonizerPlus(
              enabled: true,
              child: const Text('Test'),
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonizerPlus), findsOneWidget);
    });

    testWidgets('respects clipToBounds', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonizerPlus(
              enabled: true,
              clipToBounds: true,
              child: const Text('Test'),
            ),
          ),
        ),
      );

      expect(find.byType(ClipRect), findsOneWidget);
    });
  });

  group('Bone Types', () {
    testWidgets('BoneText renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonizerPlus.custom(
              enabled: true,
              bones: const [BoneText(words: 3, lines: 2)],
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonizerPlus), findsOneWidget);
    });

    testWidgets('BoneCircle renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonizerPlus.custom(
              enabled: true,
              bones: const [BoneCircle(radius: 20)],
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonizerPlus), findsOneWidget);
    });

    testWidgets('BoneRect renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonizerPlus.custom(
              enabled: true,
              bones: const [BoneRect(width: 100, height: 50)],
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonizerPlus), findsOneWidget);
    });

    testWidgets('BoneIcon renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonizerPlus.custom(
              enabled: true,
              bones: const [BoneIcon(size: 24)],
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonizerPlus), findsOneWidget);
    });
  });

  group('AnimationConfig', () {
    test('creates config with default values', () {
      const config = AnimationConfig();
      expect(config.speed, const Duration(milliseconds: 1200));
      expect(config.direction, ShimmerDirection.ltr);
      expect(config.loop, true);
    });

    test('creates config with custom values', () {
      final config = AnimationConfig(
        speed: const Duration(milliseconds: 2000),
        direction: ShimmerDirection.rtl,
        loop: false,
        loopCount: 5,
      );
      expect(config.speed, const Duration(milliseconds: 2000));
      expect(config.direction, ShimmerDirection.rtl);
      expect(config.loop, false);
      expect(config.loopCount, 5);
    });

    test('copyWith creates new config', () {
      const config = AnimationConfig();
      final newConfig = config.copyWith(
        speed: const Duration(milliseconds: 3000),
      );
      expect(newConfig.speed, const Duration(milliseconds: 3000));
      expect(newConfig.direction, config.direction);
    });
  });
}

