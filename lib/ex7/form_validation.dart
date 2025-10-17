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
