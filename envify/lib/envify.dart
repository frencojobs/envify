/// An annotation used to specify the class to generate code for.
class Envify {
  /// The value to use as name for the generated class, with
  /// an underscore `$` prefixed.
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
  /// abstract class $Secrets {}
  /// ```
  final String name;

  /// The file path relative to the project base path, which
  /// will be used to get environment variables from.
  ///
  /// If `null` or an empty [String], `.env` is used.
  final String path;

  const Envify({this.name, this.path});
}
