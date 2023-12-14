import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/app/modules/home/views/welcome_page.dart';
 // Sesuaikan dengan path file welcome_page.dart

void main() async {
  setUpAll() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  testWidgets('Welcome page renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: WelcomePage(),
    ));

    // Verify that the welcome page renders correctly.
    expect(find.text('Trips'), findsOneWidget);
    expect(find.text('Mountain'), findsOneWidget);
    // Add more expectations based on your UI elements.

    // You can also perform interactions and test the result.
    // For example, if you want to tap the GestureDetector:
    

    // Add expectations based on the changes caused by the interaction.
  });
}
