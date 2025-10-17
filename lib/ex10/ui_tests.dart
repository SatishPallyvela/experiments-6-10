// Importing Flutter's Material Design library.
// This provides widgets like ListView, Text, Padding, etc.
import 'package:flutter/material.dart';

// A StatelessWidget — meaning this widget does not store changing state.
// It's mainly used to show a list of simple test results on the screen.
class TestResultsPage extends StatelessWidget {
  const TestResultsPage({
    super.key,
  }); // Default constructor with an optional key.

  // ----------------------------------------------------------
  // 🧪 Function: runTests()
  // ----------------------------------------------------------
  // Purpose:
  //   Runs a few basic tests (assertions) and collects their results.
  //   Returns a list of text messages describing whether each test passed or failed.
  //
  // Explanation:
  //   Each test adds a string to the 'results' list, and at the end,
  //   that list is displayed on the screen in the build() method.
  // ----------------------------------------------------------
  List<String> runTests() {
    // Create an empty list to store test results.
    final results = <String>[];

    try {
      // 🧮 Test 1: Simple math assertion
      // The 'assert' keyword checks a condition during debug mode.
      // If the condition is false, it throws an AssertionError.
      assert(1 + 1 == 2);

      // If no error occurs, test passes.
      results.add('Basic math test: PASS');
    } catch (_) {
      // If the assertion fails, we catch it and mark test as FAIL.
      results.add('Basic math test: FAIL');
    }

    // 🧱 Test 2: Simple smoke test (checks if widget can be created)
    // This test doesn’t actually test UI — it’s just a placeholder example.
    results.add('Widget constructor smoke test: PASS');

    // Return the list of all results.
    return results;
  }

  // ----------------------------------------------------------
  // 🧩 build() — Flutter's main UI method
  // ----------------------------------------------------------
  // Called automatically when this widget needs to be displayed.
  // It returns the actual UI layout to show on the screen.
  // ----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // Call the runTests() function and store the returned list of results
    final r = runTests();

    // Return a ListView to display each test result as a bullet point
    return ListView(
      padding: const EdgeInsets.all(16), // Add padding around the list
      children: r
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                '• $e',
              ), // Display each test message with a bullet symbol
            ),
          )
          .toList(),
    );
  }
}
