package com.puzzletak.flutter_protector

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import java.net.InetAddress
import java.net.NetworkInterface
import java.util.*

object VpnDetector {

    fun isVpnConnected(context: Context): Boolean {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val network = connectivityManager.activeNetwork
            val capabilities = connectivityManager.getNetworkCapabilities(network)
            return capabilities != null &&
                    (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_VPN) ||
                            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) ||
                            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) ||
                            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI))
        } else {
            @Suppress("DEPRECATION")
            val networkInfo = connectivityManager.activeNetworkInfo
            @Suppress("DEPRECATION")
            return networkInfo != null && networkInfo.isConnected &&
                    (networkInfo.type == ConnectivityManager.TYPE_VPN ||
                            networkInfo.type == ConnectivityManager.TYPE_MOBILE ||
                            networkInfo.type == ConnectivityManager.TYPE_ETHERNET ||
                            networkInfo.type == ConnectivityManager.TYPE_WIFI)
        }
    }

    fun isProxySet(): Boolean {
        return System.getProperty("http.proxyHost") != null ||
                System.getProperty("https.proxyHost") != null
    }

    fun isVpnUsingNetworkInterface(): Boolean {
        try {
            val networkInterfaces: Enumeration<NetworkInterface> = NetworkInterface.getNetworkInterfaces()
            while (networkInterfaces.hasMoreElements()) {
                val networkInterface: NetworkInterface = networkInterfaces.nextElement()
                if (networkInterface.name.contains("tun") || networkInterface.name.contains("ppp")) {
                    return true
                }
            }
        } catch (e: Exception) {
            // Handle exceptions, e.g., logging
        }
        return false
    }

    fun getLocalIpAddress(): String? {
        try {
            val en = NetworkInterface.getNetworkInterfaces()
            while (en.hasMoreElements()) {
                val intf = en.nextElement()
                val enumIpAddr = intf.inetAddresses
                while (enumIpAddr.hasMoreElements()) {
                    val inetAddress = enumIpAddr.nextElement()
                    if (!inetAddress.isLoopbackAddress && inetAddress is java.net.Inet4Address) {
                        return inetAddress.getHostAddress()
                    }
                }
            }
        } catch (ex: Exception) {
            //Log.e("IP Address", ex.toString())
        }
        return null
    }

    fun isPublicIP(ipAddress: String): Boolean {
        try {
            val inetAddress = InetAddress.getByName(ipAddress)
            return !inetAddress.isSiteLocalAddress && !inetAddress.isLoopbackAddress
        } catch (e: Exception) {
            // Handle exceptions
        }
        return false
    }
}