import 'package:{{name.snakeCase()}}/utils/log/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  final MethodChannel platform = const MethodChannel('ZKPermission');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        child: ListView(children: [
          ElevatedButton(
            onPressed: () async {
              final res = await platform.invokeMethod('ZKCameraPermission');
              zkLogger.d(res);
            },
            child: const Text("获取相机权限"),
          ),
          ElevatedButton(
            onPressed: () async {
              final res = await platform.invokeMethod('ZKMicrophonePermission');
              zkLogger.d(res);
            },
            child: const Text("获取麦克风权限"),
          ),
          ElevatedButton(
            onPressed: () async {
              final res =
                  await platform.invokeMethod('ZKPhotoLibraryUsagePermission');
              zkLogger.d(res);
            },
            child: const Text("获取相册权限"),
          ),
          ElevatedButton(
            onPressed: () async {
              final res = await platform
                  .invokeMethod('ZKPhotoLibraryAddUsagePermission');
              zkLogger.d(res);
            },
            child: const Text("获取添加照片权限"),
          ),
          ElevatedButton(
            onPressed: () async {
              final res =
                  await platform.invokeMethod('ZKLocationUsagePermission');
              zkLogger.d(res);
            },
            child: const Text("获取定位权限"),
          ),
          ElevatedButton(
            onPressed: () async {
              final res =
                  await platform.invokeMethod('ZKBluetoothUsagePermission');
              zkLogger.d(res);
            },
            child: const Text("获取蓝牙权限"),
          ),
          ElevatedButton(
            onPressed: () async {
              final res =
                  await platform.invokeMethod('ZKNotificationUsagePermission');
              zkLogger.d(res);
            },
            child: const Text("获取通知权限"),
          ),
          ElevatedButton(
            onPressed: () async {
              final res =
                  await platform.invokeMethod('ZKLocalNetworkAuthorization');
              zkLogger.d(res);
            },
            child: const Text("获取本地网络权限"),
          )
        ]),
      ),
    );
  }
}
