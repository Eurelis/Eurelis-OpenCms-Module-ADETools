<%@ page pageEncoding="UTF-8" %>
<%@ page import="org.opencms.staticexport.CmsLinkManager,org.opencms.main.OpenCms,org.opencms.jsp.CmsJspActionElement,org.opencms.file.CmsObject,org.opencms.i18n.CmsEncoder,org.opencms.workplace.CmsDialog,org.opencms.workplace.CmsWorkplace,org.opencms.workplace.CmsWorkplaceSettings,org.opencms.workplace.CmsWorkplaceManager,java.util.*,com.eurelis.opencms.ade.tools.responsivepreview.*" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%    
/**
 * This file is part of the Eurelis OpenCms Admin Module.
 * 
 * Copyright (c) 2013 Eurelis (http://www.eurelis.com)
 *
 * This module is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public 
 * License along with this module. 
 * If not, see <http://www.gnu.org/licenses/>
 */
 
  CmsJspActionElement jsp = new CmsJspActionElement(pageContext, request, response);
 
    String actionParam = request.getParameter("action");
    boolean iframeMode = false;
    
  if (actionParam != null && actionParam.equals("submit")) {
    jsp.include(CmsWorkplace.FILE_EXPLORER_FILELIST, null, new HashMap());  
  
  }
  else {
    String onlineLink = null;
    
    
    CmsObject cmsObject = jsp.getCmsObject();
    CmsWorkplaceSettings settings = (CmsWorkplaceSettings)session.getAttribute(CmsWorkplaceManager.SESSION_WORKPLACE_SETTINGS);
    Locale locale = settings.getUserSettings().getLocale();
    
    if (actionParam == null || !actionParam.equals("iframe")) {
      String resourceName =  CmsEncoder.decode(jsp.getRequest().getParameter(CmsDialog.PARAM_RESOURCE));
      onlineLink = OpenCms.getLinkManager().getServerLink(cmsObject, resourceName);
    }
    else {
      iframeMode = true;
    }
    
    
    DeviceListReader dlr = new DeviceListReader(jsp);
    dlr.processRequest(request);
  
%>
<style type="text/css">
  body {
    font-family: Verdana,Helvetica,Arial,sans-serif;
    margin: 0;
  }
  #ios, #iphone_alert, #help { 
    display:none; 
  }
  #orientationlandscape img {
    padding: 0 20px;
    -webkit-transform: rotate(90deg);
       -moz-transform: rotate(90deg);
        -ms-transform: rotate(90deg);
         -o-transform: rotate(90deg);
            transform: rotate(90deg);
  }
  #help table tr td{
    padding: 10px 0;
  }
  label img {
    padding: 0 10px;
    vertical-align:middle;
  }
  
  <c:forEach var="device" items="${deviceVOList}">
  div#ios.${device.id}.portrait {
      width:${device.imageWidth}px;
      height:${device.imageHeight}px;
      background: url(<cms:link>${device.imageSrc}</cms:link>) no-repeat;
  }
  div#ios.${device.id}.landscape {
      width:${device.imageHeight}px;
      height:${device.imageWidth}px;
  }
  div#ios.${device.id}.landscape:before {
    content: "";
    position: absolute;
    z-index: -1;
    width: ${device.imageHeight * 2}px;
    height: ${device.imageWidth * 2}px;
    top: -${device.imageHeight}px;
    left: -${device.imageHeight - device.imageWidth}px;
    background: url(<cms:link>${device.imageSrc}</cms:link>) no-repeat;
    -webkit-transform: rotate(-90deg);
    -moz-transform: rotate(-90deg);
    -ms-transform: rotate(-90deg);
    -o-transform: rotate(-90deg);
    transform: rotate(-90deg);
  }
  
  .${device.id}.landscape iframe {
    width: ${device.screenHeight}px;
    height: ${device.screenWidth}px;
    padding: ${device.imageWidth - device.screenWidth - device.screenLeft}px ${device.imageHeight - device.screenHeight - device.screenTop}px ${device.screenLeft}px ${device.screenTop}px;
  }
  
  .${device.id}.portrait iframe {
    width: ${device.screenWidth}px;
    height: ${device.screenHeight}px;
    padding: ${device.screenTop}px ${device.imageWidth - device.screenWidth - device.screenLeft}px ${device.imageHeight - device.screenHeight - device.screenTop}px ${device.screenLeft}px;
  }
  
  
  div#ios.${device.id}.portrait #iphone_alert {
    top: ${device.screenTop + device.screenHeight / 2 - 220}px;
    left: ${device.screenLeft + device.screenWidth / 2 - 160}px;
  }
  
  div#ios.${device.id}.landscape #iphone_alert {
    top: ${device.imageWidth - device.screenWidth - device.screenLeft + device.screenWidth / 2 - 220}px;
    left: ${device.screenTop + device.screenHeight / 2 - 160}px;
  }
  
  </c:forEach>
  
  
  div#ios.landscape, div#ios.portrait {
     position: relative;
     overflow: hidden;
  }
  iframe {
    position: absolute;
    border:none;
  }
  
  a {
    color: #CCCCCC;
    position: absolute;
    top: 30px;
    left: 30px;
    z-index:1;
  }
  
 
  /* Alert */
  #iphone_alert {
    width : 320px;
    height : 480px;
    position: absolute;
    display: block;
    z-index:3000;
    color: #fff;
  }

  #iphone_alert .alert {
    font: normal 17px/23px "Helvetica Neue", Arial;
    background: #162344;
    background: rgba(22,35,68,0.9);
    color: #fff;
    text-shadow: hsla(0,0%,0%,0.8) 0 -1px 0;
    margin: 0 auto;
    padding: 0 0 8px 0;
    border: 2px #dfe1e6 solid;
    position: absolute;
    width: 90%;
    left: 4.5%;
    top:30%;
    -webkit-border-radius: 9px;
       -moz-border-radius: 9px;
            border-radius: 9px;
    -webkit-box-shadow: hsla(0,0%,0%,0.7) 0 1px 2px;
       -moz-box-shadow: hsla(0,0%,0%,0.7) 0 1px 2px;
            box-shadow: hsla(0,0%,0%,0.7) 0 1px 2px;
  }
  #iphone_alert .alert::after {
    content: '';
    background: -webkit-linear-gradient(top, rgba(255, 255, 255, 0.4), rgba(255, 255, 255, 0.3));
    background:    -moz-linear-gradient(top, rgba(255, 255, 255, 0.4), rgba(255, 255, 255, 0.3));
    background:     -ms-linear-gradient(top, rgba(255, 255, 255, 0.4), rgba(255, 255, 255, 0.3));
    background:      -o-linear-gradient(top, rgba(255, 255, 255, 0.4), rgba(255, 255, 255, 0.3));
    background:         linear-gradient(top, rgba(255, 255, 255, 0.4), rgba(255, 255, 255, 0.3));
    -ms-filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#697287', EndColorStr='#343f5c', GradientType=0);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#697287', endColorstr='#343f5c', GradientType=0);
    height: 15%;
    width: 100%;
    -webkit-border-radius: 7px 7px 50% 50%  / 7px 7px 4px 4px;
       -moz-border-radius: 7px 7px 50% 50%  / 7px 7px 4px 4px;
            border-radius: 7px 7px 50% 50%  / 7px 7px 4px 4px;
    position: absolute;
    left: 0;
    top:0;
  }

  #iphone_alert .text {
    position: relative;
    z-index: 110;
    text-align: center;
    width: 90%;
    left: 5%;
    margin: 13px 0 15px 0;
  }
  #iphone_alert .text b {
    margin-bottom: 5px;
    display: block;
  }
  #iphone_alert .button {
    font-weight: bold;
    font-size: 15px;
    height: 30px;
    line-height: 30px;
    text-align: center;
    width: 35%;
    cursor: pointer;
    border: 1px #131e3b solid;
    display: block;
    text-decoration: none;
    color: #fff;
    cursor: pointer;
    background: -webkit-linear-gradient(top, rgba(116, 124, 143, 0.8) 0%, rgba(52, 63, 92, 0.8) 50%, rgba(22, 35, 68, 0.8) 50%, rgba(35, 47, 78, 0.8) 100%);
    background:    -moz-linear-gradient(top, rgba(116, 124, 143, 0.8) 0%, rgba(52, 63, 92, 0.8) 50%, rgba(22, 35, 68, 0.8) 50%, rgba(35, 47, 78, 0.8) 100%);
    background:     -ms-linear-gradient(top, rgba(116, 124, 143, 0.8) 0%, rgba(52, 63, 92, 0.8) 50%, rgba(22, 35, 68, 0.8) 50%, rgba(35, 47, 78, 0.8) 100%);
    background:      -o-linear-gradient(top, rgba(116, 124, 143, 0.8) 0%, rgba(52, 63, 92, 0.8) 50%, rgba(22, 35, 68, 0.8) 50%, rgba(35, 47, 78, 0.8) 100%);
    background:         linear-gradient(top, rgba(116, 124, 143, 0.8) 0%, rgba(52, 63, 92, 0.8) 50%, rgba(22, 35, 68, 0.8) 50%, rgba(35, 47, 78, 0.8) 100%);
    -ms-filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#747c8f', EndColorStr='#232f4e', GradientType=0);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#747c8f', endColorstr='#232f4e', GradientType=0);
    -webkit-border-radius:5px;
       -moz-border-radius:5px;
            border-radius:5px;
    -webkit-box-shadow: #454f69 0 1px 0;
       -moz-box-shadow: #454f69 0 1px 0;
            box-shadow: #454f69 0 1px 0;
  }

  #iphone_alert .button.wide {
    width: 235px;
    margin-left: 10px;
  }
  #iphone_alert .button.f_left {
    float: left;
    margin: 0 0 0 10px;
  }
  #iphone_alert .button.f_right {
    float: right;
    margin: 0 10px 0 0;
    top: 102px;
    left: 145px;
  }

  #iphone_alert .button.light {
    background: -webkit-linear-gradient(top, rgba(174, 178, 190, 0.6) 0%, rgba(106, 116, 139, 0.6) 50%, rgba(80, 90, 117, 0.6) 50%, rgba(95, 105, 129, 0.6) 100%);
    background:    -moz-linear-gradient(top, rgba(174, 178, 190, 0.6) 0%, rgba(106, 116, 139, 0.6) 50%, rgba(80, 90, 117, 0.6) 50%, rgba(95, 105, 129, 0.6) 100%);
    background:     -ms-linear-gradient(top, rgba(174, 178, 190, 0.6) 0%, rgba(106, 116, 139, 0.6) 50%, rgba(80, 90, 117, 0.6) 50%, rgba(95, 105, 129, 0.6) 100%);
    background:      -o-linear-gradient(top, rgba(174, 178, 190, 0.6) 0%, rgba(106, 116, 139, 0.6) 50%, rgba(80, 90, 117, 0.6) 50%, rgba(95, 105, 129, 0.6) 100%);
    background:         linear-gradient(top, rgba(174, 178, 190, 0.6) 0%, rgba(106, 116, 139, 0.6) 50%, rgba(80, 90, 117, 0.6) 50%, rgba(95, 105, 129, 0.6) 100%);
    -ms-filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#aeb2be', EndColorStr='#5f6981', GradientType=0);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#aeb2be', endColorstr='#5f6981', GradientType=0);
    -webkit-box-shadow: #454f69 0 1px 0, inset #dadde4 0 1px 0;
       -moz-box-shadow: #454f69 0 1px 0, inset #dadde4 0 1px 0;
            box-shadow: #454f69 0 1px 0, inset #dadde4 0 1px 0;
  }

  #iphone_alert .button:active {
    background: -webkit-linear-gradient(top, rgba(90, 95, 102, 0.7) 0%, rgba(41, 47, 57, 0.7) 50%, rgba(23, 31, 40, 0.7) 50%, rgba(36, 44, 53, 0.7) 100%);
    background:    -moz-linear-gradient(top, rgba(90, 95, 102, 0.7) 0%, rgba(41, 47, 57, 0.7) 50%, rgba(23, 31, 40, 0.7) 50%, rgba(36, 44, 53, 0.7) 100%);
    background:     -ms-linear-gradient(top, rgba(90, 95, 102, 0.7) 0%, rgba(41, 47, 57, 0.7) 50%, rgba(23, 31, 40, 0.7) 50%, rgba(36, 44, 53, 0.7) 100%);
    background:      -o-linear-gradient(top, rgba(90, 95, 102, 0.7) 0%, rgba(41, 47, 57, 0.7) 50%, rgba(23, 31, 40, 0.7) 50%, rgba(36, 44, 53, 0.7) 100%);
    background:         linear-gradient(top, rgba(90, 95, 102, 0.7) 0%, rgba(41, 47, 57, 0.7) 50%, rgba(23, 31, 40, 0.7) 50%, rgba(36, 44, 53, 0.7) 100%);
    -ms-filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#5a5f66', EndColorStr='#242c35', GradientType=0);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#5a5f66', endColorstr='#242c35', GradientType=0);
    -webkit-box-shadow: #454f69 0 1px 0;
       -moz-box-shadow: #454f69 0 1px 0;
            box-shadow: #454f69 0 1px 0;
  }
  .button {
    float: left; display: block; padding: 2px 15px 4px; color: #c6c6c6; font: bold 13px/22px "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; text-decoration: none; text-shadow: rgba(0,0,0,0.7) 0 1px 1px; cursor: pointer; margin: 0 5px;
    background: -webkit-linear-gradient(top, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
    background:    -moz-linear-gradient(top, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
    background:     -ms-linear-gradient(top, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
    background:      -o-linear-gradient(top, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
    background:         linear-gradient(top, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
    -webkit-border-radius:20px;
       -moz-border-radius:20px;
            border-radius:20px; 
    -webkit-box-shadow: rgba(0,0,0,0.4) 0 1px 0, inset rgba(255,255,255,0.2) 0 1px 0;
       -moz-box-shadow: rgba(0,0,0,0.4) 0 1px 0, inset rgba(255,255,255,0.2) 0 1px 0;
            box-shadow: rgba(0,0,0,0.4) 0 1px 0, inset rgba(255,255,255,0.2) 0 1px 0;
  }

  .button:hover {
    background: -webkit-linear-gradient(top, rgba(255,255,255,0.2), rgba(0,0,0,0.1));
    background:    -moz-linear-gradient(top, rgba(255,255,255,0.2), rgba(0,0,0,0.1));
    background:     -ms-linear-gradient(top, rgba(255,255,255,0.2), rgba(0,0,0,0.1));
    background:      -o-linear-gradient(top, rgba(255,255,255,0.2), rgba(0,0,0,0.1));
    background:         linear-gradient(top, rgba(255,255,255,0.2), rgba(0,0,0,0.1));
  }

  .button:active {
    background: -webkit-linear-gradient(bottom, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
    background:    -moz-linear-gradient(bottom, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
    background:     -ms-linear-gradient(bottom, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
    background:      -o-linear-gradient(bottom, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
    background:         linear-gradient(bottom, rgba(255,255,255,0.1), rgba(0,0,0,0.1));
  }
</style>
<%
  }
%>