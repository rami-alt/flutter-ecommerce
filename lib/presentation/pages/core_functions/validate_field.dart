class FieldValidation {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username can't be empty";
    }
    if (value.length < 3 || value.length > 20) {
      return "Username must be between 3 and 20 characters";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 6 || value.length > 20) {
      return "Password must be between 6 and 20 characters";
    }
    return null;
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "Confirm password can't be empty";
    }
    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }
}
