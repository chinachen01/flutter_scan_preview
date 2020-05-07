import 'dart:async';

import 'package:flutter/services.dart';

class ScanPreview {
  static const MethodChannel _channel =
      const MethodChannel('scan_preview');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static startCamera() async{
    await _channel.invokeMethod('startCamera');
  }

  static stopCamera() async {
    await _channel.invokeMethod('stopCamera');
  }
}
