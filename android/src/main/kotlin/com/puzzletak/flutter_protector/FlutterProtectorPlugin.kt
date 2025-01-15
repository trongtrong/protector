package com.puzzletak.flutter_protector

import android.content.Context
import android.content.pm.PackageManager
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Build
import android.util.Log
import com.puzzletak.flutter_protector.VpnDetector
import com.puzzletak.library.EmulatorSuperCheckCallback
import com.puzzletak.library.PuzzleTakProtectorLib
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class FlutterProtectorPlugin : FlutterPlugin, MethodCallHandler {

  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_protector")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "isEmulator" -> result.success(isEmulator())
      "isEmulatorSuper" -> result.success(isEmulatorSuper())
      "checkForSniffingApps" -> {
        val sniffingPackages = call.arguments as? List<String>
        if (sniffingPackages != null) {
          result.success(checkForSniffingApps(sniffingPackages.toTypedArray()))
        } else {
          result.error("INVALID_ARGS", "Sniffing packages list is required", null)
        }
      }
      "isDeviceRooted" -> result.success(isDeviceRooted())
      "checkIsEmulator" -> {
        val isEmulator: Boolean = EasyProtectorLib.checkIsRunningInEmulator(context, null)
        result.success(isEmulator)
      }
      "getBuildInfo" -> result.success(getBuildInfo())
      "phoneNumber" -> result.success(phoneNumber())
      "deviceId" -> result.success(deviceId())
      "isVpnConnected" -> result.success(isVpnConnected())
      "isProxySet" -> result.success(isProxySet())
      "isDeveloperOptionsEnabled" -> result.success(isDeveloperOptionsEnabled())
      "getLocalIpAddress" -> result.success(getLocalIpAddress())
      "isPublicIP" -> {
        val ip = call.arguments as? String
        if (ip != null) {
          result.success(isPublicIP(ip))
        } else {
          result.error("INVALID_ARGS", "IP address is required", null)
        }
      }
      "isVpnUsingNetworkInterface" -> result.success(isVpnUsingNetworkInterface())
      "getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
      else -> result.notImplemented()
    }
  }

  private fun deviceId(): String? {
    val deviceId = EmulatorDetectors.getDeviceId(context)
    println("Device ID: $deviceId")
    return deviceId
  }
  private fun getBuildInfo(): Map<String, Any?> {
    val data = EmulatorDetectors.getBuildInfo()
    return data
  }
  private fun phoneNumber(): String? {
    val phoneNumber = EmulatorDetectors.getPhoneNumber(context)
    println("Phone Number: $phoneNumber")
    return  phoneNumber
  }
  private fun isEmulatorSuper(): Boolean {
    var count  = 0
    PuzzleTakProtectorLib.checkIsRunningInEmulator(context, object : EmulatorSuperCheckCallback {
      override fun findEmulator(emulatorInfo: String) {
        Log.d("PUZZLETAK", "checkEmulator: $emulatorInfo")
      }

      override fun checkEmulator(emulatorInfo: Int) {
        count = emulatorInfo
        Log.d("PUZZLETAK", "checkEmulator: $emulatorInfo")
      }
    })
    return (count > 2)
  }
  private fun isEmulator(): Boolean {
    val isEmulatora = EmulatorDetectors.isEmulator(context)
    if (isEmulatora) {
      println("This device is an emulator.")
    } else {
      println("This device is a real physical device.")
    }
    return isEmulatora
  }

  private fun checkForSniffingApps(sniffingPackages: Array<String>?): Boolean {
    val packages = sniffingPackages ?: emptyArray()
    val packageManager = context.packageManager
    return packages.any { packageName ->
      try {
        packageManager.getPackageInfo(packageName, 0)
        true // Package is installed
      } catch (e: PackageManager.NameNotFoundException) {
        false
      }
    }
  }

  private fun isDeviceRooted(): Boolean {
    return RootChecker.isDeviceRooted(context)
  }

  private fun isVpnConnected(): Boolean {
    return VpnDetector.isVpnConnected(context)
  }

  private fun isDeveloperOptionsEnabled(): Boolean {
    return DeveloperOptionsChecker.isDeveloperOptionsEnabled(context)
  }

  private fun isProxySet(): Boolean {
    return VpnDetector.isProxySet()
  }

  private fun isVpnUsingNetworkInterface(): Boolean {
    return VpnDetector.isVpnUsingNetworkInterface()
  }

  private fun getLocalIpAddress(): String? {
    return VpnDetector.getLocalIpAddress()
  }

  private fun isPublicIP(ip: String?): Boolean {
    return ip?.let { VpnDetector.isPublicIP(it) } ?: false
  }

  private fun checkNoHardwareSensors(): Boolean {
    val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    return sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) == null ||
            sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE) == null
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}