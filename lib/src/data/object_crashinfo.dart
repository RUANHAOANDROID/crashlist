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
      id: json['id'],
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