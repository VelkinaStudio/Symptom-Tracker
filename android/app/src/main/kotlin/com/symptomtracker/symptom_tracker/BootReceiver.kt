package com.symptomtracker.symptom_tracker

import android.appwidget.AppWidgetManager
import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent

/**
 * Handles device reboot and app update events.
 *
 * - Notifications: The flutter_local_notifications plugin's
 *   ScheduledNotificationBootReceiver handles rescheduling automatically.
 * - Widgets: We trigger a widget refresh so data is up-to-date after reboot.
 */
class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED ||
            intent.action == Intent.ACTION_MY_PACKAGE_REPLACED
        ) {
            // Request widget update for all instances
            val widgetManager = AppWidgetManager.getInstance(context)
            val component = ComponentName(context, SymptomWidgetReceiver::class.java)
            val widgetIds = widgetManager.getAppWidgetIds(component)
            if (widgetIds.isNotEmpty()) {
                val updateIntent = Intent(context, SymptomWidgetReceiver::class.java).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, widgetIds)
                }
                context.sendBroadcast(updateIntent)
            }
        }
    }
}
