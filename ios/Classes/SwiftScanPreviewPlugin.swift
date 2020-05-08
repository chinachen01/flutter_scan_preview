import Flutter
import UIKit

public class SwiftScanPreviewPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
//    let channel = FlutterMethodChannel(name: "scan_preview", binaryMessenger: registrar.messenger())
//    let instance = SwiftScanPreviewPlugin()
//    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.register(ScanPreviewFactory(registrar: registrar), withId: "scan_preview")
  }
}
