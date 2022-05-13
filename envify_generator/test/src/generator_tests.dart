import 'package:envify/envify.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow('`@Envify` can only be used on classes.')
@Envify()
const foo = 'bar';

@ShouldGenerate(
  '''
class _Env1 {}
''',
expectedLogItems: ["Environment variables file doesn't exist at `.env`."],
)
@Envify()
abstract class Env1 {}

@ShouldThrow('Environment variable not found for field `foo`.')
@Envify(path: 'test/.env.example')
abstract class Env2 {
  static const String foo = 'bar';
}

@ShouldThrow(
  'Envify can only handle types such as `int`, `double`, `num`, `bool` and `String`. Type `Symbol` is not one of them.',
)
@Envify(path: 'test/.env.example')
abstract class Env3 {
  static const Symbol? name = null;
}

@ShouldThrow('Type `int` do not align up to value `frenco`.')
@Envify(path: 'test/.env.example')
abstract class Env4 {
  static const int? name = null;
}

@ShouldThrow('Type `double` do not align up to value `frenco`.')
@Envify(path: 'test/.env.example')
abstract class Env5 {
  static const double? name = null;
}

@ShouldThrow('Type `num` do not align up to value `frenco`.')
@Envify(path: 'test/.env.example')
abstract class Env6 {
  static const num? name = null;
}

@ShouldThrow('Type `bool` do not align up to value `frenco`.')
@Envify(path: 'test/.env.example')
abstract class Env7 {
  static const bool? name = null;
}

@ShouldGenerate('''
class _Env8 {
  static const String? name = 'frenco';
  static const int? age = 19;
  static const double? height = 167.9;
  static const bool? isStudent = true;
  static const dynamic race = 'Asian';
}
''',)
@Envify(path: 'test/.env.example')
abstract class Env8 {
  static const String? name = null;
  static const int? age = null;
  static const double? height = null;
  static const bool? isStudent = null;
  static const race = null;
}

@ShouldGenerate('''
class _Env9 {
  static const dynamic hairColor = null;
}
''',)
@Envify(path: 'test/.env.example')
abstract class Env9 {
  static const hairColor = null;
}

@ShouldGenerate('''
class _Env10 {
  static const String? hairColor = null;
}
''',)
@Envify(path: 'test/.env.example')
abstract class Env10 {
  static const String? hairColor = null;
}

@ShouldGenerate('''
class _Secrets {}
''',)
@Envify(name: 'Secrets', path: 'test/.env.example')
abstract class Env11 {}
