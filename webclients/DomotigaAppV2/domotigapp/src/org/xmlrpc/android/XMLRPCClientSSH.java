package org.xmlrpc.android;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.net.URI;
import java.net.URL;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import com.jcraft.jsch.JSch;  
import com.jcraft.jsch.Session;  

/**
 * XMLRPCClient allows to call remote XMLRPC method.
 * 
 * <p>
 * The following table shows how XML-RPC types are mapped to java call parameters/response values.
 * </p>
 * 
 * <p>
 * <table border="2" align="center" cellpadding="5">
 * <thead><tr><th>XML-RPC Type</th><th>Call Parameters</th><th>Call Response</th></tr></thead>
 * 
 * <tbody>
 * <td>int, i4</td><td>byte<br />Byte<br />short<br />Short<br />int<br />Integer</td><td>int<br />Integer</td>
 * </tr>
 * <tr>
 * <td>i8</td><td>long<br />Long</td><td>long<br />Long</td>
 * </tr>
 * <tr>
 * <td>double</td><td>float<br />Float<br />double<br />Double</td><td>double<br />Double</td>
 * </tr>
 * <tr>
 * <td>string</td><td>String</td><td>String</td>
 * </tr>
 * <tr>
 * <td>boolean</td><td>boolean<br />Boolean</td><td>boolean<br />Boolean</td>
 * </tr>
 * <tr>
 * <td>dateTime.iso8601</td><td>java.util.Date<br />java.util.Calendar</td><td>java.util.Date</td>
 * </tr>
 * <tr>
 * <td>base64</td><td>byte[]</td><td>byte[]</td>
 * </tr>
 * <tr>
 * <td>array</td><td>java.util.List&lt;Object&gt;<br />Object[]</td><td>Object[]</td>
 * </tr>
 * <tr>
 * <td>struct</td><td>java.util.Map&lt;String, Object&gt;</td><td>java.util.Map&lt;String, Object&gt;</td>
 * </tr>
 * </tbody>
 * </table>
 * </p>
 * <p>
 * You can also pass as a parameter any object implementing XMLRPCSerializable interface. In this
 * case your object overrides getSerializable() telling how to serialize to XMLRPC protocol
 * </p>
 */

public class XMLRPCClientSSH extends XMLRPCCommon {
	private URI uri;
	private boolean UseSSH;
	private String SSHIp;
	private int SSHPort;
	private String SSHUser;
	private String SSHPass;
	private int SSHTunnelPort;
	private String SSHRemoteIp;
	private HttpClient client;
	private HttpPost postMethod;
	private HttpParams httpParams;
	private  Session session= null; 
//	private JSch jsch ;

	/**
	 * XMLRPCClient constructor. Creates new instance based on server URI
	 * @param XMLRPC server URI
	 */
	public XMLRPCClientSSH(URI uri,boolean UseSSH,String SSHIp,int SSHPort,String SSHUser,String SSHPass,
			int SSHTunnelPort,String SSHRemoteIp) {
		this.uri=uri;
		this.UseSSH=UseSSH;
		this.SSHIp=SSHIp;
		this.SSHPort=SSHPort;
		this.SSHUser=SSHUser;
		this.SSHPass=SSHPass;
		this.SSHTunnelPort=SSHTunnelPort;
		this.SSHRemoteIp = SSHRemoteIp;
	
		postMethod = new HttpPost(uri);
		postMethod.addHeader("Content-Type", "text/xml");
		
		// WARNING
		// I had to disable "Expect: 100-Continue" header since I had 
		// two second delay between sending http POST request and POST body 
		httpParams = postMethod.getParams();
		HttpProtocolParams.setUseExpectContinue(httpParams, false);
		client = new DefaultHttpClient();
		HttpParams params = client.getParams();
		HttpConnectionParams.setConnectionTimeout(params, 3000);
		HttpConnectionParams.setSoTimeout(params, 3000);
	}

	/**
	 * XMLRPCClient constructor. Creates new instance based on server URI
	 * @param XMLRPC server URI
	 */
	public XMLRPCClientSSH(URI uri) {
		this(uri,false,"",0,"","",0,"");
	}
	
	/**
	 * Convenience constructor. Creates new instance based on server String address
	 * @param XMLRPC server address
	 */
	public XMLRPCClientSSH(String url) {
		this(URI.create(url),false,"",0,"","",0,"");
	}

	/**
	 * Convenience XMLRPCClient constructor. Creates new instance based on server URL
	 * @param XMLRPC server URL
	 */
	public XMLRPCClientSSH(URL url) {
		this(URI.create(url.toExternalForm()),false,"",0,"","",0,"");
	}

	/**
	 * Convenience constructor. Creates new instance based on server String address
	 * @param XMLRPC server address
	 * @param HTTP Server - Basic Authentication - Username
	 * @param HTTP Server - Basic Authentication - Password
	 */	
	public XMLRPCClientSSH(URI uri, String username, String password) {
        this(uri,false,"",0,"","",0,"");
        
        ((DefaultHttpClient) client).getCredentialsProvider().setCredentials(
        new AuthScope(uri.getHost(), uri.getPort(),AuthScope.ANY_REALM),
        new UsernamePasswordCredentials(username, password));
    }

	/**
	 * Convenience constructor. Creates new instance based on server String address
	 * @param XMLRPC server address
	 * @param HTTP Server - Basic Authentication - Username
	 * @param HTTP Server - Basic Authentication - Password
	 */
	public XMLRPCClientSSH(String url, String username, String password) {
		this(URI.create(url), username, password);
	}

	/**
	 * Convenience constructor. Creates new instance based on server String address
	 * @param XMLRPC server url
	 * @param HTTP Server - Basic Authentication - Username
	 * @param HTTP Server - Basic Authentication - Password
	 */
	public XMLRPCClientSSH(URL url, String username, String password) {
		this(URI.create(url.toExternalForm()), username, password);
	}

	/**
	 * Sets basic authentication on web request using plain credentials
	 * @param username The plain text username
	 * @param password The plain text password
	 */
	public void setBasicAuthentication(String username, String password) {
		((DefaultHttpClient) client).getCredentialsProvider().setCredentials(
		        new AuthScope(postMethod.getURI().getHost(), postMethod.getURI().getPort(),
AuthScope.ANY_REALM),
		        new UsernamePasswordCredentials(username, password));
	}
//SSH Version 
	
	/**
	 * Convenience constructor. Creates new instance based on server String address
	 * @param XMLRPC server address
	 */
	public XMLRPCClientSSH(String url,boolean UseSSH,String SSHIp,int SSHPort,String SSHUser,String SSHPass,
			int SSHTunnelPort,String SSHRemoteIp) {
		this(URI.create(url),UseSSH, SSHIp, SSHPort, SSHUser, SSHPass,SSHTunnelPort,SSHRemoteIp);
	}

	/**
	 * Convenience XMLRPCClient constructor. Creates new instance based on server URL
	 * @param XMLRPC server URL
	 */
	public XMLRPCClientSSH(URL url,boolean UseSSH,String SSHIp,int SSHPort,String SSHUser,String SSHPass,
			int SSHTunnelPort,String SSHRemoteIp) {
		this(URI.create(url.toExternalForm()),UseSSH, SSHIp, SSHPort, SSHUser, SSHPass,SSHTunnelPort,SSHRemoteIp);
	}

	/**
	 * Convenience constructor. Creates new instance based on server String address
	 * @param XMLRPC server address
	 * @param HTTP Server - Basic Authentication - Username
	 * @param HTTP Server - Basic Authentication - Password
	 */	
	public XMLRPCClientSSH(URI uri, String username, String password,boolean UseSSH,String SSHIp,int SSHPort,String SSHUser,String SSHPass,
			int SSHTunnelPort,String SSHRemoteIp) {
        this(uri,UseSSH, SSHIp, SSHPort, SSHUser, SSHPass,SSHTunnelPort,SSHRemoteIp);
        
        ((DefaultHttpClient) client).getCredentialsProvider().setCredentials(
        new AuthScope(uri.getHost(), uri.getPort(),AuthScope.ANY_REALM),
        new UsernamePasswordCredentials(username, password));
    }

	/**
	 * Convenience constructor. Creates new instance based on server String address
	 * @param XMLRPC server address
	 * @param HTTP Server - Basic Authentication - Username
	 * @param HTTP Server - Basic Authentication - Password
	 */
	public XMLRPCClientSSH(String url, String username, String password,boolean UseSSH,String SSHIp,int SSHPort,String SSHUser,String SSHPass,
			int SSHTunnelPort,String SSHRemoteIp) {
		this(URI.create(url), username, password,UseSSH, SSHIp, SSHPort, SSHUser, SSHPass,SSHTunnelPort,SSHRemoteIp);
	}

	/**
	 * Convenience constructor. Creates new instance based on server String address
	 * @param XMLRPC server url
	 * @param HTTP Server - Basic Authentication - Username
	 * @param HTTP Server - Basic Authentication - Password
	 */
	public XMLRPCClientSSH(URL url, String username, String password, boolean UseSSH,String SSHIp,int SSHPort,String SSHUser,String SSHPass,
			int SSHTunnelPort,String SSHRemoteIp) {
		this(URI.create(url.toExternalForm()), username, password,UseSSH, SSHIp, SSHPort, SSHUser, SSHPass,SSHTunnelPort,SSHRemoteIp);
	}


	/**
	 * Call method with optional parameters. This is general method.
	 * If you want to call your method with 0-8 parameters, you can use more
	 * convenience call() methods
	 * 
	 * @param method name of method to call
	 * @param params parameters to pass to method (may be null if method has no parameters)
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	@SuppressWarnings("unchecked")
	public Object callEx(String method, Object[] params) throws XMLRPCException {
		try {
			// prepare POST body
			String body = methodCall(method, params);

			// set POST body
			HttpEntity entity = new StringEntity(body);
			postMethod.setEntity(entity);
			//Add SSH Connect
			
            if (UseSSH) {
            	//test si une session existe et est conneter sinon on cree
            	if(session !=null && session.isConnected()){  
    	            //System.out.println("ReUse actual SSH Connection");
            	} else{
            		//Set StrictHostKeyChecking property to no to avoid UnknownHostKey issue  
            		java.util.Properties config = new java.util.Properties();  
            		config.put("StrictHostKeyChecking", "no");  
            		JSch jsch = new JSch();  
            		session=jsch.getSession(this.SSHUser,this.SSHIp , this.SSHPort);  
            		session.setPassword(this.SSHPass);  
            		session.setConfig(config);
            		session.connect(); 
            		//session.setTimeout();
            		//System.out.println("Connected");  
            		int assinged_port=session.setPortForwardingL(SSHTunnelPort, SSHRemoteIp, SSHTunnelPort);  
            		//System.out.println("localhost:"+assinged_port+" -> "+SSHRemoteIp+":"+SSHTunnelPort);  
            		//System.out.println("Port Forwarded");
            	}
            }
			//Log.d(Tag.LOG, "ros HTTP POST");
			// execute HTTP POST request
			HttpResponse response = client.execute(postMethod);
			//Log.d(Tag.LOG, "ros HTTP POSTed");
			
			// check status code
			int statusCode = response.getStatusLine().getStatusCode();
			//Log.d(Tag.LOG, "ros status code:" + statusCode);
			if (statusCode != HttpStatus.SC_OK) {
				throw new XMLRPCException("HTTP status code: " + statusCode + " != " + HttpStatus.SC_OK);
			}
			
			// parse response stuff
			//
			// setup pull parser
			XmlPullParser pullParser = XmlPullParserFactory.newInstance().newPullParser();
			entity = response.getEntity();
			Reader reader = new InputStreamReader(new BufferedInputStream(entity.getContent()));
// for testing purposes only
// reader = new StringReader("<?xml version='1.0'?><methodResponse><params><param><value>\n\n\n</value></param></params></methodResponse>");
			pullParser.setInput(reader);
			
			// lets start pulling...
			pullParser.nextTag();
			pullParser.require(XmlPullParser.START_TAG, null, Tag.METHOD_RESPONSE);
			
			pullParser.nextTag(); // either Tag.PARAMS (<params>) or Tag.FAULT (<fault>)  
			String tag = pullParser.getName();
			if (tag.equals(Tag.PARAMS)) {
				// normal response
				pullParser.nextTag(); // Tag.PARAM (<param>)
				pullParser.require(XmlPullParser.START_TAG, null, Tag.PARAM);
				pullParser.nextTag(); // Tag.VALUE (<value>)
				// no parser.require() here since its called in XMLRPCSerializer.deserialize() below
				
				// deserialize result
				Object obj = iXMLRPCSerializer.deserialize(pullParser);
				entity.consumeContent();
				return obj;
			} else
			if (tag.equals(Tag.FAULT)) {
				// fault response
				pullParser.nextTag(); // Tag.VALUE (<value>)
				// no parser.require() here since its called in XMLRPCSerializer.deserialize() below

				// deserialize fault result
				Map<String, Object> map = (Map<String, Object>) iXMLRPCSerializer.deserialize(pullParser);
				String faultString = (String) map.get(Tag.FAULT_STRING);
				int faultCode = (Integer) map.get(Tag.FAULT_CODE);
				entity.consumeContent();
				throw new XMLRPCFault(faultString, faultCode);
			} else {
				entity.consumeContent();
				throw new XMLRPCException("Bad tag <" + tag + "> in XMLRPC response - neither <params> nor <fault>");
			}
		} catch (XMLRPCException e) {
			// catch & propagate XMLRPCException/XMLRPCFault
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			// wrap any other Exception(s) around XMLRPCException
			throw new XMLRPCException(e);
		}finally {
			if(session !=null && session.isConnected()){  
	            //System.out.println("Closing SSH Connection");  
	            //session.disconnect(); 
			}
		}
	}
	
	public void CloseSSH () {
		
		if(session !=null && session.isConnected()){  
            //System.out.println("Closing SSH Connection");  
            session.disconnect();
		}
	}
	
	private String methodCall(String method, Object[] params)
	throws IllegalArgumentException, IllegalStateException, IOException {
		StringWriter bodyWriter = new StringWriter();
		serializer.setOutput(bodyWriter);
		serializer.startDocument(null, null);
		serializer.startTag(null, Tag.METHOD_CALL);
		// set method name
		serializer.startTag(null, Tag.METHOD_NAME).text(method).endTag(null, Tag.METHOD_NAME);
		
		serializeParams(params);

		serializer.endTag(null, Tag.METHOD_CALL);
		serializer.endDocument();

		return bodyWriter.toString();
	}

	/**
	 * Convenience method call with no parameters
	 * 
	 * @param method name of method to call
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	public Object call(String method) throws XMLRPCException {
		return callEx(method, null);
	}
	
	/**
	 * Convenience method call with one parameter
	 * 
	 * @param method name of method to call
	 * @param p0 method's parameter
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	public Object call(String method, Object p0) throws XMLRPCException {
		Object[] params = {
			p0,
		};
		return callEx(method, params);
	}
	
	/**
	 * Convenience method call with two parameters
	 * 
	 * @param method name of method to call
	 * @param p0 method's 1st parameter
	 * @param p1 method's 2nd parameter
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	public Object call(String method, Object p0, Object p1) throws XMLRPCException {
		Object[] params = {
			p0, p1,
		};
		return callEx(method, params);
	}
	
	/**
	 * Convenience method call with three parameters
	 * 
	 * @param method name of method to call
	 * @param p0 method's 1st parameter
	 * @param p1 method's 2nd parameter
	 * @param p2 method's 3rd parameter
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	public Object call(String method, Object p0, Object p1, Object p2) throws XMLRPCException {
		Object[] params = {
			p0, p1, p2,
		};
		return callEx(method, params);
	}

	/**
	 * Convenience method call with four parameters
	 * 
	 * @param method name of method to call
	 * @param p0 method's 1st parameter
	 * @param p1 method's 2nd parameter
	 * @param p2 method's 3rd parameter
	 * @param p3 method's 4th parameter
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	public Object call(String method, Object p0, Object p1, Object p2, Object p3) throws XMLRPCException {
		Object[] params = {
			p0, p1, p2, p3,
		};
		return callEx(method, params);
	}

	/**
	 * Convenience method call with five parameters
	 * 
	 * @param method name of method to call
	 * @param p0 method's 1st parameter
	 * @param p1 method's 2nd parameter
	 * @param p2 method's 3rd parameter
	 * @param p3 method's 4th parameter
	 * @param p4 method's 5th parameter
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	public Object call(String method, Object p0, Object p1, Object p2, Object p3, Object p4) throws XMLRPCException {
		Object[] params = {
			p0, p1, p2, p3, p4,
		};
		return callEx(method, params);
	}

	/**
	 * Convenience method call with six parameters
	 * 
	 * @param method name of method to call
	 * @param p0 method's 1st parameter
	 * @param p1 method's 2nd parameter
	 * @param p2 method's 3rd parameter
	 * @param p3 method's 4th parameter
	 * @param p4 method's 5th parameter
	 * @param p5 method's 6th parameter
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	public Object call(String method, Object p0, Object p1, Object p2, Object p3, Object p4, Object p5) throws XMLRPCException {
		Object[] params = {
			p0, p1, p2, p3, p4, p5,
		};
		return callEx(method, params);
	}

	/**
	 * Convenience method call with seven parameters
	 * 
	 * @param method name of method to call
	 * @param p0 method's 1st parameter
	 * @param p1 method's 2nd parameter
	 * @param p2 method's 3rd parameter
	 * @param p3 method's 4th parameter
	 * @param p4 method's 5th parameter
	 * @param p5 method's 6th parameter
	 * @param p6 method's 7th parameter
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	public Object call(String method, Object p0, Object p1, Object p2, Object p3, Object p4, Object p5, Object p6) throws XMLRPCException {
		Object[] params = {
			p0, p1, p2, p3, p4, p5, p6,
		};
		return callEx(method, params);
	}

	/**
	 * Convenience method call with eight parameters
	 * 
	 * @param method name of method to call
	 * @param p0 method's 1st parameter
	 * @param p1 method's 2nd parameter
	 * @param p2 method's 3rd parameter
	 * @param p3 method's 4th parameter
	 * @param p4 method's 5th parameter
	 * @param p5 method's 6th parameter
	 * @param p6 method's 7th parameter
	 * @param p7 method's 8th parameter
	 * @return deserialized method return value
	 * @throws XMLRPCException
	 */
	public Object call(String method, Object p0, Object p1, Object p2, Object p3, Object p4, Object p5, Object p6, Object p7) throws XMLRPCException {
		Object[] params = {
			p0, p1, p2, p3, p4, p5, p6, p7,
		};
		return callEx(method, params);
	}
	
	public URI getUri() {
		return this.uri;
	}
}
