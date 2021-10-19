import 'package:crashlist/src/info.dart';
import 'package:crashlist/src/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/object_crashinfo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crash List',
      //routes: {CrashInfoPage.route: (context) => const CrashInfoPage()},
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Crash List'),
    );
  }
}
