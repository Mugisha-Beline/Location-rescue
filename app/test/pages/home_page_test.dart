import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  testWidgets('Scaffold widget displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget());

    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('AppBar displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget());

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('Body container displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget());

    expect(find.byType(Container), findsOneWidget);
  });

  testWidgets('Column displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget());

    expect(find.byType(Column), findsOneWidget);
  });

  
}

Widget buildTestWidget() {
  return MaterialApp(
    home: Scaffold(
      appBar: buildAppBar(MockBuildContext()),
      body: buildBody(MockBuildContext()),
    ),
  );
}

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.menu),
    ),
    title: const Text('Home'),
  );
}

Widget buildBody(BuildContext context) {
  return Column(
    children: [
      Container(),
      // Add your other widgets here
      ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.search, color: Colors.black),
        label: Text('Search'),
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFFe6aa07),
        ),
      ),
    ],
  );
}
