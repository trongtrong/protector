package com.puzzletak.flutter_protector

import android.content.Context
import io.flutter.plugin.common.MethodChannel

class EmulatorCheckHandlerA {
    fun run(context: Context, result: MethodChannel.Result) {
        AsyncHelper.handle(result) { EmulatorChecker().isEmulatorSuper(context) }
    }
}