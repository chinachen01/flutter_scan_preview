import Foundation
import Flutter
import MTBBarcodeScanner

class ScanPreview : NSObject,FlutterPlatformView {
    var uiView: UIView
    var scanner: MTBBarcodeScanner
    var methodChannel: FlutterMethodChannel
    var messageChannel: FlutterBasicMessageChannel
    
    init(frame:CGRect, viewId: Int64, args: Any?, registrar: FlutterPluginRegistrar) {
        uiView = UIView(frame: frame)
        scanner = MTBBarcodeScanner(previewView: uiView)
        let tmpScanner = scanner
        methodChannel = FlutterMethodChannel.init(name: "scan_preview_\(viewId)", binaryMessenger: registrar.messenger())
        messageChannel = FlutterBasicMessageChannel.init(name: "scan_preview_message", binaryMessenger: registrar.messenger())
        methodChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if(call.method == "scan#startCamera") {
                do {
                    try tmpScanner.startScanning()
                } catch {

                }
                
            } else if(call.method == "scan#stopCamera") {
                tmpScanner.stopScanning()
            }
                
        })
//        messageChannel.sendMessage("二维码扫描结果")
    }
    
    func view() -> UIView {
        return uiView
    }
}
