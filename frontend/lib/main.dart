// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'models/app_model.dart';
import 'views/home_page.dart';

void main({String? environment}) async {
  // FIXME: Unhandled Exception: Null check operator used on a null value
  // Fails to load asset
  // final config = await Config.parse(environment);

  // TODO: replace following hack when preceding exception is resolved
  // HACK ==>

  String? greetingUrl = environment == 'prod'
      ? Platform.environment['GREETING_URL']
      : 'http://localhost:8080';

  if (greetingUrl == null) {
    throw Exception(
        'Error: environment variable GREETING_URL not set for prod environment.');
  }

  final config = Config(
      greetingsUrl:
          environment == 'prod' ? greetingUrl : 'http://localhost:8080');

  // <== HACK

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppModel(config),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
