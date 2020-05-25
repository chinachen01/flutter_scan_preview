import Foundation
import Flutter
import MTBBarcodeScanner
import UIKit

class ScanPreview : NSObject,FlutterPlatformView {
    let uiView: UIView
    var scanner: MTBBarcodeScanner
    var methodChannel: FlutterMethodChannel
    var messageChannel: FlutterBasicMessageChannel
    
    init(frame:CGRect, viewId: Int64, args: Any?, registrar: FlutterPluginRegistrar) {
        uiView = UIView(frame: frame)
        scanner = MTBBarcodeScanner(previewView: uiView)
        let tmpScanner = scanner
        methodChannel = FlutterMethodChannel.init(name: "scan_preview_\(viewId)", binaryMessenger: registrar.messenger())
        messageChannel = FlutterBasicMessageChannel.init(name: "scan_preview_message", binaryMessenger: registrar.messenger())
        let tmpMessageChannel = messageChannel
        methodChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: FlutterResult) -> Void in
             if(call.method == "scan#startCamera") {
                do {
                    try tmpScanner.startScanning(resultBlock: { codes in
                        if let codes = codes {
                            for code in codes {
                                tmpMessageChannel.sendMessage(code.stringValue!)
                            }
                        }
                    })
                } catch {
                     NSLog("Unable to start scanning")
                }
             } else if(call.method == "scan#stopCamera") {
                tmpScanner.stopScanning()
             }
        })
    }
    
    func view() -> UIView {
        return uiView
    }
}
