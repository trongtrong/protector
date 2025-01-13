package com.puzzletak.flutter_protector

import android.content.Context
import android.os.Build
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager
import java.io.File

object EmulatorDetectors {

    /**
     * Check if the device is a real physical device.
     *
     * @param context The application context.
     * @return `true` if the device is real, otherwise `false`.
     */
    fun isRealDevice(context: Context): Boolean {
        return !isEmulator(context)
    }

    /**
     * Check if the device is an emulator.
     *
     * @param context The application context.
     * @return `true` if the device is an emulator, otherwise `false`.
     */
    fun isEmulator(context: Context): Boolean {
        return checkBuildProperties() ||
                checkHardware() ||
                checkEmulatorFiles() ||
                checkSensors(context)
    }

    fun getBuildInfo(): Map<String, Any> {
        return mapOf(
            "BRAND" to Build.BRAND,
            "DEVICE" to Build.DEVICE,
            "MODEL" to Build.MODEL,
            "PRODUCT" to Build.PRODUCT,
            "MANUFACTURER" to Build.MANUFACTURER,
            "HARDWARE" to Build.HARDWARE,
            "FINGERPRINT" to Build.FINGERPRINT,
            "BOARD" to Build.BOARD,
            "BOOTLOADER" to Build.BOOTLOADER,
            "DISPLAY" to Build.DISPLAY,
            "HOST" to Build.HOST,
            "ID" to Build.ID,
            "TAGS" to Build.TAGS,
            "TYPE" to Build.TYPE,
            "USER" to Build.USER,
            "TIME" to Build.TIME.toString(),
            "RADIO_VERSION" to (Build.getRadioVersion() ?: ""),
            "SERIAL" to Build.SERIAL,
            "SUPPORTED_ABIS" to Build.SUPPORTED_ABIS.toList(),
            "SUPPORTED_32_BIT_ABIS" to Build.SUPPORTED_32_BIT_ABIS.toList(),
            "SUPPORTED_64_BIT_ABIS" to Build.SUPPORTED_64_BIT_ABIS.toList(),
            "VERSION.SDK_INT" to Build.VERSION.SDK_INT,
            "VERSION.RELEASE" to Build.VERSION.RELEASE,
            "VERSION.INCREMENTAL" to Build.VERSION.INCREMENTAL,
        )
    }

    // Method 1: Check build properties
    private fun checkBuildProperties(): Boolean {
        return (Build.FINGERPRINT.startsWith("generic") ||
                Build.FINGERPRINT.startsWith("unknown") ||
                Build.MODEL.contains("google_sdk") ||
                Build.MODEL.contains("Emulator") ||
                Build.MODEL.contains("Android SDK built for x86") ||
                Build.MANUFACTURER.contains("Genymotion") ||
                Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic") ||
                Build.PRODUCT == "google_sdk" ||
                Build.HARDWARE.contains("goldfish") ||
                Build.HARDWARE.contains("ranchu") ||
                Build.HARDWARE.contains("vbox86"))
    }

    // Method 2: Check hardware information
    private fun checkHardware(): Boolean {
        kotlin.io.print(Build.HARDWARE)
        return (Build.HARDWARE == "goldfish" ||
                Build.HARDWARE == "ranchu" ||
                Build.HOST == "dev" ||
                Build.HARDWARE.contains("vbox86"))
    }

    // Method 3: Check for emulator-specific files
    private fun checkEmulatorFiles(): Boolean {
        val knownEmulatorFiles = arrayOf(
            "/dev/socket/qemud",
            "/dev/qemu_pipe",
            "/system/lib/libc_malloc_debug_qemu.so",
            "/sys/qemu_trace",
            "/system/bin/qemu-props"
        )
        return knownEmulatorFiles.any { File(it).exists() }
    }

    // Method 4: Check telephony information
    private fun checkTelephony(context: Context): Boolean {
        return !checkImei(context) || getPhoneNumber(context) == null
    }

    // Method 5: Check for missing hardware sensors
    private fun checkSensors(context: Context): Boolean {
        val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as android.hardware.SensorManager
        val accelerometer = sensorManager.getDefaultSensor(android.hardware.Sensor.TYPE_ACCELEROMETER)
        val gyroscope = sensorManager.getDefaultSensor(android.hardware.Sensor.TYPE_GYROSCOPE)
        return accelerometer == null || gyroscope == null
    }

    /**
     * Get the device ID (IMEI or MEID).
     */
    fun getDeviceId(context: Context): String? {
        return try {
            (context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager)?.let { telephonyManager ->
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    telephonyManager.imei
                } else {
                    telephonyManager.deviceId
                }
            }
        } catch (e: Exception) {
            null
        }
    }

    /**
     * Get the phone number (if available).
     */
    fun getPhoneNumber(context: Context): String? {
        return try {
            val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
            val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                subscriptionManager.activeSubscriptionInfoList?.firstOrNull()?.number
            } else {
                telephonyManager.line1Number
            }
        } catch (e: Exception) {
            null
        }
    }

    /**
     * Check if the IMEI is valid (not an emulator).
     *
     * @param context The application context.
     * @return `true` if the IMEI is valid (real device), otherwise `false`.
     */
    fun checkImei(context: Context): Boolean {
        return try {
            val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            val imei = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                telephonyManager.imei
            } else {
                telephonyManager.deviceId
            }

            // Known emulator IMEI
            val knownImei = "000000000000000"

            imei != knownImei
        } catch (e: Exception) {
            false
        }
    }
}