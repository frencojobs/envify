import 'package:envify/envify.dart';

part 'env.g.dart';

@Envify()
abstract class Env {
  static const String name = $Env.name;
  static const int age = $Env.age;
  static const double height = $Env.height;
  static const bool isStudent = $Env.isStudent;
  static const race = $Env.race;
}
