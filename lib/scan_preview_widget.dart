import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:scan_preview/scan_preview_controller.dart';

class ScanPreviewWidget extends StatefulWidget {
  ScanPreviewWidget(
      {this.laserColor = 0xFF00FF00,
      this.borderColor = 0xFFFFFFFF,
      @required this.onScanResult});

  final ValueChanged<String> onScanResult;
  final int laserColor;
  final int borderColor;

  @override
  ScanPreviewWidgetState createState() => ScanPreviewWidgetState();
}

class ScanPreviewWidgetState extends State<ScanPreviewWidget>
    with WidgetsBindingObserver {
  final Completer<ScanPreviewController> _controller =
      Completer<ScanPreviewController>();
  final BasicMessageChannel _messageChannel =
      BasicMessageChannel("scan_preview_message", StandardMessageCodec());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _messageChannel.setMessageHandler(_messageHandler);
  }

  Future<dynamic> _messageHandler(Object message) async {
    widget.onScanResult(message.toString());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    ScanPreviewController controller = await _controller.future;
    if (state == AppLifecycleState.resumed) {
      controller.startCamera();
    } else if (state == AppLifecycleState.paused) {
      controller.stopCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _init();
  }

  Widget _init() {
    final Map<String, dynamic> creationParams = <String, dynamic>{
      // 其他参数
      'laserColor': widget.laserColor,
      'borderColor': widget.borderColor
    };
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'scan_preview',
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: onPlatformViewCreated,
      );
    } else {
      return UiKitView(
        viewType: 'scan_preview',
      );
    }
  }

  Future<void> onPlatformViewCreated(int id) async {
    final ScanPreviewController controller =
        await ScanPreviewController.init(id, this);
    _controller.complete(controller);
    controller.startCamera();
  }
}
