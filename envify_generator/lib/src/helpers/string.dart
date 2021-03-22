// Helper functions related to strings

/// Type Definition: function with a [String] as a parameter
/// returning a [bool]
typedef boolFn = bool Function(String?);

/// Method to decide whether a [String] input
/// returns `true` or `false` through the predicate function
/// or not.
bool validate(String? input, boolFn predicate) {
  return predicate(input);
}

/// Method that will returns
/// [a] if [a] is not null or an empty string. Otherwise,
/// [b] will be returned.
String? ifFalsy(String? a, String b) {
  return validate(a, (x) => (x ?? '').isNotEmpty) ? a : b;
}

/// Method to convert camelCases to snake_cases
String camelCaseToSnakeCase(String input) {
  return input.replaceAllMapped(RegExp('([A-Z])|([0-9]+)'),
      (match) => '_${match.group(0)!.toLowerCase()}');
}

/// Method to normalize the [input] string to .ENV
/// compatible keys.
///
/// For example:
/// `isStudent1` will have an output of `IS_STUDENT_1`
String normalize(String input) {
  return camelCaseToSnakeCase(input).toUpperCase();
}
