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
 			pageContext.setAttribute("iframeMode", Boolean.FALSE);
 		}
 		else {
 			iframeMode = true;
 			pageContext.setAttribute("iframeMode", Boolean.TRUE);
 		}
 		
 		
		DeviceListReader dlr = new DeviceListReader(jsp);
		dlr.processRequest(request);
	
		
		
%>

<!doctype html>
<html>
  <head>
  	<title><%= Messages.getLbl(Messages.GUI_RESPONSIVEPREVIEW_JSP_TITLE_0, locale) %></title>
    <script src="<cms:link>/system/modules/com.eurelis.opencms.ade.tools/resources/javascript/libs/jquery-2.0.0.min.js</cms:link>"></script>
    <cms:include file="/system/workplace/commons/eurelis/responsivepreview/includes/javascript.jsp">
      <cms:param name="iframeMode" value="${iframeMode}"/>
    </cms:include>
    <cms:include file="/system/workplace/commons/eurelis/responsivepreview/includes/css.jsp"/>
    <style type="text/css">
      html {
        background-color:#eee;
      }
    </style>
  </head>
  <body>
  <c:if test="${empty param['url'] && empty param['device'] && empty param['orientation']}"> 
  	<table class="dialog" cellspacing="0" cellpadding="0">
		<tbody><tr><td>
			<table class="dialogbox" cellpadding="0" cellspacing="0">
				<tbody><tr><td>
					<div class="dialogcontent" unselectable="on">
					<!-- dialogcontent start -->
						<table class="xmlTable" cellpadding="0" cellspacing="0">
							<tbody><tr><td colspan="5">
	</c:if>
	
    							<div id="help">
      								<form name="form" id="form" action="">
        								<table style="width:100%;padding-left:20px">
          									<tr>
            									<td><b><%= Messages.getLbl(Messages.GUI_RESPONSIVEPREVIEW_JSP_DEVICELIST_0, locale) %></b></td>
                            </tr>
                            <tr>
            									<td>
            										<c:forEach var="device" items="${deviceVOList}" varStatus="status">
              										<label id="device${device.id}"><input type="checkbox" name="device" value="${device.id}"/><img src="<cms:link>${device.imageSrc}</cms:link>" height="60"/>${device.label}</label>  
              										</c:forEach><input type="hidden" name="url" id="url" style="width: 99%" class="xmlInput" value="<%=onlineLink%>"/>
            									</td>
          									</tr>         									
          									<tr>
            									<td>
													<div class="dialogbuttons" unselectable="on">
														<input class="dialogbutton" type="submit" value="<%= Messages.getLbl(Messages.GUI_RESPONSIVEPREVIEW_JSP_OK_0, locale) %>" name="ok">
														
    	<% if (!iframeMode) { %>														
														<input class="dialogbutton" type="button" onclick="this.form.submit();" value="<%= Messages.getLbl(Messages.GUI_RESPONSIVEPREVIEW_JSP_CANCEL_0, locale) %>" name="cancel">
	    <% } %>
														
														<input type="hidden" name="action" value="submit">
													</div>
												
												</td>
          									</tr>
        								</table>
      								</form>
    							</div>
    							<div id="ios">
      								<a id="rotate" href="javascript:void(0)"><img/></a>
      								<iframe></iframe>
                      <div id="iphone_alert" class="iphone_alert">
                        <div class="alert">
                            <div class="text"><%= Messages.getLbl(Messages.GUI_RESPONSIVEPREVIEW_JSP_IPHONEALERT_TEXT_0, locale) %></div>
                            <div class="button f_left" onclick="$('#iphone_alert').hide()"><%= Messages.getLbl(Messages.GUI_RESPONSIVEPREVIEW_JSP_CANCEL_0, locale) %></div>
                            <a class="button f_right light" onclick="$('#iphone_alert').hide()"><%= Messages.getLbl(Messages.GUI_RESPONSIVEPREVIEW_JSP_OK_0, locale) %></a>
                            <br class="clear" />
                        </div>
                      </div>
    							</div>
								
<c:if test="${empty param['url'] && empty param['device'] && empty param['orientation']}"> 								
							</td></tr></tbody>
						</table>
					</div>
				</td></tr></tbody>
			</table>
		</td></tr></tbody>
	</table>
</c:if>
  </body>
</html>
<%
	}
%>