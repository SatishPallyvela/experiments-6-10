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
              decoration: const InputDecoration(labelText: 'Email'),
              validator: Validators.email, // use email validator
              keyboardType:
                  TextInputType.emailAddress, // show @ keyboard on mobile
            ),

            const SizedBox(height: 12),

            // ---------------------------
            // Age Input Field
            // ---------------------------
            TextFormField(
              controller: _ageCtrl,
              decoration: const InputDecoration(labelText: 'Age'),
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
                          content: Text('Form submitted: ${_nameCtrl.text}'),
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
            ),
          ],
        ),
      ),
    );
  }
}
