package com.domotiga.adapter;

import java.util.ArrayList;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.domotiga.R;
import com.domotiga.data.Device;

public class DeviceAdapter extends ArrayAdapter<Device> { 
	private ArrayList<Device> items;
	private Context context;
	
    public DeviceAdapter(Context context, int textViewResourceId, ArrayList<Device> items) {
        super(context, textViewResourceId, items);
        this.items = items;
        this.context=context;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
            View v = convertView;
            if (v == null) {
                LayoutInflater vi = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                v = vi.inflate(R.layout.devices_list_listview, null);
            }
            Device d = items.get(position);
            if (d != null) {
            	TextView name = (TextView) v.findViewById(R.id.name);
                if (name != null) {
                      name.setText(d.getName());
                }
                TextView location = (TextView) v.findViewById(R.id.location);
                if (location != null) {
                      location.setText(d.getLocation());
                }
                TextView value = (TextView) v.findViewById(R.id.value);
                if (value != null) {
                	value.setText("("+d.getValue()+")");
              }
                    ImageView icon= (ImageView) v.findViewById(R.id.icon);
                    if(icon != null){
                    	String iconName=d.geticonName().replace('-', '_');
                    	Log.d("IconName: ", iconName);
                    	//iconName=iconName.substring(0, iconName.indexOf('.'));
                    	int resId=context.getResources().getIdentifier(iconName, "drawable", context.getPackageName());
                    	if (resId==0) {
                    		if (d.getValue().equalsIgnoreCase("off")) {
                    			resId=R.drawable.default_off;
                    		} else {
                    			resId=R.drawable.default_on;
                    		}
                    	}
                    	icon.setImageResource(resId);
                  }
            }
            return v;
    }
}
