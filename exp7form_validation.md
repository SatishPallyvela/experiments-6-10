class Validators {
  static String? name(String? v) {
    if (v == null || v.trim().isEmpty) return 'Name required';
    if (v.trim().length < 3) return 'At least 3 characters';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email required';
    final re = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!re.hasMatch(v.trim())) return 'Invalid email';
    return null;
  }

  static String? age(String? v) {
    if (v == null || v.trim().isEmpty) return 'Age required';
    final age = int.tryParse(v.trim());
    if (age == null) return 'Enter a valid number';
    if (age < 10 || age > 100) return 'Age should be between 10 and 100';
    return null;
  }
}
<!-- ========================================================= -->

// This class contains different validation methods for checking
// user input like Name, Email, and Age.
//
// The purpose of this class is to ensure that the user enters
// correct and meaningful data before submitting a form.
//
// Each method in this class is 'static' — which means you can call it
// without creating an object of the class. Example: Validators.name("John");

class Validators {
  // -------------------------------------------------------
  // NAME VALIDATION
  // -------------------------------------------------------
  static String? name(String? v) {
    // First, check if the input 'v' (the name entered by the user)
    // is null or empty.
    // .trim() removes any spaces before or after the text.
    // Example: "  John  " becomes "John"
    if (v == null || v.trim().isEmpty) {
      // If it's empty or null, we return an error message.
      return 'Name required';
    }

    // Now check the length of the name (after trimming spaces).
    // If the name has less than 3 characters, it's too short.
    // Example: "Al" → error
    if (v.trim().length < 3) {
      return 'At least 3 characters';
    }

    // If all checks pass, return null.
    // 'null' here means "no error", i.e. validation successful.
    return null;
  }

  // -------------------------------------------------------
  // EMAIL VALIDATION
  // -------------------------------------------------------
  static String? email(String? v) {
    // Check if email field is empty or null.
    if (v == null || v.trim().isEmpty) {
      return 'Email required';
    }

    // Define a Regular Expression (RegExp) pattern to check
    // whether the email looks valid.
    //
    // Explanation of the pattern:
    // ^           → start of the string
    // [^@\s]+     → one or more characters that are NOT @ or space
    // @           → there must be an "@" symbol
    // [^@\s]+     → again one or more characters (domain name)
    // \.          → there must be a dot (.)
    // [^@\s]+$    → and finally, one or more characters after the dot
    //
    // Example of valid email: user@example.com
    final re = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");

    // If the input email doesn't match this pattern,
    // return an error message.
    if (!re.hasMatch(v.trim())) {
      return 'Invalid email';
    }

    // Otherwise, everything is fine — return null (no error).
    return null;
  }

  // -------------------------------------------------------
  // AGE VALIDATION
  // -------------------------------------------------------
  static String? age(String? v) {
    // Check if age field is empty or null.
    if (v == null || v.trim().isEmpty) {
      return 'Age required';
    }

    // Try to convert (parse) the entered text into an integer.
    // Example: if v = "25", int.tryParse("25") gives 25.
    // If user enters text like "abc", then int.tryParse("abc") gives null.
    final age = int.tryParse(v.trim());

    // If age is null, that means user entered something
    // that cannot be converted to a number.
    if (age == null) {
      return 'Enter a valid number';
    }

    // Now check if the age is within a reasonable range.
    // Here, we are saying valid ages are between 10 and 100.
    if (age < 10 || age > 100) {
      return 'Age should be between 10 and 100';
    }

    // If all conditions are satisfied,
    // return null meaning "valid age".
    return null;
  }
}


<!-- ======================================= -->

import 'package:flutter/material.dart';
import 'form_validation.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: Validators.name,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: Validators.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ageCtrl,
              decoration: const InputDecoration(labelText: 'Age'),
              validator: Validators.age,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final valid = _formKey.currentState?.validate() ?? false;
                    if (valid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form submitted: ${_nameCtrl.text}')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    _nameCtrl.clear();
                    _emailCtrl.clear();
                    _ageCtrl.clear();
                  },
                  child: const Text('Reset'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
===============================================================

// Import the Flutter material package which contains all
// the widgets and UI elements like TextField, Button, etc.
import 'package:flutter/material.dart';

// Import the file where we created our custom validator class.
// This file (form_validation.dart) contains functions that check
// if user inputs like name, email, and age are valid.
import 'form_validation.dart';

// -------------------------------------------------------------
// 1️⃣  This is our main FormPage widget.
// -------------------------------------------------------------
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  // The createState() method creates the mutable (changeable) part of the widget.
  @override
  State<FormPage> createState() => _FormPageState();
}

// -------------------------------------------------------------
// 2️⃣  The _FormPageState class holds all the logic and UI for our form.
// -------------------------------------------------------------
class _FormPageState extends State<FormPage> {
  // This key helps Flutter uniquely identify our Form widget
  // and access its state (like checking if the form is valid).
  final _formKey = GlobalKey<FormState>();

  // These are controllers for each input field.
  // They help us read and control the text that the user types.
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  // dispose() is called automatically when the widget is removed from the screen.
  // We use it to clean up (free memory) by disposing controllers.
  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------
  // 3️⃣  The build() method — this creates the visible UI.
  // -------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      // Add space (16 pixels) around the form
      padding: const EdgeInsets.all(16),

      // The Form widget is a special container that groups together
      // multiple input fields and allows us to validate them all at once.
      child: Form(
        key: _formKey, // Connect this form with our _formKey defined above

        // We use a ListView so the screen can scroll if content overflows
        child: ListView(
          children: [
            // ---------------------------
            // Full Name Input Field
            // ---------------------------
            TextFormField(
              controller: _nameCtrl, // connect controller to get user text
              decoration: const InputDecoration(
                labelText: 'Full Name', // shows a label inside the box
              ),
              validator: Validators.name, // call name validation function
            ),

            // Small space between fields
            const SizedBox(height: 12),

            // ---------------------------
            // Email Input Field
            // ---------------------------
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: Validators.email, // use email validator
              keyboardType: TextInputType.emailAddress, // show @ keyboard on mobile
            ),

            const SizedBox(height: 12),

            // ---------------------------
            // Age Input Field
            // ---------------------------
            TextFormField(
              controller: _ageCtrl,
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
              validator: Validators.age, // use age validator
              keyboardType: TextInputType.number, // open numeric keyboard
            ),

            const SizedBox(height: 20),

            // ---------------------------
            // Buttons Row (Submit & Reset)
            // ---------------------------
            Row(
              children: [
                // ✅ Submit Button
                ElevatedButton(
                  onPressed: () {
                    // When pressed, we check if the form is valid.
                    // validate() runs all the validators inside FormFields.
                    // It returns true only if all validators return null (no error).
                    final valid = _formKey.currentState?.validate() ?? false;

                    if (valid) {
                      // If the form is valid, we show a small popup message
                      // (called SnackBar) at the bottom of the screen.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Form submitted: ${_nameCtrl.text}',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),

                const SizedBox(width: 12),

                // 🔄 Reset Button
                OutlinedButton(
                  onPressed: () {
                    // Reset all validations and clear text fields
                    _formKey.currentState?.reset();
                    _nameCtrl.clear();
                    _emailCtrl.clear();
                    _ageCtrl.clear();
                  },
                  child: const Text('Reset'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
