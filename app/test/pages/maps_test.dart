import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppBar widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppWidget());

    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);

    final appBarWidget = tester.widget<AppBar>(appBarFinder);
    expect(appBarWidget.backgroundColor, Colors.blue);

    // Other assertions for AppBar properties...
  });

  

  testWidgets('FloatingActionButton widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MyAppWidget());

    final fabFinder = find.byType(FloatingActionButton);
    expect(fabFinder, findsOneWidget);

    final fabWidget = tester.widget<FloatingActionButton>(fabFinder);
    expect(fabWidget.onPressed, isA<Function>());
    expect(find.byIcon(Icons.feedback), findsOneWidget);
  });
}

class MyAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          // Other AppBar properties...
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          color: Colors.grey,
          child: Center(
            child: Text('GoogleMap Placeholder'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/feedback');
          },
          child: Icon(Icons.feedback),
        ),
      ),
    );
  }
}
