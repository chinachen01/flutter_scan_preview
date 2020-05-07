package com.chinachen01.scan_preview

import android.content.Context
import android.graphics.Color
import android.util.Log
import android.view.View
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BasicMessageChannel.Reply
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import me.dm7.barcodescanner.core.IViewFinder
import me.dm7.barcodescanner.core.ViewFinderView
import me.dm7.barcodescanner.zxing.ZXingScannerView
import com.google.zxing.Result as ZxinResult


/**
 * - author: [chenyong](chinachen6653@gmail.com)
 * - version: 1.0.0
 * - since: 2020/5/7 1:42 PM
 *
 * 内容描述区域
 *
 */
class ScanPreviewController(context: Context,
                            id: Int,
                            binaryMessenger: BinaryMessenger,
                            val params: Any?) : PlatformView, MethodChannel.MethodCallHandler, BasicMessageChannel.MessageHandler<Any>, ZXingScannerView.ResultHandler{
    companion object {
        const val MESSAGE_CHANNEL = "scan_preview_message"
    }
    private val scanPreview = object : ZXingScannerView(context) {
        override fun createViewFinderView(context: Context?): IViewFinder {
            val viewFinderView = ViewFinderView(context)
            val args = params as Map<*, *>
            val laserColor : Long = args["laserColor"] as Long
            viewFinderView.setLaserColor(laserColor.toInt())
            viewFinderView.setLaserEnabled(true)
            val borderColor: Long = args["borderColor"] as Long
            viewFinderView.setBorderColor(borderColor.toInt())
//            viewFinderView.setBorderStrokeWidth(mBorderWidth)
//            viewFinderView.setBorderLineLength(mBorderLength)
//            viewFinderView.setMaskColor(mMaskColor)
//
//            viewFinderView.setBorderCornerRounded(mRoundedCorner)
//            viewFinderView.setBorderCornerRadius(mCornerRadius)
//            viewFinderView.setSquareViewFinder(mSquaredFinder)
//            viewFinderView.setViewFinderOffset(mViewFinderOffset)
            return viewFinderView
        }
    }
    private val methodChannel = MethodChannel(binaryMessenger, "${ScanPreviewPlugin.VIEW_TYPE}_$id")
    private val messageChannel = BasicMessageChannel(binaryMessenger, MESSAGE_CHANNEL, StandardMessageCodec())

    init {
        methodChannel.setMethodCallHandler(this)
        scanPreview.setResultHandler(this)
    }

    override fun getView(): View {
        return scanPreview
    }

    override fun dispose() {
        scanPreview.stopCamera()
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "scan#startCamera" -> {
                startCamera()
                result.success("ok")
            }
            "scan#stopCamera" -> {
                stopCamera()
                result.success("ok")
            }
        }
    }

    private fun startCamera() {
        scanPreview.startCamera()
    }

    private fun stopCamera() {
        scanPreview.stopCamera()
    }

    override fun onMessage(obj: Any?, rely: Reply<Any>) {

    }

    override fun handleResult(rawResult: ZxinResult?) {
        rawResult ?: return
        messageChannel.send(rawResult.text)
    }
}