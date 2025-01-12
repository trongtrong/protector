package com.puzzletak.flutter_protector

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.text.TextUtils
import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader

object RootChecker {

    fun isDeviceRooted(context: Context): Boolean {
        return checkRootMethod1() || checkRootMethod2() || checkRootMethod3() ||
                checkSuBinary() || checkBusyboxBinary() || checkTestKeys() ||
                checkDangerousProperties() || checkRootApps(context)
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

    private fun checkRootApps(context: Context): Boolean {
        val packageManager = context.packageManager
        val rootPackages = arrayOf(
            "com.noshufou.android.su",
            "eu.chainfire.supersu",
            "com.koushikdutta.superuser",
            "com.thirdparty.superuser",
            "com.yellowes.su"
        )

        return rootPackages.any { packageName ->
            try {
                packageManager.getPackageInfo(packageName, 0)
                true // Package is installed
            } catch (e: PackageManager.NameNotFoundException) {
                false
            }
        }
    }
}