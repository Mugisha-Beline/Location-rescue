import 'package:app/pages/feedback_page.dart'; // Adjust the import path based on your actual project structure
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FeedbackPage widget test', (WidgetTester tester) async {
    // Step 2: Build the widget using the WidgetTester.
    await tester.pumpWidget(MaterialApp(
      home: FeedbackPage(),
    ));

    // Step 3: Search for the widget using a Finder.
    final titleFinder = find.text('FEEDBACK FORM');
    final buttonFinder = find.text('CREATE FEEDBACK');

    // Step 4: Verify the widget using a Matcher.
    expect(titleFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);

    // Additional verification steps if needed
    // For example, you can check the initial state of text fields, controllers, etc.

    // Optional: Print the widget tree for debugging
    debugDumpApp();
  });
}
