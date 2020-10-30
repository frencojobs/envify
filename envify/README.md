# Envify

A **better** and probably **safer** way to handle environment variables in Flutter.

> To read _why this is better/safer_ in details, skip to the [motivation](#motivation) section.

<br>

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
  - [Change `.env` file path](#change-env-file-path)
  - [Change generated class name](#change-generated-class-name)
- [Motivation](#motivation)
- [Features](#features)
- [Acknowledgement](#acknowledgement)
- [License](#license)

<br>

## Overview

For a `.env` file like this,

```.env
KEY=VALUE
```

and a class like this,

```dart
part 'env.g.dart';

@Envify()
abstract class Env {
    static const key = _Env.key;
}
```

envify will generate the part file which contains the `_Env` class with value for `KEY` loaded from the `.env` file.

Now you can use the `Env.key`,

```dart
print(Env.key); // "VALUE"
```

<br>

## Installation

Add both `envify` and `envify_generator` as dependencies,

```yaml
dependencies:
  envify: any

dev_dependencies:
  envify_generator: any
  build_runner: any
```

If you already don't have `build_runner`, you need to add it too.

<br>

## Usage

Add a `.env` file at the root of the project. Syntax and rules for the file can be viewed at [dotenv rules](https://www.npmjs.com/package/dotenv#rules).
Define API for generation at `lib/env/env.dart` (you can use any file at any path but I would recommend using this so that you don't forget to add this file to `.gitignore` later).

> Don't forget to add both `.env` file and `env.g.dart` to `.gitignore`! Otherwise, you might expose your environment variables.

```dart
// env/env.dart

import 'package:envify/envify.dart';
part 'env.g.dart';

@Envify()
abstract class Env {
    static const key = _Env.key;
}
```

Then run the generator,

```sh
# dart
pub run build_runner build
# flutter
flutter pub run build_runner build
```

<br>

## API Documentation

#### **Change `.env` file path**

You can change the file to get the data to generate for, in the `@Envify` annotation. By this API, it is also possible to have multiple environment variables classes for multiple occasions.

```dart
@Envify(path: '.env.development')
abstract class DevEnv {}

@Envify(path: '.env.production')
abstract class ProdEnv {}
```

#### **Change generated class name**

By default, the generated class will be named as the name of the annotated class with a `_` prefixed. You can change it using the `name` field. Note that the `_` will always be prefixed.

```dart
@Envify(name: 'Secrets')
abstract class Env {
   static const key = _Secrets.key;
}
```

<br>

## Motivation

I needed to use environment variables in a recent Flutter project, and the option available was [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) which is a package tweaked over the [dotenv](https://pub.dev/packages/dotenv) package. Because the `dotenv` package only handles the environment variables only during a process, the `flutter_dotenv` package hack its way by exporting the `.env` file into the assets and loading the file during the app runtime.

But there were some problems with this approach that I noticed,

1. The asset directory can be accessed directly through unzipping the APK, thus easily **exposing the environment variables**,

2. The loading of the environment variables **takes time**,
   This is ok in a dart process because it will only load the first time during the process's lifetime, but in this case, it will load every time you open the app.

3. Because the variables were loaded on the runtime, you can't access them as **constant expressions for source code generation**,
   For example, you won't be able to use them with tools like `json_serializable` and `retrofit` which require constant value configurations via annotations.

Envify solves all the presented issues by using code generation.

<br>

## Features

- Envify will generate code for the _user defined set of keys_ with the values from the environment variables file which is `.env` by default. Since the generated code is part of the source, it will be passed through the obfuscating/compiling process during compile time making it harder to reverse engineer.

- Envify will only generate fields that the user has passed making it handy to use with shared environment variables between multiple projects.

- Changing between multiple environment files like `.env.production` and `.env.development` is also easier because the user can configure which file to load environment variables from via the `@Envify` annotation.

- Users can also pass optional field types during the definition, which envify will use to cast the values of generated fields. But since it's not appropriate to store large values except strings in the `.env` file, only literal types like `int`, `double`, `num`, `bool`, and `String` can be parsed. If type is optional or else, `String` will be used as default.

- The generated fields will be constant expressions that can be used within source code generation and every other place user needed.

<br>

## Acknowledgement

To make this project possible, I had to learn about source code generation which I didn't know anything about. I had to read source codes of large source code generator projects like [`json_serializable`](https://github.com/google/json_serializable.dart) and many others. So certain parts like how the tests are written, and how the API is structured are influenced by those projects. The parse used in the generator comes from the [dotenv](https://pub.dev/packages/dotenv) package.

Also, using a class as an abstraction layer instead of directly accessing the generated code is a design decision I made so that the error when the `env.g.dart` part file is not generated, won't spread out through the project. Now even when the part file is not generated yet, the error only stays in the `env.dart` file.

<br>

## License

MIT © Frenco Jobs
