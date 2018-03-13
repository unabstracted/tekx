***************************
Calm Blueprint (MSSQL-2014)
***************************

.. note:: IMPORTANT! This blueprint is for Lab purposes only. Do not put this into production without modifying it to meet your organizations requirements, Nutanix Best Practices, and Microsoft SQL Best Practices.

Overview:
*********

.. note:: Estimated time to complete: **20 MINUTES**

In this lab participants will walk through importing and deploying an MS Windows Server 2012 R2, and an instance of MS SQL Database - 2014.


Getting Engaged with the Product Team
=====================================
- **Slack** - #calm
- **Product Manager** - Jasnoor Gill, jasnoor.gill@nutanix.com
- **Product Marketing Manager** - Gil Haberman, gil.haberman@nutanix.com
- **Technical Marketing Engineer** - Chris Brown, christopher.brown@nutanix.com
- **Field Specialists** - Mark Lavi, mark.lavi@nutanix.com; Andy Schmid, andy.schmid@nutanix.com

Prerequisites:
**************
Certain prerequisites must be met before installation will succeed. The following must be configured:

- Karan Guest VM Configured and Installed: karan-setup_
- MSSQL installation requires CredSSP to be enabled on Karan host
- Account running karan service must have the following privileges

.. code-block:: bash
  
  (SE_ASSIGNPRIMARYTOKEN_NAME, SE_INCREASE_QUOTA_NAME)


Blueprint:
***********

Download the MSSQL Blueprint by clikcing the link provided below:

:download:`mssql2014.json <./blueprints/windowsMSSQL2014.json>`

From Apps (NuCalm) within Prism Central, navigate to the Blueprint Workspace by clicking (|image1|) icon located on the left tool ribbon.  This will open the Blueprint Workspace where self-authored blueprints are staged for editing, publishing, and/or launching as Applications.  When the Blueprint grid appears, click the **Upload Blueprint** button located along the top of the Blueprint grid.

.. figure:: https://s3.amazonaws.com//s3.nutanixworkshops.com/calm/lab3/image2.png

Navigate to the blueprint file (i.e. *Troubleshooting.json*) recently downloaded and select it by clicking on the file.

A modal dialog will appear prompting for a name and project when saving. Complete the fileds as shown below and click **upload**. This will save the blueprint to the workspace.

- **Name:** Calm Workshop Blueprint Debug
- **Project:** Calm

.. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/calm/lab3/image3.png

Assign Credential
=================

Since Blureprints are exported as clear text, they do not retain credential information that could potentially be used maliciously.  You'll be required to set the **Credentials**.

Configure Blueprint Variables
=============================

The following Blueprint variables should be configured before use: 

On the SQL Service, set the variable "install_location" to external to download ISO from internet, or internal to download from a file share. If set to external, no further variables need to be modified.

If set to internal, you will need to fill out the following variables:

- file_share_user
- file_share_password
- file_server_ip
- file_share_name
- sql_iso_path (include path and iso file)
- mapped_drive


Enable CredSSP
==============
To Enable CredSSP on the Karan host, please follow steps below:

1. On the Karan Host run the following command to enable CredSSP as a client role and allow Karan host to Delegate credentials to all computers ( Wild card mask "*")
 Enable-WSManCredSSP -Role Client -DelegateComputer *
2. From command prompt window run “gpedit.msc”
3. In the group policy editor window Goto Computer-configuration -> administrative templates -> system ->credential delegation
4. Double click on “Allow Delgating Fresh Credentials with NTLM-only server authentication”
5. Select Enable radio button
6. Click on the show button
7. In the value field add  “WSMAN/*”. This allows delegate fresh credentials to WSMAN running in any remote computer


Privileges:
============
To assign the correct privileges, please follow the steps below:

1. Idenitfy the user account that the Karan service is running as 
2. From the Start menu, point to Administrative Tools, and then click Local Security Policy.
3. In the Local Security Settings dialog box, double-click Local Policies, and then double-click User Rights Assignment.
4. In the details pane, double-click Adjust memory quotas for a process. This is the SE_INCREASE_QUOTA_NAME user right.
5. Click Add User or Group, and, in the Enter the object names to select box, type the user or group name to which you want to assign the user right, and then click OK.
6. Click OK again, and then, in the details pane, double-click Replace a process level token. This is the SE_ASSIGNPRIMARYTOKEN_NAME user right.
7. Click Add User or Group, and, in the Enter the object names to select box, type the user or group name to which you want to assign the user right, and then click OK.
8. Restart the Karan service.

Launch Blueprint
================
Once the blueprint has been successfully updated and saved, click the (|image5|) button to lanuch the Blueprint.  Name the application with *Calm Workshop Troubleshooting*.

.. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/calm/lab3/image6.png

.. note:: Please note that an XML script to auto join the MSSQL VM to the domain is included in this lab. This would usually be an additional step for deployment.


Click **Create** to launch the application.

Once the application has been launched, the Application Management Dialog will appear showing the state of the Application.  Click the *Audit* button in the tool-bar located along the top of the Application Management Dialog to monitor or audit the provisioning progress of the application.


Takeaways
***********
- Downloaded and Imported an existing blueprint ro the *Blueprint Workspace*.
- Learned to se variables changing blueprint behavior to source imnages and define credentials.
- Learned how to setup and configure a Karan proxy server for exeucting powershell to provision windows servers.



.. _karan-setup: ../karan/karan_sa_setup.html

.. |image1| image:: https://s3.amazonaws.com/s3.nutanixworkshops.com/calm/lab3/image1.png
.. |image5| image:: https://s3.amazonaws.com/s3.nutanixworkshops.com/calm/lab3/image5.png
