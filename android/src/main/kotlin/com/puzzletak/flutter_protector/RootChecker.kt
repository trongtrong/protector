package com.puzzletak.flutter_protector

import android.content.Context
import android.os.Build
import android.os.Debug
import android.text.TextUtils
import java.io.BufferedReader
import java.io.File
import java.io.FileReader
import java.io.InputStreamReader

object RootChecker {

    /**
     * Check if the device is rooted.
     *
     * @return `true` if the device is rooted, otherwise `false`.
     */
    fun isDeviceRooted(context: Context): Boolean {
        return checkRootMethod1() || checkRootMethod2() || checkRootMethod3() ||
                checkSuBinary() || checkBusyboxBinary() || checkTestKeys() ||
                checkDangerousProperties()
    }

    // Method 1: Check for common root paths
    private fun checkRootMethod1(): Boolean {
        val paths = arrayOf(
            "/system/app/Superuser.apk",
            "/sbin/su",
            "/system/bin/su",
            "/system/xbin/su",
            "/data/local/xbin/su",
            "/data/local/bin/su",
            "/system/sd/xbin/su",
            "/system/bin/failsafe/su",
            "/data/local/su",
            "/su/bin/su"
        )
        return paths.any { File(it).exists() }
    }

    // Method 2: Check for build tags
    private fun checkRootMethod2(): Boolean {
        val buildTags = Build.TAGS
        return buildTags != null && buildTags.contains("test-keys")
    }

    // Method 3: Check for presence of "su" binary
    private fun checkRootMethod3(): Boolean {
        return try {
            Runtime.getRuntime().exec("su")
            true // If the command executes without throwing an exception, it's likely rooted
        } catch (e: Exception) {
            false
        }
    }

    private fun checkSuBinary(): Boolean {
        return checkBinary("su")
    }

    fun checkDebugAttach(): Boolean {
        if (Debug.isDebuggerConnected() || Debug.waitingForDebugger()) {
            return true
        }

        // Check thêm bằng native cách đọc TracerPid
        try {
            BufferedReader(FileReader("/proc/self/status")).use { reader ->
                var line: String?
                while (reader.readLine().also { line = it } != null) {
                    if (line!!.startsWith("TracerPid:")) {
                        val tracerPid = line!!.split("\\s+".toRegex())[1].toInt()
                        if (tracerPid != 0) return true
                    }
                }
            }
        } catch (_: Exception) {
        }

        return false
    }

    private fun checkBusyboxBinary(): Boolean {
        return checkBinary("busybox")
    }

    private fun checkBinary(binaryName: String): Boolean {
        return try {
            val process = Runtime.getRuntime().exec(arrayOf("/system/xbin/$binaryName", "-v"))
            val reader = BufferedReader(InputStreamReader(process.inputStream))
            reader.readLine() != null
        } catch (e: Exception) {
            false
        }
    }

    private fun checkTestKeys(): Boolean {
        val buildTags = Build.TAGS
        return buildTags != null && buildTags.contains("test-keys")
    }

    private fun checkDangerousProperties(): Boolean {
        val dangerousProperties = arrayOf(
            "ro.debuggable",
            "ro.secure",
            "ro.allow.mock.location"
        )

        return dangerousProperties.any { property ->
            try {
                val value = System.getProperty(property)
                !TextUtils.isEmpty(value) && value == "1"
            } catch (e: Exception) {
                false
            }
        }
    }

}
