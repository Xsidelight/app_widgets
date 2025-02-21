package com.example.app_widgets

import android.appwidget.AppWidgetProvider
import android.appwidget.AppWidgetManager
import android.content.Context
import android.widget.RemoteViews

class MyWidgetProvider: AppWidgetProvider() {
    override fun onUpdate(
        context: Context, 
        appWidgetManager: AppWidgetManager, 
        appWidgetIds: IntArray
    ) {
        // Iterate through all widget instances
        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_layout)
            // Update the widget (e.g., change text dynamically)
            views.setTextViewText(R.id.widgetText, "Updated widget text")
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}