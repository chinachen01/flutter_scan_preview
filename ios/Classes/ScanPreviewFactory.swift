import Foundation
import Flutter

class ScanPreviewFactory : NSObject, FlutterPlatformViewFactory {
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return ScanPreview(frame: frame, viewId: viewId, args: args)
    }
}
