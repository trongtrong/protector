package com.puzzletak.flutter_protector

import android.content.Context
import com.puzzletak.library.EmulatorSuperCheckCallback
import com.puzzletak.library.PuzzleTakProtectorLib
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

class EmulatorChecker {
    suspend fun isEmulatorSuper(context: Context): String = suspendCoroutine { continuation ->
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

    suspend fun checkEmu(context: Context): String = suspendCoroutine { continuation ->
        try {
            continuation.resume(PuzzleTakProtectorLib.checkRun(context))
        } catch (e: Exception) {
            continuation.resumeWithException(e)
        }
    }


}