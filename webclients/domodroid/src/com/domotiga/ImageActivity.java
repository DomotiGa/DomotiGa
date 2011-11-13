package com.domotiga;

import org.xmlrpc.android.XMLRPCClient;
import org.xmlrpc.android.XMLRPCException;

import android.app.Activity;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.widget.ImageView;

import com.domotiga.tools.WebImage;
import com.domotiga.tools.XMLRPC;

public class ImageActivity extends Activity {
	
	ImageView theImage;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.image);		
		theImage = (ImageView) findViewById(R.id.ImageView01);
		
		XMLRPCClient client = XMLRPC.getClient(this);
		try {
			//we update the image on the server
			client.call("rrdtool.updategraphs","Climate", "1d");
			//we retrieve the image
			Bitmap bm=WebImage.LoadImage("http://some_ip/domotiga/graphs/comparaisoninout-1d.png");
			theImage.setImageBitmap(bm);
			} catch (XMLRPCException e) {			
			e.printStackTrace();
		}
	}
	
	@Override
	protected void onStop() {
		super.onStop();
		finish();
	}
}
