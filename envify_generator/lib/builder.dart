library envify_generator.builder;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:envify_generator/envify_generator.dart';

/// Primary builder to build the generated code from the `EnvifyGenerator`
Builder envifyBuilder(BuilderOptions options) =>
    SharedPartBuilder([EnvifyGenerator()], 'envify');
