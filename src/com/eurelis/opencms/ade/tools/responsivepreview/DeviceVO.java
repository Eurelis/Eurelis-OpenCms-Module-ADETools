/*
 * Copyright (c) Eurelis. All rights reserved. CONFIDENTIAL - Use is subject to license terms.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are not permitted without prior written permission of Eurelis.
 */

package com.eurelis.opencms.ade.tools.responsivepreview;

public class DeviceVO {

	private String id;
	private String label;
	private int imageWidth;
	private int imageHeight;
	private String imageSrc;
	private int screenWidth;
	private int screenHeight;
	private int screenTop;
	private int screenLeft;
	
	private DeviceVO() {
		
	}
	
	public DeviceVO(String id, String label, int imageWidth, int imageHeight, String imageSrc, int screenWidth, int screenHeight, int screenTop, int screenLeft) {
		this.id = id;
		this.label = label;
		this.imageWidth = imageWidth;
		this.imageHeight = imageHeight;
		this.imageSrc = imageSrc;
		this.screenWidth = screenWidth;
		this.screenHeight = screenHeight;
		this.screenTop = screenTop;
		this.screenLeft = screenLeft;
	}

	public String getId() {
		return id;
	}
	
	public String getLabel() {
		return label;
	}

	public int getImageWidth() {
		return imageWidth;
	}

	public int getImageHeight() {
		return imageHeight;
	}

	public String getImageSrc() {
		return imageSrc;
	}

	public int getScreenWidth() {
		return screenWidth;
	}

	public int getScreenHeight() {
		return screenHeight;
	}

	public int getScreenTop() {
		return screenTop;
	}

	public int getScreenLeft() {
		return screenLeft;
	}
	
	
}
