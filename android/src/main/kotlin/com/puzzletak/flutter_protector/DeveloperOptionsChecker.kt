package com.puzzletak.flutter_protector


import android.content.Context
import android.provider.Settings

object DeveloperOptionsChecker {

    /**
     * Check if Developer Options are enabled on the device.
     *
     * @param context The application context.
     * @return `true` if Developer Options are enabled, otherwise `false`.
     */
    fun isDeveloperOptionsEnabled(context: Context): Boolean {
        return try {
            // Check the system setting for Developer Options
            Settings.Global.getInt(
                context.contentResolver,
                Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
                0
            ) == 1
        } catch (e: Exception) {
            // Handle exceptions (e.g., security exceptions)
            false
        }
    }
}