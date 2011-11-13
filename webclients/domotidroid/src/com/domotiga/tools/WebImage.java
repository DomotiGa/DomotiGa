package com.domotiga.tools;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

public abstract class WebImage {
	
	public static Bitmap LoadImage(String URL)
    {       
     Bitmap bitmap = null;
     InputStream in = null;       
        try {
            in = OpenHttpConnection(URL);
// Est-il nécessaire d'utiliser l'option ?            
//            BitmapFactory.Options options;
//            options = new BitmapFactory.Options();
//            options.inSampleSize = 1;   
//            bitmap = BitmapFactory.decodeStream(in, null, options);
            bitmap = BitmapFactory.decodeStream(in);
            in.close();
        } catch (IOException e1) {
        }
        return bitmap;               
    }

    private static InputStream OpenHttpConnection(String strURL) throws IOException{
     InputStream inputStream = null;
     URL url = new URL(strURL);
     URLConnection conn = url.openConnection();

     try{
      HttpURLConnection httpConn = (HttpURLConnection)conn;
      httpConn.setRequestMethod("GET");
      httpConn.connect();

      if (httpConn.getResponseCode() == HttpURLConnection.HTTP_OK) {
       inputStream = httpConn.getInputStream();
      }
     }
     catch (Exception ex)
     {
     }
     return inputStream;
    }

}
