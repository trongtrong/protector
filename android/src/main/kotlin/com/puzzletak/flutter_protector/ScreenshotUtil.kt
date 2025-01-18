package com.puzzletak.flutter_protector

import android.app.Activity
import android.view.WindowManager

class ScreenshotUtil {
    companion object {
        // Method to enable screenshot blocking
        fun enableScreenshotBlocking(activity: Activity) {
            activity.window.setFlags(
                WindowManager.LayoutParams.FLAG_SECURE,
                WindowManager.LayoutParams.FLAG_SECURE
            )
        }

        // Method to disable screenshot blocking
        fun disableScreenshotBlocking(activity: Activity) {
            activity.window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
        }
    }
}
