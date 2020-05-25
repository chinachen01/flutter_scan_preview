package com.chinachen01.scan_preview

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger

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