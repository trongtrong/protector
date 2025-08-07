package com.puzzletak.flutter_protector

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.SharedPreferences
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.annotation.RequiresPermission
import com.puzzletak.library.EmulatorDetailsCallback
import com.puzzletak.library.EmulatorSuperCheckCallback
import com.puzzletak.library.PuzzleTakProtectorLib
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
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
        "a" -> EmulatorCheckHandlerA().run(context, result)
        "a1" -> CheckEmu().run(context, result)
        "a2" -> handleAsyncCall(result) { isEmulatorDetails() }
        "b" -> handleAsyncCall(result) { checkResultSecurityInfo() }
        "b1" -> handleAsyncCall(result) { checkResultSecurity() }
        "c" -> handleSniffingAppsCall(call, result)
        "d" -> result.success(isDeviceRooted())
        "e" -> handleAsyncCall(result) { infoEmulatorCheckResult() }
        "e1" -> result.success(isBlueStacks())
        "f1" -> result.success(isProxySet())
        "g1" -> result.success(isDeveloperOptionsEnabled())
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

    private suspend fun checkEmu(): String = suspendCoroutine { continuation ->
        try {
          continuation.resume(PuzzleTakProtectorLib.checkRun(context))
        } catch (e: Exception) {
            continuation.resumeWithException(e)
        }
    }
    private suspend fun isEmulatorSuper(): String = suspendCoroutine { continuation ->
        try {
            PuzzleTakProtectorLib.checkIsRunningInEmulatorPTResult(context, object :
              EmulatorSuperCheckCallback {
                override fun checkEmulator(emulatorInfo: String) {
                    continuation.resume(emulatorInfo)
                }

                override fun findEmulator(emulatorInfo: String) {}

                override fun detailsEmulator(emulatorInfo: MutableMap<String, Any>?) {}
            })
        } catch (e: Exception) {
            continuation.resumeWithException(e)
        }
    }

    private suspend fun isEmulatorDetails(): MutableList<MutableMap<String, Any>> = suspendCoroutine { continuation ->
        try {
            PuzzleTakProtectorLib.readSysPropertyPTDetailed(context, object :
              EmulatorDetailsCallback {
                override fun detailsEmulator(result: MutableList<MutableMap<String, Any>>?) {
                    if(result != null){
                        continuation.resume(result)
                    }

                }

            })
        } catch (e: Exception) {
            continuation.resumeWithException(e)
        }
    }

    private suspend fun infoEmulatorCheckResult(): String = suspendCoroutine { continuation ->
        try {
            PuzzleTakProtectorLib.checkIsRunningInEmulatorPTResult(context, object :
              EmulatorSuperCheckCallback {
                override fun checkEmulator(emulatorInfo: String) {

                }

                override fun findEmulator(emulatorInfo: String) {
                    continuation.resume(emulatorInfo)
                }

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
      PuzzleTakProtectorLib.checkIsRunningInEmulatorPTResult(context, object :
        EmulatorSuperCheckCallback {
        override fun detailsEmulator(emulatorInfo: MutableMap<String, Any>?) {
          continuation.resume(emulatorInfo ?: emptyMap())
        }

        override fun findEmulator(emulatorInfo: String) {}

        override fun checkEmulator(emulatorInfo: String) {}
      })
    } catch (e: Exception) {
      continuation.resumeWithException(e)
    }
  }

  private suspend fun checkResultSecurity(): String = suspendCoroutine { continuation ->
    try {
      PuzzleTakProtectorLib.checkIsRunningInEmulatorPT(context, object : EmulatorSuperCheckCallback {
        override fun checkEmulator(emulatorInfo: String) {
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

  private fun openDeveloperOption() = DeveloperOptionsChecker.openDeveloperOption(context)
  private fun openLocationSettings() = DeveloperOptionsChecker.openLocationSettings(context)
  private fun openBluetoothSettings() = DeveloperOptionsChecker.openBluetoothSettings(context)
  private fun openDataUsageSettings() = DeveloperOptionsChecker.openDataUsageSettings(context)
  private fun openSecuritySettings() = DeveloperOptionsChecker.openSecuritySettings(context)
  private fun openAccessibilitySettings() = DeveloperOptionsChecker.openAccessibilitySettings(context)
  private fun openDisplaySettings() = DeveloperOptionsChecker.openDisplaySettings(context)
  private fun openSoundSettings() = DeveloperOptionsChecker.openSoundSettings(context)
  private fun openVpnSettings() = DeveloperOptionsChecker.openVpnSettings(context)
  private fun openBatteryOptimizationSettings() = BatteryOptimizationHelper.openBatteryOptimizationSettings(context)
  private fun isBatteryOptimizationEnabled() = BatteryOptimizationHelper.isBatteryOptimizationEnabled(context)
  private fun requestDisableBatteryOptimization() = BatteryOptimizationHelper.requestDisableBatteryOptimization(context)

  private fun isProxySet(): Boolean = VpnDetector.isProxySet()

  private fun isVpnUsingNetworkInterface(): Boolean = VpnDetector.isVpnUsingNetworkInterface()

  private fun getLocalIpAddress(): String? = VpnDetector.getLocalIpAddress()

  private fun isPublicIP(ip: String): Boolean = VpnDetector.isPublicIP(ip)

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    ioScope.cancel()
  }

  private fun getBuildInfo(): Map<String, Any?> = EmulatorDetectors.getBuildInfo()

  @RequiresApi(Build.VERSION_CODES.LOLLIPOP_MR1)
  @RequiresPermission(Manifest.permission.READ_PHONE_STATE)
  private fun phoneNumber(): String? = EmulatorDetectors.getPhoneNumber(context)

  private fun deviceId(): String? = EmulatorDetectors.getDeviceId(context)
}