import 'dart:io' show File;
import 'package:build/build.dart';
import 'package:dotenv/dotenv.dart' show Parser;

/// Load the environment variables from the supplied [path],
/// using the `dotenv` parser.
///
/// If file doesn't exist, an error will be thrown through the
/// [onError] function.
Future<Map<String, String>> loadEnvs(
  String path,
) async {
  const parser = Parser();
  final file = File.fromUri(Uri.file(path));

  var lines = <String>[];
  if (await file.exists()) {
    lines = await file.readAsLines();
  } else {
    log.warning("Environment variables file doesn't exist at `$path`.");
  }

  final envs = parser.parse(lines);
  return envs;
}
