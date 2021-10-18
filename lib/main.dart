import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crash List',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Crash List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CrashInfo {
  String? id = "";
  String? deviceModel = "";
  String? osVersion = "";
  String? networkType = "";
  String? username = "";
  String? status = "";
  String? appVersionCode = "";
  String? appVersionName = "";
  String? sdkVersionCode = "";
  String? sdkVersionName = "";
  String? uniqueDeviceId = "";
  String? isTablet = "";
  String? isEmulator = "";
  String? timeOfCrash = "";
  String? errorType = "";
  String? carshContent = "";

  CrashInfo(
      {required this.id,
      required this.deviceModel,
      required this.osVersion,
      required this.networkType,
      required this.username,
      required this.status,
      required this.appVersionCode,
      required this.appVersionName,
      required this.sdkVersionCode,
      required this.sdkVersionName,
      required this.uniqueDeviceId,
      required this.isTablet,
      required this.isEmulator,
      required this.timeOfCrash,
      required this.errorType,
      required this.carshContent});

  factory CrashInfo.fromJson(Map<String, dynamic> json) {
    return CrashInfo(
      id: json['json'],
      deviceModel: json['deviceModel'],
      appVersionName: json['appVersionName'],
      uniqueDeviceId: json['uniqueDeviceId'],
      isTablet: json['isTablet'],
      carshContent: json['carshContent'],
      sdkVersionCode: json['sdkVersionCode'],
      networkType: json['networkType'],
      timeOfCrash: json['timeOfCrash'],
      status: json['status'],
      errorType: json['errorType'],
      isEmulator: json['isEmulator'],
      username: json['username'],
      appVersionCode: json['appVersionCode'],
      sdkVersionName: json['sdkVersionName'],
      osVersion: json['osVersion'],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int pageNum = 0;
  int pageSize = 10;
  List<CrashInfo> crashList = List.empty(growable: true);

  Future getCrashs(int pageNum, int pageSize) async {
    const String url =
        "http://localhost:8900/hbshllcj-web/shllcj/api/app_log/query";
    var uri = Uri.parse(url);
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(uri,
        body: jsonEncode(<String, String>{
          'pageNum': pageNum.toString(),
          'pageSize': pageSize.toString()
        }),
        headers: headers);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['result']['list'];
      setState(() {
        crashList = data.map((e) => CrashInfo.fromJson(e)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCrashs(pageNum, pageSize);
  }

  void nextPage() {
    pageNum = pageNum + 1;
    getCrashs(pageNum, pageSize);
  }

  void previousPage() {
    if (pageNum == 0) {
      log('debug:首页了');
    } else {
      pageNum--;
      getCrashs(pageNum, pageSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    if (crashList.isNotEmpty) {
      for (var i = 0; i < crashList.length; i++) {
        CrashInfo info = crashList[i];
        var deviceModel = Text('${info.deviceModel}');
        var networkType = Text('${info.networkType}');
        var username = Text('${info.username}');
        var timeOfCrash = Text('${info.timeOfCrash}');

        var cardView = Card(
            elevation: 3.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.phone_android),
                  title: deviceModel,
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: username,
                ),
                ListTile(
                  leading: const Icon(Icons.network_check),
                  title: networkType,
                ),
                ListTile(
                  leading: const Icon(Icons.alarm),
                  title: timeOfCrash,
                ),
                ListTile(
                  leading: const Icon(Icons.error),
                  title: Text(
                    '${info.carshContent}',
                    style: const TextStyle(color: Colors.black45),
                    maxLines: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child: const Text('已解决')),
                    TextButton(onPressed: () {}, child: const Text('已解决'))
                  ],
                ),
              ],
            ));

        widgets.addAll(([cardView]));
      }
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                TextButton(onPressed: () {}, child: const Text("已修复")),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widgets,
            )
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Row(
          children: [
            TextButton(
                onPressed: () {
                  previousPage();
                },
                child: const Text('上一页')),
            Text(pageNum.toString()),
            TextButton(
                onPressed: () {
                  nextPage();
                },
                child: const Text('下一页'))
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

void log(String log) {
  print('debug: $log');
}
