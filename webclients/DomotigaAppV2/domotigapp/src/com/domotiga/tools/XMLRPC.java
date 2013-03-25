package com.domotiga.tools;

import java.net.URI;

import org.xmlrpc.android.XMLRPCClientSSH;
import org.xmlrpc.android.XMLRPCException;

import android.app.Activity;
import com.domotiga.tools.SSHTUNNEL;
import com.jcraft.jsch.Session;  

public abstract class XMLRPC {
	private static XMLRPCClientSSH c=null;
	
	public static XMLRPCClientSSH newClient(Activity activity){
		c.CloseSSH();
		c=null;
		return getClient(activity);
	}
	
	public static XMLRPCClientSSH getClient(Activity activity) {
		String url = Settings.getParamString(activity, Settings.PREFS_URL, Settings.DEFAULT_URL);
		Boolean UseSSH = Settings.getParamBoolean(activity, Settings.PREFS_SSH, false);
		String SSHIp = Settings.getParamString(activity, Settings.PREFS_SSH_IP, "0.0.0.0");
		int SSHPort = Integer.parseInt(Settings.getParamString(activity, Settings.PREFS_SSH_PORT, "22"));
		String SSHUser = Settings.getParamString(activity, Settings.PREFS_SSH_USER, "user");
		String SSHPass = Settings.getParamString(activity, Settings.PREFS_SSH_PASS, "pass");
		int SSHTunnelPort = Integer.parseInt(url.substring(url.lastIndexOf(":")+1));
		String SSHRemoteIp = url.substring(url.lastIndexOf("/")+1,url.lastIndexOf(":"));	
		
		URI uri ;
		 if( c == null ) {
			 if (UseSSH){
			
				 uri = URI.create("http://127.0.0.1:"+SSHTunnelPort);
				 c=new XMLRPCClientSSH(uri, UseSSH, SSHIp, SSHPort, SSHUser, SSHPass, SSHTunnelPort, SSHRemoteIp);
			 } else {
				 uri = URI.create(url);
				 c=new XMLRPCClientSSH(uri);
			 }
			 //System.out.println("Create new instance XMLRPCSSH");
			 //System.out.println("With Param : "+uri+","+UseSSH+","+SSHIp+","+SSHPort+","+SSHUser+","+SSHTunnelPort+","+SSHRemoteIp);
		 }	else {
			 //System.out.println("Reuse instance XMLRPCSSH");
		 }
			try {
				
					c.call("system.hostname");
				
				return c;
			} catch (XMLRPCException e) {
				return null;
			}
		
	}
}
