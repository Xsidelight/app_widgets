package com.example.app_widgets

import android.appwidget.AppWidgetManager
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.xside.appWidgets/widget"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "updateWidgetData") {
                val newData = call.argument<String>("data")
                // Call a function to update widget through your provider.
                updateWidget(newData)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun updateWidget(data: String?) {
        val appWidgetManager = AppWidgetManager.getInstance(this)
        val componentName = android.content.ComponentName(this, MyWidgetProvider::class.java)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
        
        // Create an intent to update all widget instances
        val intent = Intent(this, MyWidgetProvider::class.java).apply {
            action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
            putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
            putExtra("widgetData", data)
        }
        
        // Send the broadcast to trigger the update
        sendBroadcast(intent)
    }
}
