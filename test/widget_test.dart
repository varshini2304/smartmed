import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartmed/app.dart';

void main() {
  testWidgets('SmartMed app loads login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartMedApp());

    // Check if login screen elements exist
    expect(find.byType(TextField), findsWidgets); // email/password fields
    // Use a more specific finder to avoid ambiguity for the Login button
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });
}
