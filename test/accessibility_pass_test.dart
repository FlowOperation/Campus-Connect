import 'package:campus_connect/app/theme/app_theme.dart';
import 'package:campus_connect/features/auth/presentation/screens/signup_screen.dart';
import 'package:campus_connect/features/posts/presentation/screens/home_screen.dart';
import 'package:campus_connect/models/post_model.dart';
import 'package:campus_connect/providers/auth_provider.dart';
import 'package:campus_connect/providers/post_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp(Widget child, {double textScale = 1.0}) {
    return MaterialApp(
      theme: AppTheme.light,
      builder: (context, widget) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: TextScaler.linear(textScale)),
          child: widget!,
        );
      },
      home: child,
    );
  }

  Widget buildScopedTestApp(
    Widget child, {
    required List<Object> overrides,
    double textScale = 1.0,
  }) {
    return ProviderScope(
      overrides: overrides.cast(),
      child: buildTestApp(child, textScale: textScale),
    );
  }

  testWidgets('home screen keeps key controls usable at large text sizes', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpWidget(
        buildScopedTestApp(
          const HomeScreen(),
          textScale: 1.8,
          overrides: [
            authStateProvider.overrideWith(
              (ref) => Stream<firebase_auth.User?>.value(null),
            ),
            postsProvider.overrideWith((ref) => Stream.value(<Post>[])),
          ],
        ),
      );
      await tester.pump();

      expect(find.bySemanticsLabel('Open profile'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Filter posts by all categories'),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel('Filter posts by Notes'), findsOneWidget);
      expect(find.text('No posts found'), findsOneWidget);
      expect(tester.takeException(), isNull);
    } finally {
      semantics.dispose();
    }
  });

  testWidgets(
    'signup screen exposes password visibility semantics at large text sizes',
    (tester) async {
      final semantics = tester.ensureSemantics();
      try {
        await tester.pumpWidget(
          ProviderScope(
            child: buildTestApp(const SignupScreen(), textScale: 1.8),
          ),
        );
        await tester.pump();

        expect(find.byTooltip('Show password'), findsOneWidget);
        expect(find.byTooltip('Show confirm password'), findsOneWidget);
        expect(find.text('Join the FAST student community'), findsOneWidget);

        await tester.tap(find.byTooltip('Show password'));
        await tester.pump();

        expect(find.byTooltip('Hide password'), findsOneWidget);
        expect(tester.takeException(), isNull);
      } finally {
        semantics.dispose();
      }
    },
  );
}
