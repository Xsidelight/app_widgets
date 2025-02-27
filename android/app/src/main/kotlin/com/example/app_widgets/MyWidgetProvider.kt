package com.example.app_widgets

import android.appwidget.AppWidgetProvider
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class MyWidgetProvider: AppWidgetProvider() {
    override fun onUpdate(
        context: Context, 
        appWidgetManager: AppWidgetManager, 
        appWidgetIds: IntArray
    ) {
        // Use a default text since we don't have intent parameter in onUpdate
        val widgetData = "Default text"
        
        // Iterate through all widget instances
        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_layout)
            // Update the widget with the received data
            views.setTextViewText(R.id.widgetText, widgetData)
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
    
    // Add this method to properly handle the intent
    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        
        // If it's an update action and has our data
        if (intent.action == AppWidgetManager.ACTION_APPWIDGET_UPDATE &&
            intent.hasExtra("widgetData")) {
                
            val widgetData = intent.getStringExtra("widgetData")
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val appWidgetIds = intent.getIntArrayExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS)
            
            if (appWidgetIds != null) {
                for (widgetId in appWidgetIds) {
                    val views = RemoteViews(context.packageName, R.layout.widget_layout)
                    views.setTextViewText(R.id.widgetText, widgetData ?: "No data")
                    appWidgetManager.updateAppWidget(widgetId, views)
                }
            }
        }
    }
}