import 'package:envify/envify.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow('`@Envify` can only be used on classes.')
@Envify()
const foo = 'bar';

@ShouldThrow("Environment variables file doesn't exist at `.env`.")
@Envify()
abstract class Env1 {}

@ShouldThrow('Environment variable not found for field `foo`.')
@Envify(path: 'test/.env.example')
abstract class Env2 {
  static const dynamic foo = null;
}

@ShouldThrow(
  'Envify can only handle types such as `int`, `double`, `num`, `bool` and `String`. Type `Symbol` is not one of them.',
)
@Envify(path: 'test/.env.example')
abstract class Env3 {
  static const Symbol? dbHost = null;
}

@ShouldThrow('Type `int` do not align up to value `localhost`.')
@Envify(path: 'test/.env.example')
abstract class Env4 {
  static const int? dbHost = null;
}

@ShouldThrow('Type `double` do not align up to value `localhost`.')
@Envify(path: 'test/.env.example')
abstract class Env5 {
  static const double? dbHost = null;
}

@ShouldThrow('Type `num` do not align up to value `localhost`.')
@Envify(path: 'test/.env.example')
abstract class Env6 {
  static const num? dbHost = null;
}

@ShouldThrow('Type `bool` do not align up to value `localhost`.')
@Envify(path: 'test/.env.example')
abstract class Env7 {
  static const bool? dbHost = null;
}

@ShouldGenerate('''
class _Env8 {
  static const String dbHost = 'localhost';
  static const int dbPort = 27017;
  static const double timeout = 9.5;
  static const bool development = true;
}
''')
@Envify(path: 'test/.env.example')
abstract class Env8 {
  static const String? dbHost = null;
  static const int? dbPort = null;
  static const double? timeout = null;
  static const bool? development = null;
}

@ShouldGenerate('''
class _Secrets {}
''')
@Envify(name: 'Secrets', path: 'test/.env.example')
abstract class Env9 {}
