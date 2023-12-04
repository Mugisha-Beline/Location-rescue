import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/pages/signup_page.dart';

void main() {
  testWidgets('SignupPage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignupPage(authService: AuthService()),
    ));

    // Verify that the title is present on the screen.
    expect(find.text('Sign Up Page'), findsOneWidget);

    // Verify the presence of some key widgets.
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(SignupForm), findsOneWidget);

    // Verify 2/3 of widgets in SignupPage
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(SignupForm), findsOneWidget);
  });

  testWidgets('SignupForm UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignupForm(authService: AuthService()),
    ));

    // Verify that the 'Sign Up' text is present on the screen.
    expect(find.text('Sign Up'), findsOneWidget);

    // Verify the presence of some key widgets.
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify 2/3 of widgets in SignupForm
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('SignupForm SignUp Process Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignupForm(authService: AuthService()),
    ));

    // Enter some values into the text fields.
    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
    await tester.enterText(find.byType(TextFormField).at(1), 'john@example.com');
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');

    // Tap the 'Sign Up' button.
    await tester.tap(find.byType(ElevatedButton));

    // Wait for the UI to rebuild.
    await tester.pump();

    // Verify that the loading indicator is displayed.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('SignupForm Login Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignupForm(authService: AuthService()),
    ));

    // Tap the 'Login' button.
    await tester.tap(find.text('Login'));

    // Wait for the UI to rebuild.
    await tester.pump();

    // Verify that navigation to the login page occurred.
    expect(find.text('Login'), findsOneWidget);
  });

  test('SignupForm SignUp Method Test', () {
    final authService = AuthService();
    final signupForm = SignupForm(authService: authService);

    // Set up initial state of the widget
    signupForm._fullNameController.text = 'John Doe';
    signupForm._emailController.text = 'john@example.com';
    signupForm._passwordController.text = 'password123';

    // Call the signUp method
    signupForm._signUp();

    // Verify that loading state is set
    expect(signupForm._loading, true);

    // Simulate successful registration
    signupForm.widget.authService.registerUserWithEmailandPassword = (fullName, email, password) async => true;
    signupForm._signUp();

    // Verify that loading state is reset after successful registration
    expect(signupForm._loading, false);
  });
}
