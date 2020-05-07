package com.chinachen01.scan_preview

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * - author: [chenyong](chinachen6653@gmail.com)
 * - version: 1.0.0
 * - since: 2020/5/6 5:48 PM
 *
 * 内容描述区域
 *
 */
class SharePlatformViewFactory(val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, id: Int, args: Any?): PlatformView {
        context ?: throw Exception("context be null")
        return ScanPreviewBuilder().build(context, id, messenger, args)
    }
}