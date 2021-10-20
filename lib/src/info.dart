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
      appBar: AppBar(title: const Text('日志详情')),
      body: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText('设备型号：${info.deviceModel}'),
                SelectableText('系统版本号：${info.osVersion}'),
                SelectableText('网络状态：${info.networkType}'),
                SelectableText('用户：${info.username}'),
                SelectableText('错误状态：${info.status}'),
                SelectableText('App版本号：${info.appVersionCode}'),
                SelectableText('App版本名称：${info.appVersionName}'),
                SelectableText('SDK版本号：${info.sdkVersionCode}'),
                SelectableText('SDK版本名称：${info.sdkVersionName}'),
                SelectableText('设备唯一识别码：${info.uniqueDeviceId}'),
                SelectableText('是否是平板：${info.isTablet}'),
                SelectableText('崩溃时间：${info.timeOfCrash}'),
                SelectableText('错误状态：${info.errorType}'),
                SelectableText('${info.carshContent}'),
              ],
            ),
          )),
    );
  }
}
