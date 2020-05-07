# scan_preview

A new flutter plugin project.

## Getting Started

android: [barcodescanner](https://github.com/dm77/barcodescanner)
ios: [MTBBarcodeScanner](https://github.com/mikebuss/MTBBarcodeScanner)

This plugin is based on PlatformView, which means you can customize the scanning UI freely.
By the way, the framing UI is limited to the native API, and only a part of the attribute customization can be provided.

## How to use
```dart
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
```

> I use [PermissionHandler]() to request camera permission

### ios
You need to include the following Info.plist key in order to request camera access or the application will crash:

```xml
<key>NSCameraUsageDescription</key>
<string>Can we access your camera in order to scan barcodes?</string>
```

### android
do nothing

## Warning

On android and in debug mode, the camera preview will stuck sometimes,  but it did not happen in release mode.


