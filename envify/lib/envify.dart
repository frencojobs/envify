/// An annotation used to specify the class to generate code for.
class Envify {
  /// The value to use as name for the generated class, with
  /// an underscore `_` prefixed.
  ///
  /// If `null` or an empty [String], the name of the annotated class is used.
  ///
  /// For example, the generated code for
  ///
  /// ```dart
  /// @Envify(name: 'secrets')
  /// abstract class Env {}
  /// ```
  ///
  /// will look like
  ///
  /// ```dart
  /// abstract class _Secrets {}
  /// ```
  final String? name;

  /// The file path relative to the project base path, which
  /// will be used to get environment variables from.
  ///
  /// If `null` or an empty [String], `.env` is used.
  final String path;

  /// Allows all the values to be encrypted using a random
  /// generated key that is then XOR'd with the encrypted
  /// value when being accessed the first time.
  /// Please note that the values can not be offered with
  /// the const qualifier, but only with final.
  final bool obfuscate;

  const Envify({this.name, this.path = '.env', this.obfuscate = false});
}
