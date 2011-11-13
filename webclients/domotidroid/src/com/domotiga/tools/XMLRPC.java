package com.domotiga.tools;

import java.net.URI;

import org.xmlrpc.android.XMLRPCClient;
import org.xmlrpc.android.XMLRPCException;

import android.app.Activity;

public abstract class XMLRPC {
	
	public static XMLRPCClient getClient(Activity activity) {
		String url = Settings.getParamString(activity, Settings.PREFS_URL, Settings.DEFAULT_URL);
		URI uri = URI.create(url);
		XMLRPCClient c=new XMLRPCClient(uri);
		try {
			c.call("system.hostname");
			return c;
		} catch (XMLRPCException e) {
			return null;
		}
	}
}
