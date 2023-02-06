import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:envify/envify.dart';
import 'package:envify_generator/helpers.dart';
import 'package:envify_generator/src/generate_line.dart';
import 'package:envify_generator/src/load_envs.dart';
import 'package:source_gen/source_gen.dart';

/// Generate code for classes annotated with the `@Envify()`.
///
/// Will throw an [InvalidGenerationSourceError] if the annotated
/// element is not a [classElement].
class EnvifyGenerator extends GeneratorForAnnotation<Envify> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '`@Envify` can only be used on classes.',
        element: element,
      );
    }

    final el = element;
    final config = Envify(
      name: ifFalsy(annotation.read('name').literalValue as String?, el.name),
      path: ifFalsy(annotation.read('path').literalValue as String?, '.env'),
    );

    final envs = await loadEnvs(config.path, (error) {
      throw InvalidGenerationSourceError(
        error,
        element: el,
      );
    });

    final lines = el.fields.map(
      (field) => generateLine(
        field,
        envs.containsKey(normalize(field.name))
            ? envs[normalize(field.name)]
            : null,
      ),
    );

    return '''
    class _${config.name} {
      ${lines.toList().join()}
    }
    ''';
  }
}
