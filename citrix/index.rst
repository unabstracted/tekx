.. _citrix_lab:

-----------------
Citrix XenDesktop
-----------------

Overview
++++++++

In this exercise you will use the Citrix Studio to deploy non-persistent and persistent virtual desktops based on a gold image. You will install the MCS plugin for Nutanix AHV, configure a XenDesktop site, deploy both Machine Catalogs and Delivery Groups, and test connecting to virtual desktops.

Machine Catalogs are collections of either physical or virtual machines. When using MCS or PVS to provision a Machine Catalog from a gold image, all machines provisioned from that image will share the same VM configuration (vCPUs, Memory, Network) and be part of the same domain. A single gold image can be used for multiple Machine Catalogs to provide different size VMs, VMs across multiple domains, etc.

Delivery Groups are collections of machines from one or more Machine Catalogs. The purpose of a Delivery Group is to specify what users or groups can access the machines. For persistent desktops a permanent relationship is created between the machine and the user account. This assignment can occur either manually during creation of the Delivery Group or be assigned automatically during a user's first logon.

Configuring XenDesktop
++++++++++++++++++++++

Installing MCS Plugin for AHV
.............................

In the **XD** VM console, open ``C:\MCS-Plugin\NutanixAcropolix-MCS-XD7.9_or_later.msi`` and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/12.png

Select **I accept the terms in the License Agreement** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/13.png

Click **Next > Install > Finish**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/16.png

Restart the VM.

Configuring XenDesktop Site
...........................

In the **XD** VM console, open **Citrix Studio** from the Start Menu.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/28.png

After launching Citrix Studio for the first time, you'll be prompted with three different options to configure your newly installed Delivery Controller. Click **Deliver applications and desktops to your users**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/17.png

Select **A fully configured, production-ready Site**, specify a **Site name** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/18.png

A local SQL Express instance will be used for this exercise. In a production environment these databases would be hosted on an external, highly available SQL Server instance. Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/19.png

Select **Use the free 30-day trial** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/20.png

Fill out the following fields to configure the connection to your AHV cluster and click **Next**:

  - **Connection Type** - Nutanix AHV
  - **Connection Address** - *Your Nutanix cluster IP*
  - **User Name** - xd
  - **Password** - nutanix/4u
  - **Connection Name** - *A friendly name for the connection, such as your Nutanix cluster name*
  - **Create virtual machines using** - Studio tools (Machine Creation Services)

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/21.png

.. note::

  The local Prism account **xd** has already been created for you. To function, the Prism service account used for the connection requires the **Cluster Admin** role.

Specify a name for the network and storage resources for the cluster (e.g. the Nutanix cluster name), and select the IPAM enabled **Secondary** network. This will be the DHCP pool used by provisioned desktops and XenApp servers.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/22.png

The workshop will not explore Citrix's AppDNA or App-V Publishing features, so both can be left unselected. Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/23.png

Review selections and click **Finish** to start site creation.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/24.png

Once complete, Studio will indicate that configuration was successful. The process takes approximately 3 minutes.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/25.png

Selecting the **PowerShell** tab will detail all the steps taken by the Site Creation Wizard.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/26.png

Select **Citrix StoreFront > Stores** and review the configuration.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab3/27.png

Creating the Gold Image
+++++++++++++++++++++++

Creating the VM
...............

In **Prism > VM**, click **+ Create VM** and fill out the following fields:

  - **Name** - W10-Gold
  - **Description** - Windows 10 x64 XenDesktop Gold Image
  - **vCPU** - 2
  - **Number of Cores per vCPU** - 1
  - **Memory** - 4

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/1.png

Click **+ Add New Disk** and fill out the following fields:

  - **Type** - DISK
  - **Operation** - Clone from Image Service
  - **Bus Type** - SCSI
  - **Image** - *Windows 10 Disk Image*

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/2.png

Click **Add**.

Click **Add New NIC**.

Select **Secondary** from the **VLAN Name** drop down menu and click **Add**. Click **Save**.

In **Prism > VM > Table**, select the **W10-Gold** VM and click **Power on**.

Once the VM has started, click **Launch Console**.

.. note:: You may need to allow pop-ups in your browser for the VM console to appear.

Complete the Microsoft Out of Box Experience (OOBE) wizard:

  - Select Country, App language, and Keyboard layout, click **Next**.

  - Review the licensing agreement, click **I Accept**.

  - Click **Customize**.

  - Set all features to **Off** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/3.png

  - Set all features to **Off** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/4.png

  - Set all features to **Off** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/5.png

  - Select **Join a local Active Directory domain** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/6.png

  - Create an account, **LocalUser**, and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/7.png

  - Click **Not Now** to disable Cortana.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/8.png

  - Click **Next**.

Log in to **W10-Gold** as **LocalUser**.

Installing Applications
.......................

In the **W10-Gold** VM console, install a few applications such as Google Chrome, text editors, etc.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/10.png

Disable Windows Updates for your gold image by opening **Control Panel > Administrative Tools > Services**.

Right-click **Windows Update > Properties**.

Select **Disabled** from the **Startup type** down down menu.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/11.png

Click **Stop**.

Click **OK**.

Installing Virtual Delivery Agent
.................................

In **Prism > VM > Table**, select the **W10-Gold** VM and click **Update**.

Under **Disks > CD-ROM**, click :fa:`pencil`.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/12.png

Fill out the following fields and click **Update**:

  - **Operation** - Clone from Image Service
  - **Image** - *XenDesktop installation .iso*

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/13.png

Click **Save**.

In the **W10-Gold** VM console, open the XenDesktop Installer and click the **Start** button to the right of **XenDesktop**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/14.png

Click **Virtual Delivery Agent for Windows Desktop OS**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/15.png

Select **Create a Master Image** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/16.png

Select **No, install VDA in standard mode** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/17.png

Select **Citrix Receiver** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/18.png

Select all **Additional Components** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/19.png

Select **Let Machine Creation Services do it automatically** from the drop down menu and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/20.png

Select **Optimize performance** (`CTX125874 <https://support.citrix.com/article/CTX125874>`_) and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/21.png

Select **Automatically** to allow the installer to configure the Windows Firewall service to allow traffic for selected XenDesktop components.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/22.png

Review selections and click **Install**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/23.png

Select **I do not want to participate in Call Home** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/24.png

Click **Finish** and wait for the VM to restart.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/25.png

In **Prism > VM > Table**, select the **W10-Gold** VM and click **Update**.

Under **Disks > CD-ROM**, click :fa:`eject` to unmount the XenDesktop installation .iso.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/26.png

Click **Save**.

Creating Gold Image Snapshot
............................

In **Prism > VM > Table**, select the **W10-Gold** VM and click **Power Off Actions**.

Select **Guest shutdown** and click **Submit** to gracefully shut down the VM.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab4/27.png

Once **W10-Gold** is powered off, select the VM and click **Take Snapshot**

Specify a **Name** for the snapshot (e.g. "W10-Gold vYYYYMMDD-X - Post-VDA 7.15 Install") and click **Submit**.

Delivering Non-Persistent Desktops
++++++++++++++++++++++++++++++++++

Creating the Machine Catalog
............................

In the **XD** VM console, open **Citrix Studio**.

Right-click **Machine Catalogs > Create Machine Catalog**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/1.png

Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/2.png

Select **Desktop OS** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/3.png

Select **Machines that are power managed** and **Citrix Machine Creation Services**. Click **Next**

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/4.png

Select **Random** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/5.png

Select your Nutanix storage container and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/6.png

Select your **W10-Gold** snapshot and click **Next**. These snapshots will continue to exist as long as there are provisioned virtual desktops utilizing them.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/7.png

Fill out the following fields and click **Next**:

  - **How many virtual machines do you want to create** - 4
  - **Total memory (MB) on each machine** - 4096
  - **Virtual CPUs** - 2
  - **Cores per vCPU** - 1

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/8.png

Select **Create new Active Directory accounts**. Under the **POCLAB.local** domain, select the **Default OU** OU. Specify **W10NP-###** as the **Account naming scheme**. Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/ts18/citrix/lab6/9b.png

.. note::

  As part of Machine Catalog creation, the Delivery Controller will create all of the machine accounts in AD. This is necessary as the cloned VMs themselves do not go through a traditional Sysprep and domain join. Instead, the Citrix Machine Identity Service (installed as part of the VDA), manages the VM's "uniqueness," providing a more rapid means of provisioning large pools of desktop resources.

Specify a friendly **Machine Catalog name** and click **Finish**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/10.png

.. note::

  MCS will now create a clone from the snapshot of **W10-Gold**. When using MCS, the Delivery Controller copies the gold image to each configured datastore in the Host Connection. In a traditional SAN scenario (or using MCS with local storage) this can be a time consuming event, as the Machine Catalog may be spread over several volumes to achieve the desired performance. In a Nutanix cluster you would typically have a single datastore (Storage Container) servicing all desktops, simplifying the configuration and improving the time to provision a Machine Catalog.

  Observe the Preparation clone booting in **Prism** briefly before shutting down and being removed automatically. Attached to this VM is a separate disk that walks through multiple steps to ensure the VM is ready to be used for the Machine Catalog.

  The preparation stage will enable DHCP, perform a Windows licensing "rearm" to ensure it is reported to the Microsoft KMS server as a unique VM, and similarly perform an Office licensing "rearm". Studio will automatically create a snapshot of the VM in this state once it has completed preparation and shut down.

  MCS will now create the VMs for our Machine Catalog. This involves the creation of the VMs and the cloned base vDisk, as well as the creation of a small (16MB maximum) vDisks called the Identity (ID) disks. The ID disk contains information unique to each VM that provides its hostname and Active Directory Machine Account Password. This information is ingested automatically by the Citrix Machine Identity Service and allows the VM to appear as unique and allowing it to join the domain.

Observe the Machine Catalog creation process in **Prism**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/11.png

Upon completion, view the details of the Machine Catalog in **Citrix Studio**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/12.png

.. note::

  The clones exist in **Prism** but are not powered on. Select one of the VMs and observe both the OS vDisk and ID disk attached to the VM on the **Virtual Disks** tab below the VMs table. Similar to the persistent Machine Catalog, each VM appears to have its own unique read/write copy of the gold image. With VMs in a Machine Catalog spanning several Nutanix nodes, data locality for VM reads is provided inherently by the Unified Cache.

  This MCS implementation is unique to AHV. For non-persistent Machine Catalogs, other hypervisors link to the base golden image for reads and apply writes to a separate disk, referred to as a differencing disk. In these scenarios, Nutanix Shadow Clones are used to provide data locality for VM reads. Shadow Clones is a feature that automatically provides distributed caching for multi-reader vDisks.

  To learn about MCS provisioning in greater detail, see the following articles:

  - `Citrix MCS for AHV: Under the hood <http://blog.myvirtualvision.com/2016/01/14/citrix-mcs-for-ahv-under-the-hood/>`_
  - `Citrix MCS and PVS on Nutanix: Enhancing XenDesktop VM Provisioning with Nutanix  <http://next.nutanix.com/t5/Nutanix-Connect-Blog/Citrix-MCS-and-PVS-on-Nutanix-Enhancing-XenDesktop-VM/ba-p/3489>`_

  To learn more about how Nutanix implements Shadow Clones, see the `Shadow Clones <http://nutanixbible.com/#anchor-shadow-clones-79>`_ section of the Nutanix Bible.

Creating the Delivery Group
...........................

Right-click **Delivery Groups > Create Delivery Group**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/13.png

Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/14.png

Select your **Non-Persistent** Machine Catalog and specify the maximum number of VMs available for the Delivery Group.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/15.png

Select **Restrict** and click **Add**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/16.png

Specify **SSP Basic Users** in the **Object names** field and click **OK > Next**.

  .. figure:: http://s3.nutanixworkshops.com/ts18/citrix/lab6/17b.png

Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/19.png

Click **Add** and fill out the following fields:

  - **Display name** - Pooled Windows 10 Desktop
  - **Description** - Non-Persistent 2vCPU/4GB RAM Windows 10 Virtual Desktop
  - Select **Allow everyone with access to this Delivery Group**
  - Select **Enable desktop assignment rule**

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/20.png

Click **OK > Next**

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/21.png

Specify a friendly name for the Delivery Group and click **Finish**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/22.png

Following creation of the pool, observe in **Prism** that 1 of the **W10P-###** VMs been has powered on.

In **Citrix Studio**, right-click your Delivery Group and click **Edit Delivery Group**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/23.png

Select **Power Management** from the left hand menu.

Click and drag the number of machines powered on during peak hours from 1 to 4. The peak hours period can optionally be modified by clicking and dragging to either the left or the right.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/24.png

.. note:: For more granular control of registered, powered on VMs you can click the Edit link and provide the number or percentage of VMs you want available for every hour of the day. You can also configure the disconnected VM policy to free up disconnected VMs after a configurable time out period, returning the desktop to the pool for another user.

After increasing the number of powered on virtual machines, validate the **W10NP-###** VMs are powered on in **Prism**.

In **Citrix Studio**, right-click your Delivery Group and click **View Machines**. Alternatively you can double-click on the name of the Delivery Group.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/26.png

Observe the powered on desktop now appears as **Registered** with the Delivery Controller, indicating the desktop is ready for user connection.

Connecting to the Desktop
.........................

Open \http://<*XD-VM-IP*>/Citrix/StoreWeb in a browser on the same L3 LAN as your XD VM.

If prompted, click **Detect Receiver**

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/27.png

If Citrix Receiver is not installed, select **I Agree with the Citrix license agreement** and click **Download**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/28.png

Launch the **CitrixReceiverWeb.exe** installer and complete the installation wizard using default settings.

.. note:: Do not enable single sign-on during Citrix Receiver installation.

Refresh your browser or click the **Detect again** link.

If prompted, select **Always open these types of links in the associated app** and click **Open Citrix Receiver Launcher**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/29.png

.. note:: This may appear slightly different depending on your browser (Chrome shown). You want to allow your browser to open the Citrix Receiver application.

Refresh your browser and log in to StoreFront as **POCLAB\\basicuser01**

.. note:: If you're still being prompted to detect Citrix Receiver, click **Already installed** to proceed to the login page.

Select the **Desktops** tab and observe your **Pooled Windows 10 Desktop** is available. Click the **Pooled** desktop to launch the session.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab6/26.png

After the virtual desktop has completed logging in, experiment by changing application settings, installing applications, restarting the VM, and logging in again.

Delivering Persistent Desktops
++++++++++++++++++++++++++++++

Creating the Machine Catalog
............................

In the **XD** VM console, open **Citrix Studio**.

Right-click **Machine Catalogs > Create Machine Catalog**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/1.png

Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/2.png

Select **Desktop OS** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/3.png

Select **Machines that are power managed** and **Citrix Machine Creation Services**. Click **Next**

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/4.png

Select **Static** and **Yes, create a dedicated virtual machine**. Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/5.png

Select your Nutanix storage container and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/6.png

Select your **W10-Gold** snapshot and click **Next**. Note the XDSNAP* snapshot listed from the Preparation VM created by the non-persistent Machine Catalog previously.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/7.png

Fill out the following fields and click **Next**:

  - **How many virtual machines do you want to create** - 3
  - **Total memory (MB) on each machine** - 4096
  - **Virtual CPUs** - 4
  - **Cores per vCPU** - 1

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/8.png

Select **Create new Active Directory accounts**. Under the **POCLAB.local** domain, select the **Default OU** OU. Specify *W10P-###* as the **Account naming scheme**. Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/ts18/citrix/lab5/9b.png

Specify a friendly **Machine Catalog name** and click **Finish**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/10.png

Upon completion, view the details of the Machine Catalog in **Citrix Studio**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/15.png

Creating the Delivery Group
...........................

Right-click **Delivery Groups > Create Delivery Group**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/16.png

Click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/17.png

Select your **Persistent** Machine Catalog and specify the maximum number of VMs available for the Delivery Group.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/18.png

Select **Desktops** and click **Next**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/19.png

Select **Restrict** and click **Add**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/20.png

Specify **SSP Developers** in the **Object names** field and click **OK > Next**.

  .. figure:: http://s3.nutanixworkshops.com/ts18/citrix/lab5/21b.png

Click **Add** and fill out the following fields:

  - **Display name** - Personal Windows 10 Desktop
  - **Description** - Persistent 4vCPU/4GB RAM Windows 10 Virtual Desktop
  - Select **Allow everyone with access to this Delivery Group**
  - **Maximum desktops per user** - 1
  - Select **Enable desktop assignment rule**

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/23.png

Click **OK > Next**

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/24.png

Specify a friendly name for the Delivery Group and click **Finish**.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/25.png

Following creation of the pool, observe in **Prism** that 1 of the **W10P-###** VMs been has powered on.

Connecting to the Desktop
..........................

Open \http://<*XD-VM-IP*>/Citrix/StoreWeb in a browser on the same L3 LAN as your XD VM.

Log in as **POCLAB\devuser01**.

Select the **Desktops** tab and click your **Personal Windows 10 Desktop** to launch the session.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/31.png

.. note:: Depending on your browser you may have to click on the downloaded .ica file if Receiver does not open automatically. You may also be able to instruct the browser to always open .ica files.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/32.png

After the virtual desktop has completed logging in, experiment by changing application settings, installing applications, restarting the VM, and logging in again.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/33.png

In **Citrix Studio**, observe the changes to VM details. As a user logs in they are statically assigned a desktop and another desktop will power on and register with the Delivery Controller, waiting for the next user.

  .. figure:: http://s3.nutanixworkshops.com/vdi_ahv/lab5/34.png

Conclusions
+++++++++++

- When using MCS for provisioning, the master VM does not require Sysprep or being domain joined.

- Using MCS helps simplify the gold image by not having to manually specify (or depend on Active Directory to specify) what XenDesktop Delivery Controller(s) with which the image should attempt to register. This allows more flexibility in having a single gold image support multiple environments without external dependencies.

- With MCS, a single gold image can be used for both persistent and non-persistent Machine Catalogs.

- Despite being based off of a single, shared, gold image, all the VMs in the Machine Catalog continue to benefit from data locality (reduced latency for reads and reduced network congestion). For non-AHV hypervisors, the same benefit is realized through Shadow Clones.

- Intelligent cloning avoids significant storage overhead for deploying persistent virtual desktops. If mixing persistent and non-persisdent desktops within the same cluster, best practice would be to leverage a storage container with deduplication enabled for persistent desktops and a separate storage container with deduplication disabled for non-persistent desktops. Having the flexibility to pair workloads with appropriate storage efficiency technologies can imrpvoe density and reduce waste.

- Citrix MCS allows for end to end provisioning and entitlement management in a single console.

- Non-persistent virtual desktops provide a consistent experience as the user is getting a "fresh" VM upon every login. This approach can provide significant operation savings over traditional software patching, but will likely require other tools to provide needed customization on top of the non-persistent desktop. Use cases such as kiosks or educational labs can be a great fit for "vanilla" non-persistent desktops.

- Persistent virtual desktops provide a traditional desktop-like experience where a user can have full control over their desktop experience. This approach may be necessary for a small subset of users but typically isn't desirable at scale due to the continued dependence on legacy software patching tools.
