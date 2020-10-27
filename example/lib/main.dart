import 'package:example/env/env.dart';

void main() {
  print('''
    name: ${Env.name}
    age: ${Env.age}
    height: ${Env.height}cm
    isStudent: ${Env.isStudent}
    race: ${Env.race}
  ''');
}
