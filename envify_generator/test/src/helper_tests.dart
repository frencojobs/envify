import 'package:envify_generator/helpers.dart';
import 'package:test/test.dart';

void main() {
  group('Are helpers working? Because', () {
    test('`validate` should return `true`', () {
      expect(validate('', (x) => x!.isEmpty), true);
    });

    test('`validate` should return `false`', () {
      expect(validate('-', (x) => x!.isEmpty), false);
    });

    test('`ifFalsy` should return `b`', () {
      expect(ifFalsy(null, 'b'), 'b');
    });

    test('`ifFalsy` should return `b`', () {
      expect(ifFalsy('', 'b'), 'b');
    });

    test('`ifFalsy` should return `a`', () {
      expect(ifFalsy('a', 'b'), 'a');
    });

    test('`camelCaseToSnakeCase` should return proper results', () {
      expect(camelCaseToSnakeCase('apple'), 'apple');
      expect(camelCaseToSnakeCase('apple1'), 'apple_1');
      expect(camelCaseToSnakeCase('notApple'), 'not_apple');
      expect(
        camelCaseToSnakeCase('definitelyNotApple'),
        'definitely_not_apple',
      );
    });

    test('`normalize` should return proper results', () {
      expect(normalize('apple'), 'APPLE');
      expect(normalize('apple1'), 'APPLE_1');
      expect(normalize('notApple'), 'NOT_APPLE');
      expect(
        normalize('definitelyNotApple'),
        'DEFINITELY_NOT_APPLE',
      );
    });
  });
}
