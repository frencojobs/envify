import 'package:envify/envify.dart';

part 'env.g.dart';

@Envify()
abstract class Env {
  static const String name = _Env.name;
  static const int age = _Env.age;
  static const double height = _Env.height;
  static const bool isStudent = _Env.isStudent;
  static const race = _Env.race;
}
