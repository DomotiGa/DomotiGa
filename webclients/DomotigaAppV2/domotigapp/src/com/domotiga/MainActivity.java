package com.domotiga;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

import org.xmlrpc.android.XMLRPCClientSSH;
import org.xmlrpc.android.XMLRPCException;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.domotiga.data.Device;
import com.domotiga.tools.Settings;
import com.domotiga.tools.XMLRPC;
import com.jcraft.jsch.Session;

public class MainActivity extends Activity {

	private Button button1, button2, button3, button4;
	private Intent myIntent = null;
	private TextView sun, moon;
	public XMLRPCClientSSH client;
	private ImageButton refresh;
	private ArrayList<Device> thermo = null;
	private TextView header;
	
	@Override        
	public void onCreate(Bundle savedInstanceState) {
                super.onCreate(savedInstanceState);
                requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
                setContentView(R.layout.mainscreen);           

                getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE, R.layout.window_title);
        		header = (TextView) findViewById(R.id.temptv);
                refresh = (ImageButton)findViewById(R.id.refresh);
                refresh.setOnClickListener(new View.OnClickListener()
           		{
           			public void onClick(View v)
           			{
           				myIntent = new Intent(MainActivity.this, MainActivity.class);
        				startActivity(myIntent);
           			}
           		});
                
                SharedPreferences settings = this.getSharedPreferences("DomotigaPrefsFile", 0);
                //settings.getString("DomotigaUrl", "host");
                if(settings.getString("DomotigaUrl", null) == null)
                {
                	myIntent = new Intent(MainActivity.this, ParameterActivity.class);
        			startActivity(myIntent);
                }
                client = XMLRPC.getClient(this);
                
                if (client != null) 
                {
	                HashMap<String, String> switchableDevicesObject = null;
	                try {
	    				HashMap<String, String> tempDevicesObject = (HashMap<String, String>) client
	    						.call("device.list");

	    				thermo = new ArrayList<Device>();
	    				Iterator<String> iThermo = tempDevicesObject.values()
	    						.iterator();
	    				//String intTemp = Settings.getParamString(this,Settings.PREFS_INT_TEMP, "");
	    				//String outTemp = Settings.getParamString(this,Settings.PREFS_OUT_TEMP, "");
	    				String intTemp = settings.getString("DomotigaIntTemp", null);
	                    String outTemp = settings.getString("DomotigaOutTemp", null);
	                    //System.out.println("in temp name"+intTemp);
	                    //System.out.println("out temp name"+outTemp);
	                    String intValue = "", outValue = "";
	                    while (iThermo.hasNext()) {
	    					String[] values = iThermo.next().split(";");
	    					if (intTemp.equals(values[4])) {
	    						intValue= values[8] + " " + values[10];  						
	    					} else if (outTemp.equals(values[4])) {
	    						outValue= values[8] + " " + values[10];
	    					}
	    					
	    				}
	    				
	    				//display temp
	    				String result = getResources().getString(R.string.temp_label);
	    				result = String.format(result, intValue, outValue);
	    				header.setText(result);
	                } catch (XMLRPCException e) {
	    				e.printStackTrace();
	    			}
	                /*
	                try {
						switchableDevicesObject = (HashMap<String, String>) client.call("data.sunmoon");
					} catch (XMLRPCException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
	                sun = (TextView)findViewById(R.id.sun);
	                moon = (TextView)findViewById(R.id.moon);
	                
	                
	                Iterator it = switchableDevicesObject.entrySet().iterator();
	                
	                while (it.hasNext()) {
	                    Map.Entry pairs = (Map.Entry)it.next();
	                    Log.d("log ",pairs.getKey() + " = " + pairs.getValue());
	                    it.remove(); // avoids a ConcurrentModificationException
	                }
	                */
                }
                
                
                client = XMLRPC.getClient(this);
                if (client != null) 
                {
	                HashMap<String, String> switchableDevicesObject = null;
					try {
						switchableDevicesObject = (HashMap<String, String>) client.call("device.list");						
					} catch (XMLRPCException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	                
	                Iterator<String> iDevices = switchableDevicesObject.values()
					.iterator();
	                ArrayList x = new ArrayList();
	                while (iDevices.hasNext()) {
						String[] values = iDevices.next().split(";");
						x.add(values[6]);
	                }
	                int i = 0;
	                LinearLayout ll;
	                for (final Object y : GetUniqueValues(x))
	                {
	                	Log.d("Groep: ", ""+y+" "+i);
	                	Button button1 = new Button(this);
	                    button1.setText(""+y);
	                    if(i == 0)
	                    {
	                    	ll = (LinearLayout)findViewById(R.id.mainscreen1);
	                    }
	                    else
	                    {
	                    	ll = (LinearLayout)findViewById(R.id.mainscreen2);
	                    }
	                    LayoutParams lp = new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
	                    ll.addView(button1, lp);
	                    
	                    button1.setOnClickListener(new View.OnClickListener()
	               		{
	               			public void onClick(View v)
	               			{
	               				myIntent = new Intent(MainActivity.this, DeviceListActivity.class);
	               				myIntent.putExtra("location",""+y);
	            				startActivity(myIntent);
	               			}
	               		});
	                    if(i == 0)
	                    {
	                    	i++;
	                    }
	                    else
	                    {
	                    	i = 0;
	                    }
	                }
                }
                LinearLayout tempLayout = (LinearLayout) findViewById(R.id.templayout);
    			tempLayout.setOnClickListener(new OnClickListener() {
    				public void onClick(View v) {
    					Intent intentImage= new Intent(getApplicationContext(),
    							ImageActivity.class);
    					startActivityForResult(intentImage, 0);
    				}
    			});
                
	}
	
	public static ArrayList GetUniqueValues(Collection values)
	{
	    return new ArrayList(new HashSet(values));
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.menu, menu);
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle item selection
		switch (item.getItemId()) {
		case R.id.about_menu:
			Intent intentAbout = new Intent(getApplicationContext(),
					AboutActivity.class);
			startActivityForResult(intentAbout, 0);
			return true;
		case R.id.parameter_menu:
			Intent intentParameter = new Intent(getApplicationContext(),
					ParameterActivity.class);
			startActivityForResult(intentParameter, 0);
			return true;
		case R.id.refresh_menu:
			finish();
			myIntent = new Intent(MainActivity.this, MainActivity.class);
			startActivity(myIntent);

			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
	}
	
}
