package com.tianrui.web.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.security.KeyStore;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.alibaba.fastjson.JSONObject;

import tianrui.work.bean.WeiXinPay;
import tianrui.work.bean.WeiXinPayXml;
import tianrui.work.comm.Constant;

/**
 * 
 * @author My
 * @CreateDate 2016-3-25
 * @param
 */
public class Payxiadan {
	
	public Map getprepay_id(PayxiadanReq req)  throws Exception {

		WeiXinPay pay = new WeiXinPay();
		pay.setNonce_str(req.getNonce_str());
		
		pay.setOut_trade_no(req.getWaybillid());
		pay.setBody(req.getTotal());

		float sessionmoney = Float.parseFloat(req.getMoney());
		sessionmoney = sessionmoney * 100;
		String sd = String.valueOf(sessionmoney);
		pay.setTotal_fee(sd.substring(0,sd.length()-2));
		pay.setOpenid(req.getOpenid());
		pay.setSpbill_create_ip(req.getIp());
		pay.setNotify_url(Constant.WEIXIN_BASE_URL+req.getNotify());
		
		WeiXinPay signpay = Sign.paysign(pay);
		String xml = new WeiXinPayXml().payXml(signpay);
		
		String url = "https://api.mch.weixin.qq.com/pay/unifiedorder";
		
		ClassLoader classLoader = Thread.currentThread()  
                .getContextClassLoader();  
       
    	if (classLoader == null) {  
            classLoader = ClassLoader.getSystemClassLoader();  
        }  
		java.net.URL urls = classLoader.getResource("");  
    	String ROOT_CLASS_PATH = urls.getPath() + "/";  
        File rootFile = new File(ROOT_CLASS_PATH);  
    	String WEB_INFO_DIRECTORY_PATH = rootFile.getParent() + "/";  
    	File webInfoDir = new File(WEB_INFO_DIRECTORY_PATH);  
    	String SERVLET_CONTEXT_PATH = webInfoDir.getParent() + "/";  
        
        String  xmlFile = SERVLET_CONTEXT_PATH + "/cert/apiclient_cert.p12";
        System.out.println("path"+xmlFile);
		
        KeyStore keyStore  = KeyStore.getInstance("PKCS12");
        FileInputStream instream = new FileInputStream(new File(xmlFile));
        try {
            keyStore.load(instream, Constant.WEIXIN_SHANGPU.toCharArray());//鍟嗘埛瀵嗙爜
        } finally {
            instream.close();
        }

        // Trust own CA and all self-signed certs
        SSLContext sslcontext = SSLContexts.custom()
                .loadKeyMaterial(keyStore, Constant.WEIXIN_SHANGPU.toCharArray())
                .build();
        // Allow TLSv1 protocol only
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                sslcontext,
                new String[] { "TLSv1" },
                null,
                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
        CloseableHttpClient httpclient = HttpClients.custom()
                .setSSLSocketFactory(sslsf)
                .build();
       
        Map way = new HashMap();

        try {
        	HttpPost post = new HttpPost(url);
        	
        	System.out.println(xml);
        	HttpEntity ent = new StringEntity(xml, "UTF-8");  
        	post.setEntity(ent);
        	HttpResponse response2 = new DefaultHttpClient().execute(post);
            

        	System.out.println("executing request==" + post.getRequestLine());
            CloseableHttpResponse response = httpclient.execute(post);
            try {
                HttpEntity entity = response.getEntity();

                System.out.println("----------------------------------------");
                System.out.println(response.getStatusLine());
                if (entity != null) {
                    System.out.println("Response content length: " + entity.getContentLength());
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(entity.getContent()));
                    String text ;
                    StringBuffer buf = new StringBuffer();
                    while ((text = bufferedReader.readLine()) != null) {
                        buf.append(text);
                    	System.out.println(text);
                    }
                    way = new ReceiveXmlProcess().getwayEntity(buf.toString());
                    JSONObject json = new JSONObject();
                    json.put("prepayId", way.get("prepay_id"));
                    json.put("mchId", way.get("mch_id"));
                    json.put("appId", way.get("appid"));
                    json.put("tradeType", way.get("trade_type"));
                    json.put("returnCode", way.get("return_code"));
                    json.put("outTradeNo", req.getWaybillid());
//                    String js = new ChuliService().commonUrl(json.toString(), "/App/addprePay", null);
            	    System.out.println(json);
                }
                EntityUtils.consume(entity);
            } finally {
                response.close();
            }
        } finally {
            httpclient.close();
        }
		return way;
	}
}
