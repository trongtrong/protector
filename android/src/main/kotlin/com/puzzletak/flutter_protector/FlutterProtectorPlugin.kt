package com.puzzletak.flutter_protector

import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Build
import com.puzzletak.flutter_protector.VpnDetector
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import android.content.Context
import android.content.pm.PackageManager

/** FlutterProtectorPlugin */
class FlutterProtectorPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_protector")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "isEmulator" -> result.success(isEmulator())
      "checkForSniffingApps" -> {
        val sniffingPackages = call.arguments as? List<String> // Correctly receive arguments
        if (sniffingPackages != null) {
          result.success(checkForSniffingApps(sniffingPackages.toTypedArray()))
        } else {
          result.error("INVALID_ARGS", "Sniffing packages list is required", null)
        }
      }
      "isDeviceRooted" -> result.success(isDeviceRooted())
      "isVpnConnected" -> result.success(isVpnConnected())
      "isProxySet" -> result.success(isProxySet())
      "getLocalIpAddress" -> result.success(getLocalIpAddress())
      "isPublicIP" -> result.success(isPublicIP())
      "isVpnUsingNetworkInterface" -> result.success(isVpnUsingNetworkInterface())
      "getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
      else -> result.notImplemented()
    }
  }



  fun checkForSniffingApps(sniffingPackages : Array<String>): Boolean {
    val packageManager = context.packageManager

    return sniffingPackages.any { packageName ->
      try {
        packageManager.getPackageInfo(packageName, 0)
        true // Package is installed
      } catch (e: PackageManager.NameNotFoundException) {
        false
      }
    }
  }

  private fun isEmulator(): Boolean {
    return EmulatorDetector.isEmulator(context) || checkNoHardwareSensors()
  }
  private fun isDeviceRooted(): Boolean {
    return RootChecker.isDeviceRooted(context) || checkNoHardwareSensors()
  }
  private fun isVpnConnected(): Boolean {
    return VpnDetector.isVpnConnected(context)
  }

  private fun isProxySet(): Boolean {
    return VpnDetector.isProxySet(context)
  }
  private fun isVpnUsingNetworkInterface(): Boolean {
    return VpnDetector.isVpnUsingNetworkInterface(context)
  }
  private fun getLocalIpAddress(): Boolean {
    return VpnDetector.getLocalIpAddress(context)
  }

  private fun isPublicIP(): Boolean {
    return VpnDetector.isPublicIP(context)
  }

  private fun checkNoHardwareSensors(): Boolean {
    val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    return sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) == null
            || sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE) == null
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


}
