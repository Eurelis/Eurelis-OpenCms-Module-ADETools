/*
 * Copyright (c) Eurelis. All rights reserved. CONFIDENTIAL - Use is subject to license terms.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are not permitted without prior written permission of Eurelis.
 */

package com.eurelis.opencms.ade.tools.responsivepreview;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.opencms.file.CmsFile;
import org.opencms.file.CmsObject;
import org.opencms.jsp.CmsJspActionElement;
import org.opencms.main.CmsException;
import org.opencms.main.CmsLog;



public class DeviceListReader {

	private static final Log LOG = CmsLog.getLog(DeviceListReader.class);
	
	public static final String DEVICES_XML_VFSPATH = "/system/modules/com.eurelis.opencms.ade.tools/resources/devices.xml";
	
	private CmsJspActionElement jsp = null;
	
	public DeviceListReader(CmsJspActionElement jsp) {
		this.jsp = jsp;
		
	}
	
	public void processRequest(HttpServletRequest request) {
		CmsObject cmsObject = jsp.getCmsObject();
		//String siteRoot = cmsObject.getRequestContext().getSiteRoot();
		//cmsObject.getRequestContext().setSiteRoot("");
		try {
			CmsFile cmsFile = cmsObject.readFile(DEVICES_XML_VFSPATH);
		
			byte[] cmsContent = cmsFile.getContents();
			
			
			SAXReader saxReader = new SAXReader();
			InputStream is = new ByteArrayInputStream(cmsContent);
			Document doc = saxReader.read(is);
			is.close();
			
			
			List<Element> deviceElementList = doc.selectNodes("//device");
			List<DeviceVO> deviceVOList = new ArrayList<DeviceVO>();
			
			for (Element deviceElement : deviceElementList) {
				deviceVOList.add(this.constructDeviceVo(deviceElement));
			}
			
			request.setAttribute("deviceVOList", deviceVOList);
			
		
		} catch (CmsException e) {
			LOG.error("processRequest " + e.getMessage());
		} catch (DocumentException e) {
			LOG.error("processRequest " + e.getMessage());
		} catch (IOException e) {
			LOG.error("processRequest " + e.getMessage());
		}
		
		
		//cmsObject.getRequestContext().setSiteRoot(siteRoot);
	}
	
	protected DeviceVO constructDeviceVo(Element deviceElement) {
		
		Element image = (Element)deviceElement.selectSingleNode("image");
		Element screen = (Element)deviceElement.selectSingleNode("screen");
		Element labelElement = (Element)deviceElement.selectSingleNode("label");
		
		String id = deviceElement.attributeValue("id");
		String label = labelElement.getTextTrim();
		int imageWidth = Integer.parseInt(image.attributeValue("width"));
		int imageHeight = Integer.parseInt(image.attributeValue("height"));
		String imageSrc = image.getTextTrim();
		int screenWidth = Integer.parseInt(screen.attributeValue("width"));
		int screenHeight = Integer.parseInt(screen.attributeValue("height"));
		int screenTop = Integer.parseInt(screen.attributeValue("top"));
		int screenLeft = Integer.parseInt(screen.attributeValue("left"));
		
		return new DeviceVO(id, label, imageWidth, imageHeight, imageSrc, screenWidth, screenHeight, screenTop, screenLeft);
	}
	
	
	
}
