import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Generate the line to be used in the generated class.
/// If [value] is `null` but the type is not nullable or `dynamic`, it means the variable definition doesn't exist
/// and an [InvalidGenerationSourceError] will be thrown.
///
/// Since this function also does the type casting,
/// an [InvalidGenerationSourceError] will also be thrown if
/// the type can't be casted, or is not supported.
String generateLine(FieldElement field, String? value) {
  if (field.type.nullabilitySuffix != NullabilitySuffix.question &&
      !field.type.isDynamic &&
      value == null) {
    throw InvalidGenerationSourceError(
      'Environment variable not found for field `${field.name}`.',
      element: field,
    );
  }

  String typeString = field.type.getDisplayString(withNullability: false);
  dynamic parsedValue;

  if (value != null) {
    parsedValue = (() {
      switch (typeString) {
        case "int":
          final result = int.tryParse(value);
          if (result == null) {
            throw InvalidGenerationSourceError(
              'Type `$typeString` do not align up to value `$value`.',
              element: field,
            );
          } else {
            return result;
          }
        case "double":
          final result = double.tryParse(value);
          if (result == null) {
            throw InvalidGenerationSourceError(
              'Type `$typeString` do not align up to value `$value`.',
              element: field,
            );
          } else {
            return result;
          }
        case "num":
          final result = num.tryParse(value);
          if (result == null) {
            throw InvalidGenerationSourceError(
              'Type `$typeString` do not align up to value `$value`.',
              element: field,
            );
          } else {
            return result;
          }
        case "bool":
          final lowercaseValue = value.toLowerCase();
          if (['true', 'false'].contains(lowercaseValue)) {
            return lowercaseValue;
          } else {
            throw InvalidGenerationSourceError(
              'Type `$typeString` do not align up to value `$value`.',
              element: field,
            );
          }
        case "String":
        case "dynamic":
          return "'$value'";
        default:
          throw InvalidGenerationSourceError(
            'Envify can only handle types such as `int`, `double`, `num`, `bool` and `String`. Type `$typeString` is not one of them.',
            element: field,
          );
      }
    })();
  }

  typeString = field.type.getDisplayString(withNullability: true);

  return 'static const $typeString ${field.name} = $parsedValue;';
}
