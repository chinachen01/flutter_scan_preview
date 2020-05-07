package com.chinachen01.scan_preview

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger

/**
 * - author: [chenyong](chinachen6653@gmail.com)
 * - version: 1.0.0
 * - since: 2020/5/7 1:49 PM
 *
 * 内容描述区域
 *
 */
class ScanPreviewBuilder {
    fun build(
            context: Context,
            id: Int,
            binaryMessenger: BinaryMessenger,
            params: Any?

    ): ScanPreviewController {
        return ScanPreviewController(
                context, id, binaryMessenger, params
        )
    }
}