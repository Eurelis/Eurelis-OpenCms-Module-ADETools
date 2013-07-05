Eurelis - OpenCms Module ADE Tools
==================================

This module developed by [Eurelis][eurelis] is intended to add several tools to Administrators on pages (type containerpage).


Responsive Preview
-----------------------------------------------------------------
The aim of the **Responsive Preview** tool is to allow contributors to open a containerpage in a responsive context (iPhone, iPad, ...)

### Usage in the ADE view:
This tool can be accessed while viewing a containerpage in the **ADE** mode of [OpenCms][opencms].

1. In the Page menu, select **Responsive preview**
![usage-ade-01]

2. Select the devices you want to open, and click **OK**
![usage-ade-02]

3. The containerpage is opened on new pages respresenting the devices.
![usage-ade-03]


### Usage in the Explorer view:
This tool can be accessed by right-clicking on a containerpage in the **Explorer** mode of [OpenCms][opencms].

1. In the Contextual menu on the containerpage, select **Responsive preview**
![usage-contextual-01]

2. Select the devices you want to open, and click **OK**
![usage-contextual-02]

3. The containerpage is opened on new pages respresenting the devices.
![usage-contextual-03]


### Configuration of available devices
You can configure the list of devices by editing the /system/modules/com.eurelis.opencms.ade.tools/resources/devices.xml file

1. device tag "id" attribute must contains only letters, no spaces or other caracters

2. label tag corresponds to the device name

3. image tag is used to define an image on the vfs representing the device you want to add, don't forget to fill width and height attributes (in pixels)

4. screen tag allow to define the size and position of the iframe where the page will be rendered. width and height attributes corresponds to the size of your device "screen" in points, not pixels. (ie: an iphone 4 has a retina screen of 640px*960px but of 320pt * 480pt). top and left attributes are used to define the position of the "screen" relatively to the background image.


[eurelis]: http://www.eurelis.com "Agitateur de Technologies"
[opencms]: http://www.opencms.org/ "OpenCms"

[usage-ade-01]: /etc/images/usage-ade-01.png "System Information"
[usage-ade-02]: /etc/images/usage-ade-02.png "File Information"
[usage-ade-03]: /etc/images/usage-ade-03.png "Overview"

[usage-contextual-01]: /etc/images/usage-contextual-01.png "Contextual menu"
[usage-contextual-02]: /etc/images/usage-contextual-02.png "Memory"
[usage-contextual-03]: /etc/images/usage-contextual-03.png "Database Pools"


