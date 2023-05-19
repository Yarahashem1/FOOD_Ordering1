import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_screens/category.dart';
import 'package:flutter_application_1/login/cubit/cubit.dart';
import 'package:flutter_application_1/login/login1.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  group('Social Login Screen', () {
    late SocialLoginCubit cubit;
    final testEmail = 'lolos@gmail.com';
    final testPassword = 'lolo@123456';
    setUp(() {
      cubit = SocialLoginCubit();
    });
    setUpAll(() => () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
    });

    testWidgets('Email and Password field validation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SocialLoginCubit>.value(
            value: cubit,
            child: SocialLoginScreen(),
          ),
          // Add routes for navigation

        ),
      );
      final emailField = find.byKey(ValueKey('emailField'));
      final passwordField = find.byKey(ValueKey('passwordField'));
      final loginButton = find.byKey(ValueKey('loginButton'));
      await tester.enterText(emailField, testEmail);
      await tester.enterText(passwordField, testPassword);

      // Tap login button
      await tester.tap(loginButton);
      await tester.pumpAndSettle(); // Wait for navigation to complete

      // Verify navigation to CategoryScreen
      expect(find.byType(Category), findsOneWidget);
    });
  });
}