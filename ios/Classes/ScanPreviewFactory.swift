import Foundation
import Flutter

class ScanPreviewFactory : NSObject, FlutterPlatformViewFactory {
    var registrar: FlutterPluginRegistrar
    
    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return ScanPreview(frame: frame, viewId: viewId, args: args,registrar: registrar)
    }
}
