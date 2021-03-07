import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito_pract/main.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito_pract/fetch_from_db.dart';

import 'test_get_data.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test('returns a Map if there is no error', () async {
    http.Client mockitoExample = MockitoExample();

    when(mockitoExample.get('https://jsonplaceholder.typicode.com/posts/1'))
        .thenAnswer((value) async {
      return http.Response('{"title": "Test"}', 200);
    });

    expect(await fetchFromDatabase(mockitoExample), isA<Map>());
  });

  test('gives us an exception if we get error in our http call', () {
    final mockitoExample = MockitoExample();

    when(mockitoExample.get('https://jsonplaceholder.typicode.com/posts/1'))
        .thenAnswer((value) async {
      return http.Response('Not Found', 404);
    });

    expect(fetchFromDatabase(mockitoExample), throwsException);
  });
}
