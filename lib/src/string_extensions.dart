extension StringExtension on String {
  // Capitalizes the first letter of a string and returns the modified string.
  String capitalize() {
    return isNotEmpty ? this[0].toUpperCase() + substring(1) : this;
  }

  /// Converts the first character of the string to lowercase and returns the modified string.
  ///
  /// If the string is empty, the original string is returned.
  ///
  /// Returns:
  ///   - The modified string with the first character in lowercase.
  ///
  /// Example:
  /// ```dart
  /// String str = "Hello";
  /// String lowerCaseFirst = str.toLowerCaseFirst();
  /// print(lowerCaseFirst); // Output: "hello"
  /// ```
  String toLowerCaseFirst() {
    return isNotEmpty ? this[0].toLowerCase() + substring(1) : this;
  }

  /// Converts a string to snake case.
  ///
  /// Replaces all uppercase characters with their lowercase equivalent preceded by an underscore.
  /// Also replaces all whitespace characters with an underscore.
  ///
  /// Returns:
  ///   - The modified string in snake case.
  String toSnakeCase() {
    return replaceAllMapped(RegExp(r'([A-Z])'), (match) {
      return '_${match.group(1)!.toLowerCase()}';
    }).replaceAll(RegExp(r'\s+'), '_');
  }
}

