package com.domotiga.tools;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;

public abstract class Settings {

	public static final String PREFS = "DomotigaPrefsFile";
	public static final String PREFS_URL = "DomotigaUrl";
	public static final String PREFS_OUT_TEMP = "DomotigaOutTemp";
	public static final String PREFS_INT_TEMP = "DomotigaIntTemp";
	public static final String DEFAULT_URL = "http://192.168.2.5:9009";
	public static final String PREFS_SSH = "DomotigaSSH";
	public static final String PREFS_SSH_IP = "DomotigaSSHIp";
	public static final String PREFS_SSH_PORT = "DomotigaSSHPort";
	public static final String PREFS_SSH_USER = "DomotigaSSHUser";
	public static final String PREFS_SSH_PASS = "DomotigaSSHPassword";

	public static String getParamString(Activity activity, String param, String defaultValue) {
		SharedPreferences settings = activity.getSharedPreferences(PREFS, 0);
	    return settings.getString(param, defaultValue);
	}
	
	public static String getParamString(Context context, String param, String defaultValue) {
		SharedPreferences settings = context.getSharedPreferences(PREFS, 0);
	    return settings.getString(param, defaultValue);
	}

	public static Boolean getParamBoolean(Activity activity, String param, Boolean defaultValue) {
		SharedPreferences settings = activity.getSharedPreferences(PREFS, 0);
	    return settings.getBoolean(param, defaultValue);
	}
	
	public static Boolean getParamBoolean(Context context, String param, Boolean defaultValue) {
		SharedPreferences settings = context.getSharedPreferences(PREFS, 0);
	    return settings.getBoolean(param, defaultValue);
	}

	public static void setParamString(Activity activity, String param, String newValue) {
		SharedPreferences settings =  activity.getSharedPreferences(PREFS, 0);
		// We need an Editor object to make preference changes.
	    // All objects are from android.context.Context
	    SharedPreferences.Editor editor = settings.edit();
	    editor.putString(param, newValue);
	    // Commit the edits!
	    editor.commit();
	}

	public static void setParamBoolean(Activity activity, String param, Boolean newValue) {
		SharedPreferences settings =  activity.getSharedPreferences(PREFS, 0);
		// We need an Editor object to make preference changes.
	    // All objects are from android.context.Context
	    SharedPreferences.Editor editor = settings.edit();
	    editor.putBoolean(param, newValue);
	    // Commit the edits!
	    editor.commit();
	}
}
