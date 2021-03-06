import 'dart:async';
import 'dart:convert';
import 'package:crashlist/src/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'info.dart';
import 'data/object_crashinfo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageNum = 1;
  int pageSize = 10;
  List<CrashInfo> crashList = List.empty(growable: true);

  Future getCrashList(int pageNum, int pageSize, {int status = 0}) async {
    const String url =
        "http://localhost:8900/hbshllcj-web/shllcj/api/app_log/query";
    var uri = Uri.parse(url);
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(uri,
        body: jsonEncode(<String, String>{
          'pageNum': pageNum.toString(),
          'pageSize': pageSize.toString(),
          'status': status.toString(),
        }),
        headers: headers);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['result']['list'];
      setState(() {
        crashList = data.map((e) => CrashInfo.fromJson(e)).toList();
      });
    }
  }

  Future changeCrashStatus(String id, int status) async {
    String url =
        'http://localhost:8900/hbshllcj-web/shllcj/api/app_log/update/$id/$status';
    var uri = Uri.parse(url);
    final response = await http.post(uri);
    if (response.statusCode == 200) {
      setState(() {
        getCrashList(pageNum, pageSize);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCrashList(pageNum, pageSize);
  }

  void nextPage() {
    pageNum = pageNum + 1;
    getCrashList(pageNum, pageSize);
  }

  void previousPage() {
    if (pageNum == 1) {
      log('first page');
    } else {
      pageNum--;
      getCrashList(pageNum, pageSize);
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
        var crashContext = Text(
          '${info.carshContent}',
          style: const TextStyle(color: Colors.black45),
          maxLines: 1,
        );
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
                  title: crashContext,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20,right: 20),
                      child: TextButton(
                          onPressed: () {
                            changeCrashStatus('${info.id}', 1);
                          },
                          child: const Text('?????????')),
                    ),
                  ],
                ),
              ],
            ));
        var itemView = GestureDetector(
            onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CrashInfoPage(info: crashList[i])))
                },
            child: cardView);
        widgets.addAll(([itemView]));
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
                TextButton(
                    onPressed: () {
                      getCrashList(pageNum, pageSize, status: 0);
                    },
                    child: const Text("?????????")),
                TextButton(
                    onPressed: () {
                      getCrashList(pageNum, pageSize, status: 1);
                    },
                    child: const Text("?????????")),
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
                child: const Text('?????????')),
            Text(pageNum.toString()),
            TextButton(
                onPressed: () {
                  nextPage();
                },
                child: const Text('?????????'))
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
