package com.puzzletak.flutter_protector

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import io.flutter.plugin.common.MethodChannel

object AsyncHelper {
    private val scope = CoroutineScope(Dispatchers.IO)

    fun handle(result: MethodChannel.Result, action: suspend () -> Any) {
        scope.launch {
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
}