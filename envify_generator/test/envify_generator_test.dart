@TestOn('vm')
import 'package:envify_generator/envify_generator.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

import 'src/helper_tests.dart' as helpers;

Future<void> main() async {
  // for helpers
  helpers.main();

  // for annotated elements
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
    path.join('test', 'src'),
    'generator_tests.dart',
  );

  testAnnotatedElements(
    reader,
    EnvifyGenerator(),
  );
}
