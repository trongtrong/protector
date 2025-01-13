package com.puzzletak.flutter_protector

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import java.net.InetAddress
import java.net.NetworkInterface
import java.util.*

object VpnDetector {

    /**
     * Check if VPN is connected.
     *
     * @param context The application context.
     * @return `true` if VPN is connected, otherwise `false`.
     */
    fun isVpnConnected(context: Context): Boolean {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val network = connectivityManager.activeNetwork
            val capabilities = connectivityManager.getNetworkCapabilities(network)
            capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_VPN) == true
        } else {
            @Suppress("DEPRECATION")
            val networkInfo = connectivityManager.activeNetworkInfo
            @Suppress("DEPRECATION")
            networkInfo?.type == ConnectivityManager.TYPE_VPN
        }
    }

    /**
     * Check if a proxy is set on the device.
     *
     * @return `true` if a proxy is set, otherwise `false`.
     */
    fun isProxySet(): Boolean {
        return System.getProperty("http.proxyHost") != null ||
                System.getProperty("https.proxyHost") != null
    }

    /**
     * Check if VPN is being used by inspecting network interfaces.
     *
     * @return `true` if VPN is detected via network interfaces, otherwise `false`.
     */
    fun isVpnUsingNetworkInterface(): Boolean {
        return try {
            NetworkInterface.getNetworkInterfaces()
                .toList()
                .any { it.name.contains("tun") || it.name.contains("ppp") }
        } catch (e: Exception) {
            // Log the exception if needed
            false
        }
    }

    /**
     * Get the local IP address of the device.
     *
     * @return The local IP address as a String, or `null` if not found.
     */
    fun getLocalIpAddress(): String? {
        return try {
            NetworkInterface.getNetworkInterfaces()
                .toList()
                .flatMap { it.inetAddresses.toList() }
                .firstOrNull { !it.isLoopbackAddress && it is java.net.Inet4Address }
                ?.hostAddress
        } catch (ex: Exception) {
            // Log the exception if needed
            null
        }
    }

    /**
     * Check if the given IP address is a public IP.
     *
     * @param ipAddress The IP address to check.
     * @return `true` if the IP is public, otherwise `false`.
     */
    fun isPublicIP(ipAddress: String): Boolean {
        return try {
            val inetAddress = InetAddress.getByName(ipAddress)
            !inetAddress.isSiteLocalAddress && !inetAddress.isLoopbackAddress
        } catch (e: Exception) {
            // Log the exception if needed
            false
        }
    }
}