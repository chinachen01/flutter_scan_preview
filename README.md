# scan_preview

A QR code scanner flutter plugin project.
Using PlatfromView to open native camera page scan qr code.

## Installation

Add this to your package's pubspec.yaml file:

```
dependencies:  
  scan_preview: ^1.0.0
```

## Getting Started

android: [barcodescanner](https://github.com/dm77/barcodescanner)
ios: [MTBBarcodeScanner](https://github.com/mikebuss/MTBBarcodeScanner)

This plugin is based on PlatformView, which means you can customize the scanning UI freely.
By the way, the framing UI is limited to the native API, and only a part of the attribute customization can be provided.

## How to use
```dart
class ScanPreviewPage extends StatefulWidget {
  @override
  _ScanPreviewPageState createState() => _ScanPreviewPageState();
}

class _ScanPreviewPageState extends State<ScanPreviewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scan barcode example'),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ScanPreviewWidget(
            onScanResult: (result) {
              debugPrint('scan result: $result');
              Navigator.pop(context, result);
            },
          ),
        ),
      ),
    );
  }
}

```

> About Permission : You should request the camear permission by yourself, I use [PermissionHandler]() to request camera permission in this example.

### ios
You need to include the following Info.plist key in order to request camera access or the application will crash:

```xml
<key>NSCameraUsageDescription</key>
<string>Can we access your camera in order to scan barcodes?</string>
```

**Important:**  Adding a boolean property to the Info.plist 

```XML
<key>io.flutter.embedded_views_preview</key>
<Boolean>YES</string>
```

### android

Use directly.

## TODO

I am an android developer, there are still many features of ios that are not implemented.

If you are an ios developer, welcome to contribute your code.

- [x] ios to be tested
- [ ] ios scan radar
- [ ] read code from gallery



## Warning

On android device and in debug mode, the camera preview will stuck sometimes,  but it did not happen in release mode.


