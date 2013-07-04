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

package com.eurelis.opencms.ade.tools.responsivepreview;

import java.text.MessageFormat;
import java.util.Locale;

import org.opencms.i18n.A_CmsMessageBundle;
import org.opencms.i18n.CmsMessageContainer;
import org.opencms.i18n.I_CmsMessageBundle;

/**
 * Convenience class to access the localized messages of this OpenCms package.<p> 
 * 
 * @author Arnaud Demaiziere
 */
public final class Messages extends A_CmsMessageBundle {

	/** Name of the used resource bundle. */
	private static final String BUNDLE_NAME = "com.eurelis.opencms.ade.tools.responsivepreview.messages";

	/** Static instance member. */
	private static final I_CmsMessageBundle INSTANCE = new Messages();

	
	public static final String GUI_RESPONSIVEPREVIEW_JSP_TITLE_0 = "GUI_RESPONSIVEPREVIEW_JSP_TITLE_0";
	public static final String GUI_RESPONSIVEPREVIEW_JSP_DEVICELIST_0 = "GUI_RESPONSIVEPREVIEW_JSP_DEVICELIST_0";
	
	public static final String GUI_RESPONSIVEPREVIEW_JSP_DEVICEORIENTATION_0 = "GUI_RESPONSIVEPREVIEW_JSP_DEVICEORIENTATION_0";
	public static final String GUI_RESPONSIVEPREVIEW_JSP_DEVICEORIENTATION_LANDSCAPE_0 = "GUI_RESPONSIVEPREVIEW_JSP_DEVICEORIENTATION_LANDSCAPE_0";
	public static final String GUI_RESPONSIVEPREVIEW_JSP_DEVICEORIENTATION_PORTRAIT_0 = "GUI_RESPONSIVEPREVIEW_JSP_DEVICEORIENTATION_PORTRAIT_0";

	public static final String GUI_RESPONSIVEPREVIEW_JSP_OK_0 = "GUI_RESPONSIVEPREVIEW_JSP_OK_0";
	public static final String GUI_RESPONSIVEPREVIEW_JSP_CANCEL_0 = "GUI_RESPONSIVEPREVIEW_JSP_CANCEL_0";

	public static final String GUI_RESPONSIVEPREVIEW_JSP_IPHONEALERT_TEXT_0 = "GUI_RESPONSIVEPREVIEW_JSP_IPHONEALERT_TEXT_0";
	
	public static final String GUI_RESPONSIVEPREVIEW_JSP_PAGEURL_0 = "GUI_RESPONSIVEPREVIEW_JSP_PAGEURL_0";
	
	/**
	 * Hides the public constructor for this utility class.<p>
	 */
	private Messages() {

		// hide the constructor
	}

	public static String getLbl(String key, Locale locale) {
		CmsMessageContainer messageContainer = Messages.get().container(key);
		return new MessageFormat(messageContainer.key(locale), locale).format(new Object[] { messageContainer.key(locale) });
	}
	
	/**
	 * Returns an instance of this localized message accessor.<p>
	 * 
	 * @return an instance of this localized message accessor
	 */
	public static I_CmsMessageBundle get() {

		return INSTANCE;
	}

	/**
	 * Returns the bundle name for this OpenCms package.<p>
	 * 
	 * @return the bundle name for this OpenCms package
	 */
	public String getBundleName() {

		return BUNDLE_NAME;
	}
}