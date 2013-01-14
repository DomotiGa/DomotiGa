package com.domotiga;

import java.util.Arrays;
import java.util.HashMap;

import org.xmlrpc.android.XMLRPCClient;
import org.xmlrpc.android.XMLRPCException;

import com.domotiga.R;
import com.domotiga.tools.Settings;
import com.domotiga.tools.XMLRPC;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

public class ParameterActivity extends Activity {
	
	private XMLRPCClient client;
	
	@SuppressWarnings("unchecked")
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		
		setContentView(R.layout.parameters);

			// on remplie le chp serverURL
			TextView tv = (TextView) findViewById(R.id.ServerURL);
			tv.setText(Settings.getParamString(this, Settings.PREFS_URL, Settings.DEFAULT_URL));
			
			//on récupère le liste des devices
			String[] devices;
			client = XMLRPC.getClient(this);
			if (client!=null) {
			HashMap<String, String> devicesObject;
			try {
				devicesObject = (HashMap<String, String>) client
				.call("device.list");
				devices=devicesObject.keySet().toArray(new String[devicesObject.size()]);

				Arrays.sort(devices);
			} catch (XMLRPCException e) {
				e.printStackTrace();
				devices= new String[1];
				devices[0]=getResources().getString(R.string.error_server_unavailable);			
			}
			
			} else {
				devices= new String[1];
				devices[0]=getResources().getString(R.string.error_server_unavailable);
			}
			
			//on l'affiche dans les 2 spinners
		    ArrayAdapter<String> spinnerArrayAdapter = new ArrayAdapter<String>(
		            this, android.R.layout.simple_spinner_item, devices);
		    spinnerArrayAdapter.setDropDownViewResource( android.R.layout.simple_spinner_dropdown_item );

		    Spinner spinner1 = new Spinner(this);
		    spinner1 = (Spinner) findViewById( R.id.SpinnerIntTemp );
		    spinner1.setAdapter(spinnerArrayAdapter);
		    int position;		    
		    //if (client!=null) {
		    	//on recherche l'entrée paramétrée		    
			    String intTemp=Settings.getParamString(this, Settings.PREFS_INT_TEMP, "");
			    position=0;
			    for (int i=0;i<devices.length;i++) {
			    	if (devices[i].equals(intTemp)) {
			    		position=i;
			    		break;
			    	}
			    }
			    spinner1.setSelection(position);
		   // }
		    
		    Spinner spinner2 = new Spinner(this);
		    spinner2 = (Spinner) findViewById( R.id.SpinnerOutTemp );
		    spinner2.setAdapter(spinnerArrayAdapter);
		   // if (client!=null) {
		    	String outTemp=Settings.getParamString(this, Settings.PREFS_OUT_TEMP, "");		    
			    position=0;
			    for (int i=0;i<devices.length;i++) {
			    	if (devices[i].equals(outTemp)) {
			    		position=i;
			    		break;
			    	}
			    }
			    spinner2.setSelection(position);
		  //  }
	}
	
	@Override
	protected void onStop() {
		super.onStop();

		TextView tv = (TextView) findViewById(R.id.ServerURL);
		String url=tv.getText().toString();		
		Settings.setParamString(this,Settings.PREFS_URL,url);
		
		if (client!=null) {
			Spinner spinner = (Spinner) findViewById( R.id.SpinnerIntTemp );
			Settings.setParamString(this,Settings.PREFS_INT_TEMP,(String)spinner.getSelectedItem());
			
			spinner = (Spinner) findViewById( R.id.SpinnerOutTemp );
			Settings.setParamString(this,Settings.PREFS_OUT_TEMP,(String)spinner.getSelectedItem());
		}
		finish();
	}

	

}
