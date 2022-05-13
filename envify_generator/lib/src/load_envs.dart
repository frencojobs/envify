import 'dart:io' show File;
import 'package:build/build.dart';
import 'package:dotenv/dotenv.dart';

/// Load the environment variables from the supplied [path],
/// using the `dotenv` parser.
///
/// If file doesn't exist, an error will be thrown through the
/// [onError] function.
Future<DotEnv> loadEnvs(
  String path,
) async {
  final env = DotEnv();
  final file = File.fromUri(Uri.file(path));

  if (await file.exists()) {
    env.load([path]);
  } else {
    log.warning("Environment variables file doesn't exist at `$path`.");
  }
  return env;
}
