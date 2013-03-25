package com.domotiga.tools;

import com.jcraft.jsch.JSch;  
import com.jcraft.jsch.Session;  

import android.app.Activity;


public abstract class SSHTUNNEL {
	
	public static Session getClient(Activity activity) {  
        Session session= null;  
		String url = Settings.getParamString(activity, Settings.PREFS_URL, Settings.DEFAULT_URL);
		String sship = Settings.getParamString(activity, Settings.PREFS_SSH_IP, "0.0.0.0");
		int sshport = Integer.parseInt(Settings.getParamString(activity, Settings.PREFS_SSH_PORT, "22"));
		String sshuser = Settings.getParamString(activity, Settings.PREFS_SSH_USER, "user");
		String sshpass = Settings.getParamString(activity, Settings.PREFS_SSH_PASS, "pass");
		int sshtunnelport = Integer.parseInt(url.substring(url.lastIndexOf(":")+1));
		String RemoteIp = url.substring(url.lastIndexOf("/")+1,url.lastIndexOf(":"));	
		
		try{  
            //Set StrictHostKeyChecking property to no to avoid UnknownHostKey issue  
            java.util.Properties config = new java.util.Properties();  
            config.put("StrictHostKeyChecking", "no");  
            JSch jsch = new JSch();  
            session=jsch.getSession(sshuser, sship, sshport);  
            session.setPassword(sshpass);  
            session.setConfig(config);  
            session.connect();  
            System.out.println("Connected");  
            int assinged_port=session.setPortForwardingL(sshtunnelport, RemoteIp, sshtunnelport);  
            System.out.println("localhost:"+assinged_port+" -> "+RemoteIp+":"+sshtunnelport);  
            System.out.println("Port Forwarded");
            return session;
		}catch(Exception e){  
	           
	            e.printStackTrace();
	            return null;
	        }
		
	}
	
	public static void killClient(Session session) {  
		if(session !=null && session.isConnected()){  
            System.out.println("Closing SSH Connection");  
            session.disconnect(); 
		}
	}
}
