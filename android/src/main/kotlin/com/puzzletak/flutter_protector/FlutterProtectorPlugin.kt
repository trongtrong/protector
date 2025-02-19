package com.puzzletak.flutter_protector

import android.app.Activity
import android.content.Context
import android.content.SharedPreferences
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
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

import kotlinx.coroutines.*
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

class FlutterProtectorPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

  private lateinit var channel: MethodChannel
  private lateinit var context: Context
  private var activity: Activity? = null
  private val ioScope = CoroutineScope(Dispatchers.IO)
  private lateinit var preferences: SharedPreferences

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    restoreScreenshotState()
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    restoreScreenshotState()
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    preferences = context.getSharedPreferences("puzzletak_pref", Context.MODE_PRIVATE)
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_protector")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    try {
      when (call.method) {
//        "isEmulatorOld" -> result.success(isEmulatorOld())
        "isEmulatorSuper" -> handleAsyncCall(result) { isEmulatorSuper() }
        "checkResultSecurityInfo" -> handleAsyncCall(result) { checkResultSecurityInfo() }
        "checkResultSecurity" -> handleAsyncCall(result) { checkResultSecurity() }
        "checkForSniffingApps" -> handleSniffingAppsCall(call, result)
        "screenshotSecurity" -> handleScreenshotSecurityCall(call, result)
        "isDeviceRooted" -> result.success(isDeviceRooted())
        "getBuildInfo" -> result.success(getBuildInfo())
        "checkTelephonyManager" -> result.success(checkTelephonyManager())
        "isBlueStacks" -> result.success(isBlueStacks())
        "phoneNumber" -> result.success(phoneNumber())
        "deviceId" -> result.success(deviceId())
        "isVpnConnected" -> result.success(isVpnConnected())
        "isProxySet" -> result.success(isProxySet())
        "isDeveloperOptionsEnabled" -> result.success(isDeveloperOptionsEnabled())
        "getLocalIpAddress" -> result.success(getLocalIpAddress())
        "isPublicIP" -> handleIpCheck(call, result)
        "isVpnUsingNetworkInterface" -> result.success(isVpnUsingNetworkInterface())
        "getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
        else -> result.notImplemented()
      }
    } catch (e: Exception) {
      result.error("UNEXPECTED_ERROR", "An unexpected error occurred: ${e.message}", null)
    }
  }

  private fun handleAsyncCall(result: MethodChannel.Result, action: suspend () -> Any) {
    ioScope.launch {
      try {
        val data = action()
        withContext(Dispatchers.Main) { result.success(data) }
      } catch (e: Exception) {
        withContext(Dispatchers.Main) {
          result.error("ERROR", "Failed: ${e.message}", null)
        }
      }
    }
  }

  private fun handleSniffingAppsCall(call: MethodCall, result: MethodChannel.Result) {
    val sniffingPackages = call.arguments as? List<*>
    if (sniffingPackages != null && sniffingPackages.all { it is String }) {
      result.success(checkForSniffingApps(sniffingPackages.filterIsInstance<String>().toTypedArray()))
    } else {
      result.error("INVALID_ARGS", "Sniffing packages list is required and should contain only strings", null)
    }
  }

  private fun handleScreenshotSecurityCall(call: MethodCall, result: MethodChannel.Result) {
    val enabled = call.arguments as? Boolean
    if (enabled != null) {
      result.success(screenshotSecurity(enabled))
    } else {
      result.error("INVALID_ARGS", "Invalid argument for screenshot security", null)
    }
  }

  private fun handleIpCheck(call: MethodCall, result: MethodChannel.Result) {
    val ip = call.arguments as? String
    if (ip != null) {
      result.success(isPublicIP(ip))
    } else {
      result.error("INVALID_ARGS", "IP address is required", null)
    }
  }

  private suspend fun isEmulatorSuper(): Boolean = suspendCoroutine { continuation ->
    try {
      PuzzleTakProtectorLib.checkIsRunningInEmulatorPT(context, object : EmulatorSuperCheckCallback {
        override fun checkEmulator(emulatorInfo: Int) {
          continuation.resume(emulatorInfo >= 2 && isBlueStacks() && checkTelephonyManager())
        }

        override fun findEmulator(emulatorInfo: String) {}

        override fun detailsEmulator(emulatorInfo: MutableMap<String, Any>?) {}
      })
    } catch (e: Exception) {
      continuation.resumeWithException(e)
    }
  }

  private fun checkTelephonyManager():Boolean{
    return PuzzleTakProtectorLib.checkTelephonyManager(context)
  }
  private fun isBlueStacks():Boolean{
    return PuzzleTakProtectorLib.isBlueStacks()
  }


  private suspend fun checkResultSecurityInfo(): Map<String, Any> = suspendCoroutine { continuation ->
    try {
      PuzzleTakProtectorLib.checkIsRunningInEmulatorPTResult(context, object : EmulatorSuperCheckCallback {
        override fun detailsEmulator(emulatorInfo: MutableMap<String, Any>?) {
          continuation.resume(emulatorInfo ?: emptyMap())
        }

        override fun findEmulator(emulatorInfo: String) {}

        override fun checkEmulator(emulatorInfo: Int) {}
      })
    } catch (e: Exception) {
      continuation.resumeWithException(e)
    }
  }

  private suspend fun checkResultSecurity(): Int = suspendCoroutine { continuation ->
    try {
      PuzzleTakProtectorLib.checkIsRunningInEmulatorPT(context, object : EmulatorSuperCheckCallback {
        override fun checkEmulator(emulatorInfo: Int) {
          continuation.resume(emulatorInfo)
        }

        override fun findEmulator(emulatorInfo: String) {}

        override fun detailsEmulator(emulatorInfo: MutableMap<String, Any>?) {}
      })
    } catch (e: Exception) {
      continuation.resumeWithException(e)
    }
  }

  private fun isEmulatorOld(): Boolean = EmulatorDetectors.isEmulator(context)

  private fun checkForSniffingApps(sniffingPackages: Array<String>): Boolean {
    val packageManager = context.packageManager
    return sniffingPackages.any { packageName ->
      try {
        packageManager.getPackageInfo(packageName, 0)
        true
      } catch (e: PackageManager.NameNotFoundException) {
        false
      }
    }
  }

  private fun restoreScreenshotState() {
    val isSecure = preferences.getBoolean("isSecure_app", false)
    screenshotSecurity(isSecure)
  }

  private fun screenshotSecurity(enable: Boolean): Boolean {
    activity?.let {
      if (enable) ScreenshotUtil.enableScreenshotBlocking(it)
      else ScreenshotUtil.disableScreenshotBlocking(it)
      preferences.edit().putBoolean("isSecure_app", enable).apply()
    } ?: Log.e("FlutterProtectorPlugin", "Activity is null!")
    return enable
  }

  private fun isDeviceRooted(): Boolean = RootChecker.isDeviceRooted(context)

  private fun isVpnConnected(): Boolean = VpnDetector.isVpnConnected(context)

  private fun isDeveloperOptionsEnabled(): Boolean = DeveloperOptionsChecker.isDeveloperOptionsEnabled(context)

  private fun isProxySet(): Boolean = VpnDetector.isProxySet()

  private fun isVpnUsingNetworkInterface(): Boolean = VpnDetector.isVpnUsingNetworkInterface()

  private fun getLocalIpAddress(): String? = VpnDetector.getLocalIpAddress()

  private fun isPublicIP(ip: String): Boolean = VpnDetector.isPublicIP(ip)

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    ioScope.cancel()
  }

  private fun getBuildInfo(): Map<String, Any?> = EmulatorDetectors.getBuildInfo()

  private fun phoneNumber(): String? = EmulatorDetectors.getPhoneNumber(context)

  private fun deviceId(): String? = EmulatorDetectors.getDeviceId(context)
}