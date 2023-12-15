import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/pages/signup_page.dart'; // Adjust import based on your actual project structure
import 'package:app/services/auth_service.dart';

void main() {
  testWidgets('SignupPage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SignupPage(authService: AuthService()),
      ),
    );

    final appBarTitleFinder = find.text('Sign Up Page');
    final cardElevationFinder = find.byType(Card).first;

    expect(appBarTitleFinder, findsOneWidget);
    expect(
      tester.widget<Card>(cardElevationFinder).elevation,
      equals(15.0),
    );
  });

  testWidgets('SignupForm widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SignupForm(authService: AuthService()),
        ),
      ),
    );

    final fullNameTextFieldFinder = find.byType(TextFormField).at(0);
    final emailTextFieldFinder = find.byType(TextFormField).at(1);
    final passwordTextFieldFinder = find.byType(TextFormField).at(2);
    final signUpButtonFinder = find.byType(ElevatedButton);

    expect(fullNameTextFieldFinder, findsOneWidget);
    expect(emailTextFieldFinder, findsOneWidget);
    expect(passwordTextFieldFinder, findsOneWidget);
    expect(signUpButtonFinder, findsOneWidget);
  });

  testWidgets('ElevatedButton widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SignupForm(authService: AuthService()),
        ),
      ),
    );

    final elevatedButtonFinder = find.byType(ElevatedButton);

    expect(elevatedButtonFinder, findsOneWidget);

    final elevatedButtonWidget = tester.widget<ElevatedButton>(elevatedButtonFinder);
    expect(elevatedButtonWidget.onPressed, isA<Function>());
    expect(elevatedButtonWidget.style, isInstanceOf<ButtonStyle>());
    expect(elevatedButtonWidget.style?.backgroundColor, Color(0xFFe6aa07));
    expect(elevatedButtonWidget.style?.minimumSize, const Size(double.infinity, 50.0));
  });

  testWidgets('Text widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppWidget());

    final textWidgetFinder = find.text('Already have an account?');

    expect(textWidgetFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(textWidgetFinder);
    expect(textWidget.style?.color, Colors.teal);
  });

  testWidgets('TextButton widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppWidget());

    final textButtonFinder = find.text('login');

    expect(textButtonFinder, findsOneWidget);

    final textButtonWidget = tester.widget<TextButton>(textButtonFinder);
    expect(textButtonWidget.onPressed, isA<Function>());
    expect(find.text('login'), findsOneWidget);

    final textWidget = tester.widget<Text>(find.text('login'));
    expect(textWidget.style?.color, Colors.teal);
  });
}

class MyAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _loading ? null : _signUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFe6aa07),
              minimumSize: const Size(double.infinity, 50.0),
            ),
            child: _loading ? const CircularProgressIndicator() : const Text('Sign Up'),
          ),
        ),
      ),
    );
  }

  bool _loading = false;

  void _signUp() {
    // Implement the sign-up logic here
  }
}
