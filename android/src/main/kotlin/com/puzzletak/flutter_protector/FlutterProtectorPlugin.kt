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

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "connectivity")
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
                "c" -> handleSniffingAppsCall(call, result)
                "d" -> result.success(RootChecker.isDeviceRooted(context))
                "f1" -> result.success(SecurityFactory().createProxyChecker().isProxyDetected())
                "g1" -> result.success(SecurityFactory().createDevChecker(context).isDeveloperDetected())
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
            result.error("INVALID_ARGS", "eror", null)
        }
    }

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

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        ioScope.cancel()
    }

}
