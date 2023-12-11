import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/services/auth_service.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';

import 'package:app/pages/signup_page.dart';  // Import your actual SignupPage widget

void main() async {
   // Initialize Firebase before running tests
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });
  testWidgets('Signup page UI and functionality test', (tester) async {
    final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    final MockFirestoreInstance mockFirestore = MockFirestoreInstance();
    final AuthService authService = AuthService(
      auth: mockFirebaseAuth,
      firestore: mockFirestore,
    );
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: SignupPage(authService: authService),  // Use the actual SignupPage widget here
      ),
      await Future.delayed(Duration(seconds: 5)),
    );

    // Find widgets on the signup page
    final signUpTextFinder = find.text('Sign Up');
    final fullNameFieldFinder = find.widgetWithText(TextFormField, 'Full Name');
    final emailFieldFinder = find.widgetWithText(TextFormField, 'Email');
    final passwordFieldFinder = find.widgetWithText(TextFormField, 'Password');
    final signUpButtonFinder = find.text('Sign Up');
    final loginTextFinder = find.text('Already have an account?');
    final loginButtonFinder = find.text('Login');

    // Verify that the required widgets are present on the signup page
    expect(signUpTextFinder, findsOneWidget);
    expect(fullNameFieldFinder, findsOneWidget);
    expect(emailFieldFinder, findsOneWidget);
    expect(passwordFieldFinder, findsOneWidget);
    expect(signUpButtonFinder, findsOneWidget);
    expect(loginTextFinder, findsOneWidget);
    expect(loginButtonFinder, findsOneWidget);

    // Perform tap and enter data to simulate a signup action
    await tester.enterText(fullNameFieldFinder, 'John Doe');
    await tester.enterText(emailFieldFinder, 'john.doe@example.com');
    await tester.enterText(passwordFieldFinder, 'password123');
    await tester.tap(signUpButtonFinder);

    // Allow time for the async signup action to complete
    await tester.pumpAndSettle();

    // Verify the navigation to the login page after successful signup
    expect(find.text('Login Page'), findsOneWidget);

    // TODO: Add more tests based on your requirements, such as testing error cases, loading state, etc.
  });
}
