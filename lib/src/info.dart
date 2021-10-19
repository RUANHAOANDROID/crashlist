import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data/object_crashinfo.dart';

class CrashInfoPage extends StatelessWidget {
  static const String route = "/crashinfo";

  final CrashInfo info;

  const CrashInfoPage({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('crash info')),
      body: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('设备型号：${info.deviceModel}'),
                Text('系统版本号：${info.osVersion}'),
                Text('网络状态：${info.networkType}'),
                Text('用户：${info.username}'),
                Text('错误状态：${info.status}'),
                Text('App版本号：${info.appVersionCode}'),
                Text('App版本名称：${info.appVersionName}'),
                Text('SDK版本号：${info.sdkVersionCode}'),
                Text('SDK版本名称：${info.sdkVersionName}'),
                Text('设备唯一识别码：${info.uniqueDeviceId}'),
                Text('是否是平板：${info.isTablet}'),
                Text('崩溃时间：${info.timeOfCrash}'),
                Text('错误状态：${info.errorType}'),
                Text('${info.carshContent}'),
              ],
            ),
          )),
    );
  }
}
