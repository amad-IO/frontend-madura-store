import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kasirmadura/main.dart'; // sesuaikan dengan name di pubspec.yaml

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const KasirMaduraApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
