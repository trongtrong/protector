package com.puzzletak.flutter_protector

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Build
import android.provider.Settings
import android.text.TextUtils
import android.util.Log
import java.io.BufferedReader
import java.io.File
import java.io.IOException
import java.io.InputStreamReader

object EmulatorDetector {
    fun isEmulator(context: Context): Boolean {
        return checkBuildProperties() ||
                checkDeviceFeatures(context) ||
                checkFiles() ||
                checkQEmuFiles() ||
                checkProperties() ||
                checkPipes() ||
                checkRootFiles() ||
                checkUsbDriver(context) ||
                checkOpenGLRenderer()
    }

    private fun checkBuildProperties(): Boolean {
        val properties = arrayOf(
            Build.FINGERPRINT,
            Build.MODEL,
            Build.MANUFACTURER,
            Build.BRAND,
            Build.DEVICE,
            Build.PRODUCT
        )
        val checkValues = arrayOf(
            "generic", "vbox", "test-keys", "google_sdk", "Emulator",
            "Android SDK built for x86", "Genymotion"
        )

        properties.forEach { property ->
            checkValues.forEach { checkValue ->
                if (property.contains(checkValue, ignoreCase = true)) return true
            }
        }
        return false
    }

    private fun checkDeviceFeatures(context: Context): Boolean {
        val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        val gyroscope = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
        return accelerometer == null || gyroscope == null
    }

    private fun checkFiles(): Boolean {
        val paths = arrayOf(
            "/sbin/su", "/system/bin/su", "/system/xbin/su",
            "/data/local/xbin/su", "/data/local/bin/su",
            "/system/sd/xbin/su", "/system/bin/failsafe/su", "/data/local/su", "/su/bin/su"
        )
        return paths.any { File(it).exists() }
    }

    private fun checkQEmuFiles(): Boolean {
        val files = arrayOf("/dev/socket/qemud", "/dev/qemu_pipe")
        return files.any { File(it).exists() }
    }

    private fun checkProperties(): Boolean {
        val properties = arrayOf("init.svc.qemud", "init.svc.qemu-props")
        return try {
            BufferedReader(InputStreamReader(Runtime.getRuntime().exec("getprop").inputStream)).use { reader ->
                reader.lines().anyMatch { line -> properties.any { line.contains(it) } }
            }
        } catch (e: IOException) {
            Log.e("EmulatorDetector", "Error checking properties", e)
            false
        }
    }

    private fun checkPipes(): Boolean {
        return try {
            BufferedReader(InputStreamReader(Runtime.getRuntime().exec("ls /dev/socket").inputStream)).use { reader ->
                reader.lines().anyMatch { it.contains("qemud") }
            }
        } catch (e: IOException) {
            Log.e("EmulatorDetector", "Error checking pipes", e)
            false
        }
    }

    private fun checkRootFiles(): Boolean {
        val paths = arrayOf(
            "/system/app/Superuser.apk", "/sbin/su", "/system/bin/su", "/system/xbin/su",
            "/data/local/xbin/su", "/data/local/bin/su", "/system/sd/xbin/su",
            "/system/bin/failsafe/su", "/data/local/su", "/su/bin/su", "/system/xbin/busybox", "/system/bin/busybox"
        )
        return paths.any { File(it).exists() }
    }

    private fun checkUsbDriver(context: Context): Boolean {
        val usb = Settings.Secure.getString(context.contentResolver, Settings.Secure.ADB_ENABLED)
        return usb == "1"
    }

    private fun checkOpenGLRenderer(): Boolean {
        val opengl = System.getProperty("ro.opengles.version")
        return !TextUtils.isEmpty(opengl) && (opengl.contains("Google Inc.", ignoreCase = true) || opengl.contains("Android Emulator OpenGL ES Translator", ignoreCase = true))
    }
}