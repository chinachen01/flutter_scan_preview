import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_preview/scan_preview.dart';
import 'package:scan_preview/scan_preview_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  _requestPermission() async {
    await Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scan barcode example'),
        ),
        body: Container(
          child: ScanPreviewWidget(
            onScanResult: (result) {
              setState(() {
                debugPrint('scan result: $result');
              });
            },
          ),
        ),
      ),
    );
  }
}
