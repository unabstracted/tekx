-----------------------
Comtrade HYCU
-----------------------

Overview
++++++++
Welcome to the Nutanix lab for HYCU!  In this lab you will go through installing HYCU, configuring HYCU, backing up, and restoring different datasets.  The goal of this lab is for you to have a better understanding of how HYCU works in order to better pitch and demo this with your clients.

Pre-requisites
++++++++++++++
- Nutanix cluster running AHV.
- Prism Cluster URL, login with admin privileges and password.
- Image of HYCU uploaded to Prism Image configuration.
- Windows and/or Linux VMs.
- Administrator Login credentials for your Windows VMs.
- Windows Microsoft SQL Server.
- IPv4 address and Hostname for HYCU Controller.
- Subnet mask, Default gateway, DNS Server and Search domain for HYCU controller.

EXERCISE 1 - INITIAL DEPLOYMENT
+++++++++++++++++++++++++++++++

Objective: Create a HYCU backup controller VM.

Prerequisites:	HYCU VM available in Prism Image Configurator. 

1. Start by adding a new virtual machine in Prism by clicking “Create VM”.	
  
2. Configure the VM, name and compute details. 	
  
  - 2x vCPUs	
  - 2x CORES	
  - 4x GB Memory	
  - Attach HYCU disk image to the new VM 	
  - Type = DISK	
  - Operation = Clone from Image service	
  - BUS Type = SCSI	
  - Image name = <name of HYCU image downloaded>	
  - Add network card to the HYCU VM	
  - VLAN ID = <select from pull down> <Recommendation: use default>	
  - Power the just created HYCU VM on 
  
.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image1.png  
.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image2.png  
.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image3.png 

EXERCISE 2 - NETWORK AND CONTROLLER SETUP
+++++++++++++++++++++++++++++++++++++++++

Objective: Network setup for HYCU backup controller.
  
Prerequisites: HYCU VM is created, and powered ON.

1. In Prism, Select the HYCU VM from VMs list and click on “Launch console”.
	
2. When the console launches, you will be greeted with the initial Network setup screen in order to setup the HYCU 		static network.

3. parameters:
	
- Hostname = <Part of pre-requisites>	
- IPv4 address = <Part of pre-requisites>	
- Subnet mask = <Part of pre-requisites>	
- Default gateway = <Part of pre-requisites>	
- DNS server = <Part of pre-requisites>	
- Search domain = <Part of pre-requisites>	
- Fill and confirm with “Enter“ button press. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image5.png
	
 .. Note :: You can switch between lines by pressing the “Tab“ button.
	
4. Once configured, and confirmed, wait a minute for the console to save its settings, and initialize completely.
	
 .. note :: Write down the URL you will use to access the HYCU UI**. 	
 
.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image7.png


EXERCISE 3 - ADD CLUSTER
++++++++++++++++++++++++
  
Objective: Add the Nutanix Cluster to HYCU.
  
Prerequisites: HYCU successfully installed, and running.

1. Login to the HYCU Web Interface by navigating to https://your_configured_ip_address:8443
   And you will be greeted with the Hycu login screen. 
   
   .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image8.png	

2. Default login credentials to HYCU are:   

- Username: admin	
- Password: admin   
	
 .. Note :: It is recommended to change these as soon as you log in for the first time.
 
3. After your first successful login, start by adding the Nutanix cluster to HYCU. From the top right corner, 	 		Administration icon, select Add Nutanix Clusters.

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image9.png
	
4. Fill out the fields in the “Add Nutanix Cluster” form, and confirm with “Save” button. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image10.png

- Cluster Prism Element URL = <collected during pre-requisites>	
- User = <collected during pre-requisites>	
- Password = <collected during pre-requisites>

5. Upon successful entry, you should see your cluster added. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image11.png

6. Close the Windows by clicking the “Close button” and make sure your VM’s have been successfully discovered by HYCU.


EXERCISE 4 - ADD TARGET
+++++++++++++++++++++++

Objective: Add a target to store backups and restore points. 

 .. note:: This will cover all types of target's, you will only need to create the necessary type.

Prerequisites:	HYCU VM Configured and Nutanix Cluster Added.

1. Login to the HYCU UI.
	
2. Select “Targets” from the left-hand pane.
	
3. Click “+ New" button in the top right corner. 

- Target type: NFS

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image12.png
	
 .. Note ::Even though Nutanix storage container's can be used as an NFS target, HYCU recommend's using Volume Groups as 	an ISCSI target.
 
4. Create a new container from Prism with at least 100GB of storage. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image13.png
	
5. Expose the container as a HYCU NFS target. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image14.png
	
6. Make sure that the target was successfully added. 

- Target type: SMB

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image15.png

7. Setup a shared directory on one of the Windows machines.
	
8. Expose that shared directory as a HYCU SMB target. 

- Target type: iSCSI

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image16.png

 .. Note :: Nutanix volume group's can be used as an iSCSI target.
 
9. Create a new Nutanix volume group from Prism with at least 100GB of storage. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image17.png
	
10. Register the new Client to your Volume Group by using HYCU IP address or ISCSI Initiator Name. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image18.png
	
11. Expose the Volume Group as a HYCU iSCSI target. IQN of the iSCSI storage device is located in Nutanix 		Volume Group properties - Target IQN Prefix.

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image19.png
.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image20.png

 .. Note :: To get the ISCSI Initiator Name, in HYCU from the top right corner, Administration icon, select iSCSI Initiator.
  
  .. Note :: The target will be used to store backups made by HYCU, and it will also be where restores will be carried out from. Supported targets are:
  
	- SMB	
	- NFS	
	- iSCSI 	
	- Amazon S3 and S3 Compatible Storage solutions	
	- Azure


EXERCISE 5 - VM BACKUP
++++++++++++++++++++++

Objective: To perform a successful VM backup.

Prerequisites:	HYCU VM Configured, Nutanix Cluster Added, Backup Target Added.

1. Login to the HYCU UI.
	
2. Click on “Virtual Machines“ on the left-hand pane.
	
3. HYCU synchronizes machines at regular intervals, but you can also trigger synchronization manually by clicking the 	    	    Synchronize button in the top left corner.

4. Two types of backups are available.
	
- VM backup	
- Application Aware backup

5. For this exercise, we will focus on a full VM backup. Highlight the VM machine you want to backup - As shown in the below picture, click on “Policies” in the top right, and select one of the policies. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image21.png
.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image22.png
	
6. As soon as the policy gets assigned, your first full backup will start, and you can track its status by clicking on 		“Jobs" in the main left-hand pane. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image23.png
	
7. Once the backup completes, if you would like to manually trigger an incremental backup, you can start it by clicking on the 		“Backup” button on the top. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image24.png
	
8. By hovering your mouse over the backup status column, you can see which type of backup was done, and all of the 		important details of that backup. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image25.png


	**Congratulations, you've just completed your first HYCU backup!!!**


EXERCISE 6 - VM RESTORE
+++++++++++++++++++++++

Objective: Restore VM and/or file system. 

Prerequisites:	HYCU VM Configured, Nutanix Cluster Added, Backup Target Added and you have completed at least one full backup.

1. Login to the HYCU UI.
	
2. Click on “Virtual Machines” in the left hand pane.
	
3. Find the VM you need to restore either by scrolling through the available choices, or by filtering it by name (top right     	  corner, just below the Owner button).
	
4. Highlight the VM you would like to restore from. Now all of the restore points related to that VM will appear. Select the restore point you desire.
	
5. Now click on the “Restore VM” in the menu that appears above.  

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image26.png
	
6. You can restore the VM to the original location with the same name as the original VM, to a new location, or with a new 		name.
	
7. Let’s restore it to a new container. Deselect the “Restore with original settings” option.
	
8. Select a container where the VM will be restored to.
	
9. Specify a new VM name.
	
10. Deselect “POWER VIRTUAL MACHINE ON” option and trigger a Restore.
	
	**Congratulation's your restore is now underway!!  Make sure to monitor the progress.**


EXERCISE 7 - FILE / FOLDER LEVEL RESTORE
++++++++++++++++++++++++++++++++++++++++

Objective: Perform a single file restore.

Prerequisites:	HYCU VM Configured, Nutanix Cluster Added, Backup Target Added, and you have completed at least one full backup.

 .. Note :: Restore's are available even from the file system level, and it’s extremely useful when you have to restore only a few files/folders from a VM. That way, there is no need to restore the entire VM, but rather just those files/folders. Follow the below steps in order to perform a granular single file restore.
 
1. Login to the HYCU UI.
	
2. Click on “Virtual Machines” in the left hand pane.
	
3. Find the VM you would like to restore the file or folder from by scrolling through available choices, or by filtering it by     	  name (top right corner, just below the Owner button).
	
4. Select the VM.
	
5. To restore files back to the original VM you will need to provide VM credentials. 
	
6. To define and assign credentials for the VM click on “Credentials" in the top right corner. Configure administrator credentials. 	

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image27.png	

- Username = <collected as part of pre-requisites>	
- Password = <collected as part of pre-requisites>
	
7. Select your desired Virtual machine, click “Credentials” and assign the created credential group to the Virtual machine.
	
 .. Note :: Notice VM discovery will be marked green if credentials were properly verified and HYCU has access to the 		system.
	
8. Select the VM again, and then select the latest restore point, and click on “Restore Files”. By default, you can recover files to any shared location.

9. Click on the “Restore files” button again. Simply check the boxes next to folders/files needed for restore, and confirm with 	  next. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image28.png	

10. Select restore to Original or Alternate location, fill out the required information and restore the files.
	
.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image29.png



EXERCISE 8 – APPLICATION DISCOVERY & BACKUP / RESTORE 
+++++++++++++++++++++++++++++++++++++++++++++++++++++
  
Objective: Perform auto discovery of a SQL Server database and perform a backup & restore.
  
Prerequisites: SQL Server with a single SQL instance, Credentials for VM access, and Credentials for SQL database access (sysadmin permission).

 .. Note ::HYCU will be able to auto discover applications running inside a VM, and offer application level backup / restore. With this application awareness capability, you can now focus on protecting your applications. Follow the below steps in order to perform an application aware backup / restore.
 
1. Select Virtual Machines in the main left menu. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image30.png	
	
2. Click on Credentials on the right-hand side.
	
3. Create new credential group, make sure to use credentials with VM & APP access. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image31.png	
	
4. Find the VM with SQL server running on it.
	
5. Highlight it with a left mouse click, then click on Credentials.
	
6. Assign the proper credentials to that VM. The discovery process will then start automatically.
	
7. Once discovery has completed click on Applications in the main left side menu.
	
8. Assign your desired Policy to the discovered SQL application, and the backup process will start within 5 minutes.

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image32.png	
	
9. Start another backup manually by clicking on the Backup on top, and notice it is an incremental backup.
	
10. On the same screen, when you click on the application, you will see all of the application restore point's that are   	 	 available.
	
11. You can select any of these restore point's and select the “Restore” icon to perform a granular recovery of the database.
	
12. Select either individual database, multiple databases, or full SQL instance. 

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/hycu/images/image33.png

	
13. Notice that HYCU will offer Restore capabilities to a particular point in time for Databases which are configured in full recovery mode.
	

Conclusions
+++++++++++

Thanks for completing the HYCU lab. We hope that this lab was insightful into how HYCU integrates with Nutanix. After going through this lab you should now be able to setup HYCU, and also perform backups / restores. Please use this lab with your clients, and demo just how easy Data Protection can be using HYCU on Nutanix!
