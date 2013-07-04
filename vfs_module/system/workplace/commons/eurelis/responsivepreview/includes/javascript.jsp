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
<script>


var url = getURLParameter('url');
var orientation = getURLParameter('orientation');
var device = getURLParameter('device'); 

<c:if test="${iframeMode}">
  $(function(){
    $('#url').val(top.location.href);
    $('#urldisplay').text(top.location.href);
    url = top.location.href;
  });
</c:if>

var ios = new Array();
<c:forEach var="device" items="${deviceVOList}">
ios['${device.id}'] = {
        'portrait' : {
            'width' : ${device.imageWidth},
            'height': ${device.imageHeight},
            'next-class' : 'landscape',
            'img': '<cms:link>/system/modules/com.eurelis.opencms.ade.tools/resources/rotate-ccw.png</cms:link>',
          },
          'landscape' : {
            'width' : ${device.imageHeight},
            'height': ${device.imageWidth},
            'next-class' : 'portrait',
            'img': '<cms:link>/system/modules/com.eurelis.opencms.ade.tools/resources/rotate-cw.png</cms:link>',
          }};
</c:forEach>

function getURLParameter(name) {
  return decodeURI((RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]);
}
function openWindow(w,h,url) {
  window.open(url,"_blank","width="+Math.min(screen.width-16,w)+",height="+Math.min(screen.height-64,h));
}
function submit() {
  var params = {};
  var devices = new Array();
  $.each($('#form').serializeArray(), function(i, field) {
      if (field.name == 'device') {
      	devices.push(field.value)
      }
      else {
  		params[field.name] = field.value;
      }
      
  });
  
  var url = $('#url').val();
  
  //var device = params['device'];
  var orientation = 'portrait';
  
  $.each(devices, function(index, device) {
  	openWindow(ios[device][orientation]['width'], ios[device][orientation]['height'], location.pathname+'?url='+url+'&device='+device+'&orientation='+orientation);
  });
  
  return <c:out value="${!iframeMode}"/>;
}
function rotate() {
  var next = ios[device][orientation]['next-class'];
  openWindow(ios[device][next]['width'] + 10, ios[device][next]['height'] + 10, location.pathname+'?url='+url+'&device='+device+'&orientation='+next);
  window.close();
}
$(document).ready(function(){
	var actionIframe = ${(param.action == 'iframe')?'true':'false'};
  if(url != 'null' && url != null && !actionIframe) {
	 
    if(!orientation) orientation = "portrait";
    if(!device) device = "iphone";
    $('#rotate').click(rotate);
    $('iframe').attr('src', url+'?device='+device);
         
    $('#ios').attr('class', device+' '+orientation);
    $('#rotate img').attr('src', ios[device][orientation]['img']);
    $('#ios').show();
    $('#iphone_alert').hide();
  }
  else {
    $('#form').submit(submit);
    $('#help').show();
  }
});
</script>
<%
  }
%>