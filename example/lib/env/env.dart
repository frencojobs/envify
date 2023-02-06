import 'package:envify/envify.dart';

part 'env.g.dart';

@Envify()
abstract class Env {
  static const String dbHost = _Env.dbHost;
  static const int dbPort = _Env.dbPort;
  static const double timeout = _Env.timeout;
  static const bool development = _Env.development;
}
