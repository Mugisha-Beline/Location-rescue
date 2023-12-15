import 'package:app/main.dart';
import 'package:app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 // Adjust import based on your project structure

void main() {

  testWidgets('TextFormField displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email cannot be empty';
              }
              return null;
            },
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
    // Add more specific tests for TextFormField if needed
  });

  testWidgets('Password TextFormField displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextFormField(
            controller: TextEditingController(),
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password cannot be empty';
              }
              return null;
            },
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
    // Add more specific tests for TextFormField if needed
  });

  testWidgets('Login ElevatedButton displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFe6aa07),
              minimumSize: const Size(double.infinity, 50.0),
            ),
            child: const Text('Login'),
          ),
        ),
      ),
    );

    expect(find.text('Login'), findsOneWidget);
    // Add more specific tests for the ElevatedButton if needed
  });

  testWidgets('Forgot Password TextButton displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextButton(
            onPressed: () {
              print('forgot password');
              // Add forgot password logic here
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Forgot Password?'), findsOneWidget);
    // Add more specific tests for the TextButton if needed
  });

  testWidgets('Text widget displays "Don\'t have an account?" correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 20.0),
              const Text(
                'Don\'t have an account?',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text("Don't have an account?"), findsOneWidget);
    // Add more specific tests for the Text widget if needed
  });


}
