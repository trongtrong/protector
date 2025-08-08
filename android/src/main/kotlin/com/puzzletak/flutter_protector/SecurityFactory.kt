package com.puzzletak.flutter_protector

import android.content.Context

class SecurityFactory {
    fun createProxyChecker(): IProxyChecker {
        return PCheckImpl()
    }

    fun createDevChecker(context: Context): IDevChecker {
        return DCheckImpl(context)
    }

}