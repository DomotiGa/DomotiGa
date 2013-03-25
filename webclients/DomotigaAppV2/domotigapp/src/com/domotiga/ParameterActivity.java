package com.domotiga;

import java.util.Arrays;
import java.util.HashMap;

import org.xmlrpc.android.XMLRPCClientSSH;
import org.xmlrpc.android.XMLRPCException;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.TextView;

import com.domotiga.tools.Settings;
import com.domotiga.tools.XMLRPC;

public class ParameterActivity extends Activity {
	
	private XMLRPCClientSSH client;
	private ImageButton back, refresh;
	
	@SuppressWarnings("unchecked")
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.parameters);        
        getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE, R.layout.window_title);
		
        refresh = (ImageButton)findViewById(R.id.refresh);
        refresh.setVisibility(View.GONE);
        
		back = (ImageButton)findViewById(R.id.back);
        back.setVisibility(View.VISIBLE);
        back.setOnClickListener(new View.OnClickListener()
   		{
   			public void onClick(View v)
   			{
   				finish();
   			}
   		});
		
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
			
			    //remplissage ssh
			    CheckBox cbssh = (CheckBox) findViewById(R.id.ServerSSHUse);
			    cbssh.setChecked(Settings.getParamBoolean(this, Settings.PREFS_SSH, false));
			    TextView tvsshaddress = (TextView) findViewById(R.id.ServerSSHAddress);
			    tvsshaddress.setText(Settings.getParamString(this, Settings.PREFS_SSH_IP, "0.0.0.0"));
				TextView tvsshport = (TextView) findViewById(R.id.ServerSSHPort);
				tvsshport.setText(Settings.getParamString(this, Settings.PREFS_SSH_PORT, "22"));
				TextView tvsshuser = (TextView) findViewById(R.id.ServerSSHUser);
				tvsshuser.setText(Settings.getParamString(this, Settings.PREFS_SSH_USER, "Username"));
    			TextView tvsshpass = (TextView) findViewById(R.id.ServerSSHPass);
    			tvsshpass.setText(Settings.getParamString(this, Settings.PREFS_SSH_PASS, ""));		
			    
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
		
		CheckBox cbssh = (CheckBox) findViewById(R.id.ServerSSHUse);
		if  (cbssh.isChecked()) {
			Settings.setParamBoolean(this, Settings.PREFS_SSH, true);
		}
		else {
			Settings.setParamBoolean(this, Settings.PREFS_SSH, false);
		}
		TextView tvsshaddress = (TextView) findViewById(R.id.ServerSSHAddress);
		String sshaddress=tvsshaddress.getText().toString();	
		Settings.setParamString(this,Settings.PREFS_SSH_IP,sshaddress);
		
		TextView tvsshport = (TextView) findViewById(R.id.ServerSSHPort);
		String sshport=tvsshport.getText().toString();	
		Settings.setParamString(this,Settings.PREFS_SSH_PORT,sshport);
		
		TextView tvsshuser = (TextView) findViewById(R.id.ServerSSHUser);
		String sshuser=tvsshuser.getText().toString();	
		Settings.setParamString(this,Settings.PREFS_SSH_USER,sshuser);
		
		TextView tvsshpass = (TextView) findViewById(R.id.ServerSSHPass);
		String sshpass=tvsshpass.getText().toString();	
		Settings.setParamString(this,Settings.PREFS_SSH_PASS,sshpass);		
		client = XMLRPC.newClient(this);
		finish();
	}

	

}
