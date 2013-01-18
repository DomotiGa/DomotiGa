package com.domotiga;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;

import org.xmlrpc.android.XMLRPCClient;
import org.xmlrpc.android.XMLRPCException;

import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.domotiga.adapter.DeviceAdapter;
import com.domotiga.data.Device;
import com.domotiga.tools.Settings;
import com.domotiga.tools.XMLRPC;

public class DeviceListActivity extends ListActivity {

	private XMLRPCClient client;
	private ArrayList<Device> devices = null;
	private ArrayList<Device> thermo = null;
	private DeviceAdapter adapter;
	private TextView header;
	private Runnable viewDevices;
	private ProgressDialog progressDialog;
	private String location;
	Thread thread = null;
	private ImageButton refresh, back;
	private Runnable returnRes = new Runnable() {

		public void run() {
			if (devices != null && devices.size() > 0) {
				adapter.notifyDataSetChanged();
				adapter.clear();
				for (int i = 0; i < devices.size(); i++)
					adapter.add(devices.get(i));
			}
			progressDialog.dismiss();
			adapter.notifyDataSetChanged();

			if (thermo != null && thermo.size() > 0) {
				String intThermo = Settings.getParamString(
						adapter.getContext(), Settings.PREFS_INT_TEMP, "");
				String outThermo = Settings.getParamString(
						adapter.getContext(), Settings.PREFS_OUT_TEMP, "");
				String intValue = "", outValue = "";
				for (int i = 0; i < thermo.size(); i++) {
					if (intThermo.equalsIgnoreCase(thermo.get(i).getName())) {
						intValue = thermo.get(i).getValue();
					}
					if (outThermo.equalsIgnoreCase(thermo.get(i).getName())) {
						outValue = thermo.get(i).getValue();
					}
				}
				String result = getResources().getString(R.string.temp_label);
				result = String.format(result, intValue, outValue);
				header.setText(result);
			}

		}
	};

	private void loadScreen() {
		if (client != null) {
			try {
				HashMap<String, String> tempDevicesObject = (HashMap<String, String>) client
						.call("device.list");

				thermo = new ArrayList<Device>();
				Iterator<String> iThermo = tempDevicesObject.values()
						.iterator();
				String intTemp = Settings.getParamString(this,
						Settings.PREFS_INT_TEMP, "");
				String outTemp = Settings.getParamString(this,
						Settings.PREFS_OUT_TEMP, "");
				while (iThermo.hasNext()) {
					String[] values = iThermo.next().split(";");
					if (intTemp.equals(values[4]) || outTemp.equals(values[4])) {
						Device item = new Device();
						item.setName(values[4]);
						item.setValue(values[8] + " " + values[10]);
						item.setId(Integer.parseInt(values[0]));
						item.setIconName(values[2]);
						thermo.add(item);
					}
				}

				HashMap<String, String> switchableDevicesObject = (HashMap<String, String>) client
						.call("device.list");

				devices = new ArrayList<Device>();

				Iterator<String> iDevices = switchableDevicesObject.values()
						.iterator();
				while (iDevices.hasNext()) {
					
					String[] values = iDevices.next().split(";");
					if(values[6].contains(location))
					{
						Device item = new Device();
						item.setName(values[4]);
						item.setValue(values[8]);
						item.setLocation(values[6]);
						item.setId(Integer.parseInt(values[0]));
						item.setIconName(values[2]);
						devices.add(item);
					}
				}

				runOnUiThread(returnRes);

			} catch (XMLRPCException e) {
				e.printStackTrace();
			}
		}
		//thread.stop();
	}

	protected void onResume() {
		super.onResume();
		client = XMLRPC.getClient(this);
		viewDevices = new Runnable() {
			public void run() {
				loadScreen();
			}
		};
		thread = new Thread(null, viewDevices, "MagentoBackground");
		thread.start();
	}
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.devices_list);        
        getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE, R.layout.window_title);
        
        client = XMLRPC.getClient(this);
        
        back = (ImageButton)findViewById(R.id.back);
        back.setVisibility(View.VISIBLE);
        back.setOnClickListener(new View.OnClickListener()
   		{
   			public void onClick(View v)
   			{
   				finish();
   			}
   		});
        refresh = (ImageButton)findViewById(R.id.refresh);
        refresh.setOnClickListener(new View.OnClickListener()
   		{
   			public void onClick(View v)
   			{
   				viewDevices = new Runnable() {
   					public void run() {
   						loadScreen();
   					}
   				};
   				Thread thread = new Thread(null, viewDevices, "MagentoBackground");
   				thread.start();
   			}
   		});
		
		
		Intent myIntent= getIntent(); // gets the previously created intent
		location = myIntent.getStringExtra("location"); 
		
		client = XMLRPC.getClient(this);
		setContentView(R.layout.devices_list);
		devices = new ArrayList<Device>();
		header = (TextView) findViewById(R.id.temptv);
		adapter = new DeviceAdapter(this, R.layout.devices_list_listview,
				devices);
		setListAdapter(adapter);

		if (client != null) {
			viewDevices = new Runnable() {
				public void run() {
					loadScreen();
				}
			};
			Thread thread = new Thread(null, viewDevices, "MagentoBackground");
			thread.start();
			progressDialog = ProgressDialog.show(this, getResources()
					.getString(R.string.popup_please_wait), getResources()
					.getString(R.string.popup_retrieving_data), true);

			ListView lv = getListView();
			// lv.setTextFilterEnabled(true);

			lv.setOnItemClickListener(new OnItemClickListener() {
				public void onItemClick(AdapterView<?> parent, View view,
						int position, long id) {

					// get the device and the new order
					String label = ((TextView) ((LinearLayout) view)
							.findViewById(R.id.name)).getText().toString();
					String order = ((TextView) ((LinearLayout) view)
							.findViewById(R.id.value)).getText().toString();

					order = (order.equalsIgnoreCase("(Off)")) ? "On" : "Off";
					if (client != null) {
						try {
							client.call("device.setdevice", label, order);
							viewDevices = new Runnable() {
								public void run() {
									loadScreen();
								}

							};
						} catch (XMLRPCException e) {
							e.printStackTrace();
							Toast.makeText(
									getApplicationContext(),
									getResources().getString(
											R.string.popup_unable_to_update),
									Toast.LENGTH_SHORT).show();
						}

					}
					Thread thread = new Thread(null, viewDevices,
							"MagentoBackground");
					thread.start();

					progressDialog = ProgressDialog.show(
							view.getContext(),
							getResources()
									.getString(R.string.popup_please_wait),
							getResources().getString(
									R.string.popup_updating_data), true);

				}
			});

			LinearLayout tempLayout = (LinearLayout) findViewById(R.id.templayout);
			tempLayout.setOnClickListener(new OnClickListener() {
				public void onClick(View v) {
					Intent intentImage= new Intent(getApplicationContext(),
							ImageActivity.class);
					startActivityForResult(intentImage, 0);
				}
			});
		}
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
			client = XMLRPC.getClient(this);
			viewDevices = new Runnable() {
				public void run() {
					loadScreen();
				}
			};
			Thread thread = new Thread(null, viewDevices, "MagentoBackground");
			thread.start();
			progressDialog = ProgressDialog.show(this, getResources()
					.getString(R.string.popup_please_wait), getResources()
					.getString(R.string.popup_retrieving_data), true);

			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
	}

	@Override
	protected void onStop() {
		super.onStop();
	}

}