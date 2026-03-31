package com.symptomtracker.symptom_tracker

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.action.ActionParameters
import androidx.glance.action.actionParametersOf
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetReceiver
import androidx.glance.appwidget.action.ActionCallback
import androidx.glance.appwidget.action.actionRunCallback
import androidx.glance.appwidget.action.actionStartActivity
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.appwidget.state.updateAppWidgetState
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.width
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

val SymptomNameKey = ActionParameters.Key<String>("symptom_name")
val SeverityKey = ActionParameters.Key<Int>("severity")
val SelectedSymptomKey = stringPreferencesKey("selected_symptom")

class SymptomWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget: GlanceAppWidget = SymptomWidget()
}

class SymptomWidget : GlanceAppWidget() {
    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)

        val symptoms = mutableListOf<String>()
        for (i in 1..5) {
            val name = prefs.getString("symptom_$i", null)
            if (!name.isNullOrEmpty()) symptoms.add(name)
        }

        val todayCount = prefs.getString("today_count", "0") ?: "0"
        val streak = prefs.getString("streak", "0") ?: "0"

        provideContent {
            val state = currentState<Preferences>()
            val selectedSymptom = state[SelectedSymptomKey]

            GlanceTheme {
                Box(
                    modifier = GlanceModifier
                        .fillMaxSize()
                        .cornerRadius(24.dp)
                        .background(GlanceTheme.colors.widgetBackground),
                ) {
                    if (selectedSymptom != null) {
                        SeverityPickerView(selectedSymptom)
                    } else {
                        SymptomListView(context, symptoms, todayCount, streak)
                    }
                }
            }
        }
    }
}

// ─── Default View: Symptom chips ───────────────────────────────

@Composable
fun SymptomListView(
    context: Context,
    symptoms: List<String>,
    todayCount: String,
    streak: String,
) {
    Column(
        modifier = GlanceModifier
            .fillMaxSize()
            .padding(20.dp),
    ) {
        // ── Header ──
        Row(
            modifier = GlanceModifier.fillMaxWidth(),
            verticalAlignment = Alignment.Vertical.CenterVertically,
        ) {
            Column(modifier = GlanceModifier.defaultWeight()) {
                Text(
                    text = "Symptom Tracker",
                    style = TextStyle(
                        fontSize = 15.sp,
                        fontWeight = FontWeight.Bold,
                        color = GlanceTheme.colors.onSurface,
                    ),
                )
                Text(
                    text = "Tap a symptom to log",
                    style = TextStyle(
                        fontSize = 11.sp,
                        color = GlanceTheme.colors.onSurfaceVariant,
                    ),
                )
            }
            // Today count badge
            if (todayCount != "0") {
                Box(
                    modifier = GlanceModifier
                        .cornerRadius(14.dp)
                        .background(GlanceTheme.colors.primary)
                        .padding(horizontal = 10.dp, vertical = 4.dp),
                    contentAlignment = Alignment.Center,
                ) {
                    Text(
                        text = todayCount,
                        style = TextStyle(
                            fontSize = 13.sp,
                            fontWeight = FontWeight.Bold,
                            color = GlanceTheme.colors.onPrimary,
                        ),
                    )
                }
            }
        }

        Spacer(modifier = GlanceModifier.height(14.dp))

        // ── Symptom chips ──
        if (symptoms.isEmpty()) {
            Box(
                modifier = GlanceModifier
                    .fillMaxWidth()
                    .cornerRadius(16.dp)
                    .background(GlanceTheme.colors.surfaceVariant)
                    .padding(16.dp),
                contentAlignment = Alignment.Center,
            ) {
                Text(
                    text = "Open app to start tracking symptoms",
                    style = TextStyle(
                        fontSize = 13.sp,
                        color = GlanceTheme.colors.onSurfaceVariant,
                    ),
                )
            }
        } else {
            Row(modifier = GlanceModifier.fillMaxWidth()) {
                symptoms.take(3).forEachIndexed { i, name ->
                    if (i > 0) Spacer(modifier = GlanceModifier.width(8.dp))
                    SymptomPill(name, modifier = GlanceModifier.defaultWeight())
                }
                // Fill remaining space if < 3 symptoms
                if (symptoms.size < 3) {
                    repeat(3 - symptoms.size) {
                        Spacer(modifier = GlanceModifier.defaultWeight())
                    }
                }
            }
            if (symptoms.size > 3) {
                Spacer(modifier = GlanceModifier.height(8.dp))
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    symptoms.drop(3).forEachIndexed { i, name ->
                        if (i > 0) Spacer(modifier = GlanceModifier.width(8.dp))
                        SymptomPill(name, modifier = GlanceModifier.defaultWeight())
                    }
                    repeat(3 - (symptoms.size - 3)) {
                        Spacer(modifier = GlanceModifier.defaultWeight())
                    }
                }
            }
        }

        Spacer(modifier = GlanceModifier.height(12.dp).defaultWeight())

        // ── Bottom row ──
        Row(
            modifier = GlanceModifier.fillMaxWidth(),
            verticalAlignment = Alignment.Vertical.CenterVertically,
        ) {
            // + New button
            Box(
                modifier = GlanceModifier
                    .cornerRadius(20.dp)
                    .background(GlanceTheme.colors.primaryContainer)
                    .padding(horizontal = 16.dp, vertical = 8.dp)
                    .clickable(
                        actionStartActivity(
                            Intent(context, MainActivity::class.java).apply {
                                action = Intent.ACTION_VIEW
                                data = Uri.parse("symptomtracker://log")
                                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                            }
                        )
                    ),
                contentAlignment = Alignment.Center,
            ) {
                Text(
                    text = "+ New symptom",
                    style = TextStyle(
                        fontSize = 12.sp,
                        fontWeight = FontWeight.Medium,
                        color = GlanceTheme.colors.onPrimaryContainer,
                    ),
                )
            }

            Spacer(modifier = GlanceModifier.defaultWeight())

            if (streak != "0") {
                Text(
                    text = "\uD83D\uDD25 $streak days",
                    style = TextStyle(
                        fontSize = 12.sp,
                        color = GlanceTheme.colors.onSurfaceVariant,
                    ),
                )
            }
        }
    }
}

@Composable
fun SymptomPill(name: String, modifier: GlanceModifier = GlanceModifier) {
    Box(
        modifier = modifier
            .cornerRadius(16.dp)
            .background(GlanceTheme.colors.secondaryContainer)
            .padding(horizontal = 12.dp, vertical = 10.dp)
            .clickable(
                actionRunCallback<SelectSymptomAction>(
                    actionParametersOf(SymptomNameKey to name)
                )
            ),
        contentAlignment = Alignment.Center,
    ) {
        Text(
            text = name,
            style = TextStyle(
                fontSize = 13.sp,
                fontWeight = FontWeight.Medium,
                color = GlanceTheme.colors.onSecondaryContainer,
                textAlign = TextAlign.Center,
            ),
            maxLines = 1,
        )
    }
}

// ─── Severity Picker View ──────────────────────────────────────

@Composable
fun SeverityPickerView(symptomName: String) {
    Column(
        modifier = GlanceModifier
            .fillMaxSize()
            .padding(20.dp),
        horizontalAlignment = Alignment.Horizontal.CenterHorizontally,
    ) {
        // Header
        Text(
            text = symptomName,
            style = TextStyle(
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                color = GlanceTheme.colors.onSurface,
            ),
        )
        Spacer(modifier = GlanceModifier.height(2.dp))
        Text(
            text = "How severe is it right now?",
            style = TextStyle(
                fontSize = 12.sp,
                color = GlanceTheme.colors.onSurfaceVariant,
            ),
        )

        Spacer(modifier = GlanceModifier.height(16.dp).defaultWeight())

        // Severity emoji buttons
        Row(
            modifier = GlanceModifier.fillMaxWidth(),
            horizontalAlignment = Alignment.Horizontal.CenterHorizontally,
        ) {
            SeverityOption(symptomName, 2, "😊", "Mild")
            Spacer(modifier = GlanceModifier.width(6.dp))
            SeverityOption(symptomName, 4, "🙂", "Low")
            Spacer(modifier = GlanceModifier.width(6.dp))
            SeverityOption(symptomName, 6, "😐", "Mid")
            Spacer(modifier = GlanceModifier.width(6.dp))
            SeverityOption(symptomName, 8, "😟", "High")
            Spacer(modifier = GlanceModifier.width(6.dp))
            SeverityOption(symptomName, 10, "😣", "Max")
        }

        Spacer(modifier = GlanceModifier.height(14.dp).defaultWeight())

        // Cancel
        Box(
            modifier = GlanceModifier
                .cornerRadius(20.dp)
                .background(GlanceTheme.colors.surfaceVariant)
                .padding(horizontal = 24.dp, vertical = 8.dp)
                .clickable(actionRunCallback<CancelAction>()),
            contentAlignment = Alignment.Center,
        ) {
            Text(
                text = "Cancel",
                style = TextStyle(
                    fontSize = 13.sp,
                    color = GlanceTheme.colors.onSurfaceVariant,
                ),
            )
        }
    }
}

@Composable
fun SeverityOption(symptomName: String, severity: Int, emoji: String, label: String) {
    Column(
        horizontalAlignment = Alignment.Horizontal.CenterHorizontally,
        modifier = GlanceModifier.clickable(
            actionRunCallback<LogSymptomAction>(
                actionParametersOf(
                    SymptomNameKey to symptomName,
                    SeverityKey to severity,
                )
            )
        ),
    ) {
        Box(
            modifier = GlanceModifier
                .width(48.dp)
                .height(48.dp)
                .cornerRadius(24.dp)
                .background(GlanceTheme.colors.secondaryContainer),
            contentAlignment = Alignment.Center,
        ) {
            Text(text = emoji, style = TextStyle(fontSize = 22.sp))
        }
        Spacer(modifier = GlanceModifier.height(4.dp))
        Text(
            text = label,
            style = TextStyle(
                fontSize = 10.sp,
                color = GlanceTheme.colors.onSurfaceVariant,
            ),
        )
    }
}

// ─── Actions ───────────────────────────────────────────────────

class SelectSymptomAction : ActionCallback {
    override suspend fun onAction(context: Context, glanceId: GlanceId, parameters: ActionParameters) {
        val symptomName = parameters[SymptomNameKey] ?: return
        updateAppWidgetState(context, glanceId) { prefs ->
            prefs[SelectedSymptomKey] = symptomName
        }
        SymptomWidget().update(context, glanceId)
    }
}

class LogSymptomAction : ActionCallback {
    override suspend fun onAction(context: Context, glanceId: GlanceId, parameters: ActionParameters) {
        val symptomName = parameters[SymptomNameKey] ?: return
        val severity = parameters[SeverityKey] ?: return

        val mentalSymptoms = setOf(
            "Anxiety", "Low mood", "Irritability", "Brain fog", "Panic",
            "Insomnia", "Restlessness", "Overwhelm", "Apathy", "Racing thoughts"
        )
        val category = if (symptomName in mentalSymptoms) "mental" else "physical"

        val prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
        val timestamp = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.US).format(Date())
        prefs.edit()
            .putString("pending_symptom", symptomName)
            .putString("pending_category", category)
            .putInt("pending_severity", severity)
            .putString("pending_timestamp", timestamp)
            .putBoolean("has_pending", true)
            .apply()

        // Increment displayed today count
        val currentCount = (prefs.getString("today_count", "0") ?: "0").toIntOrNull() ?: 0
        prefs.edit().putString("today_count", (currentCount + 1).toString()).apply()

        // Back to symptom list view
        updateAppWidgetState(context, glanceId) { state ->
            state.remove(SelectedSymptomKey)
        }
        SymptomWidget().update(context, glanceId)

        // Briefly launch Flutter to persist to database
        val intent = Intent(context, MainActivity::class.java).apply {
            action = "PROCESS_WIDGET_LOG"
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        context.startActivity(intent)
    }
}

class CancelAction : ActionCallback {
    override suspend fun onAction(context: Context, glanceId: GlanceId, parameters: ActionParameters) {
        updateAppWidgetState(context, glanceId) { prefs ->
            prefs.remove(SelectedSymptomKey)
        }
        SymptomWidget().update(context, glanceId)
    }
}
