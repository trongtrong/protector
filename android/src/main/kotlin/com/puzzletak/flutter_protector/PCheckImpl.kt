package com.puzzletak.flutter_protector

class PCheckImpl : IProxyChecker {
    override fun isProxyDetected(): Boolean {
        return VpnDetector.isProxySet()
    }
}