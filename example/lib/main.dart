import 'package:example/env/env.dart';

void main() {
  print('''
    dbHost: ${Env.dbHost}
    dbPort: ${Env.dbPort}
    timeout: ${Env.timeout}
    development: ${Env.development}
  ''');
}
