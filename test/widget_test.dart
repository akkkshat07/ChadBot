import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ChadBot/helper/pref.dart'; // Adjust the import according to your project structure

// Define a simple MyApp widget for testing
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Forward key to super constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            Pref.showOnboarding ? 'Onboarding' : 'Home',
          ),
        ),
      ),
    );
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open the box for tests
  await Hive.initFlutter();
  await Pref.initialize(); // Make sure the Pref class initializes properly

  // Set initial preferences if needed
  Pref.showOnboarding = true; // Adjust as necessary for your test scenario

  testWidgets('Onboarding text displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the correct text is shown based on the onboarding preference
    expect(find.text('Onboarding'), findsOneWidget);
  });
}
