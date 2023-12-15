import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/app/modules/home/views/welcome_page.dart';
import 'package:travel_app/widgets/responsive_button.dart';
// Sesuaikan dengan path file welcome_page.dart
void main() {
  testWidgets('WelcomePage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: WelcomePage(),
    ));

    // Verify that the welcome text is displayed.
    expect(find.text('Trips'), findsOneWidget);
    expect(find.text('Mountain'), findsOneWidget);
    expect(
        find.text(
            'Mountain hikes you an incredible sense of freedom along with endurance test'),
        findsOneWidget);

    // Verify that the button is displayed.
    expect(find.byType(ResponsiveButton), findsOneWidget);

    // Verify that the dots are displayed.
    expect(
        find.byType(Container),
        findsNWidgets(
            8)); // Update the expected count based on your actual UI structure.

    // You can add more test cases based on your specific UI interactions and expectations.
  });
}