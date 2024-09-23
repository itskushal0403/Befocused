package com.example.befocused

import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.befocused/app_usage"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "isAppActive") {
                val packageName = call.argument<String>("packageName")
                val isActive = isAppActive(packageName)
                if (isActive != null) {
                    result.success(isActive)
                } else {
                    result.error("UNAVAILABLE", "App usage status not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun isAppActive(packageName: String?): Boolean {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val endTime = System.currentTimeMillis()
        val beginTime = endTime - 1000 * 60 * 5
        val usageStatsList = usageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, beginTime, endTime)
        if (usageStatsList != null) {
            for (usageStats in usageStatsList) {
                if (usageStats.packageName == packageName) {
                    return true
                }
            }
        }
        return false
    }
}
