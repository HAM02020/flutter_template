import 'package:__brick__/utils/log/log.dart';
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          FloatingActionButton.extended(
            onPressed: () async {
              final res = await platform.invokeMethod('ZKCameraPermission');
              zkLogger.d(res);
            },
            label: const Text("获取相机权限"),
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              final res = await platform.invokeMethod('ZKMicrophonePermission');
              zkLogger.d(res);
            },
            label: const Text("获取麦克风权限"),
          )
        ]),
      ),
    );
  }
}
