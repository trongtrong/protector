package com.puzzletak.flutter_protector

import android.content.Context

class DCheckImpl(private val context: Context) : IDevChecker {
    override fun isDeveloperDetected(): Boolean {
        return DeveloperOptionsChecker.isDeveloperOptionsEnabled(context)
    }

}