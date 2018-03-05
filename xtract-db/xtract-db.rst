-------------------
Xtract for DBs
-------------------

Overview
++++++++

In this exercise you will deploy, and use the Xtract tool to migrate a Database.

Deploy Xtract for DBs
+++++++++++++++++

In **Prism > VM**, click **VM**, then click **Table**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb01.png

Click **+ Create VM**

Fill out the following fields and click **Save**:

- **Name** - Xtract-DB
- **Description** - Xtract for DBs
- **VCPU(S)** - 2
- **Cores** - 1
- **Memory** - 4GiB
- **Disks** - **+ Add New Disk**
- **Disk Image (From Image Service)** - Xtract-DB
- **Network** - Primary
- **IP Address** - 10.21.XX.43

Now Power on the **Xtract-DB** VM

When it completes it open a browser window to the **Xtract for DBs** Dashboard, https://10.21.XX.43

Login with the following credentials:

- **Username** - nutanix
- **Password** - nutanix/4u

 Fill in **Name**, **Comapny**, and **Job Title**, then **Accept** the EULA

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb02.png

Click **OK** on the **Nutanix Customer Experience Program** pop-up

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb03.png

Create Project & Migrate Database with Xtract for DBs
+++++++++++++

In this portion of the lab we will create a new project in **Xtract-DB**, and migrate a MS SQL Server database.

Create New Migration Project
.................

Enter project name, and click **Create New Project**:

**Project Name** - Website DB

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb04.png

Fill out the following fields and click **Begin Scan**:

- **HOSTNAME (OR IP ADDRESS)** - IP of the Windows 2012 Server MS SQL lives on
- **Instance Name (Or Port)** - 1433
- **Username** - administrator
- **Password** - nutanix/4u
- **Scan Name** - Parts DB

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb05.png

If/When the scan fails, you will need uplift the permissions of the scan User

Click the **Actions** dropdown, and select **Elevate Scan User Privileges**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb06.png

Fill out the following fields and click **Re-Scan**:

- **Username** - sa
- **Password** - nutanix/4u

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb07.png

After the scan completes successfully, you will see the overview page

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb08.png

Generate Nutanix Best Practices Design
.................

Click **Generate Design**

Click the :fa:`pencil` to change the Design name

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb09.png

Fill out the following fields and click **Save**:

- **Custom Design Name** - MSSQLSERVER-UPTICK-WebsiteDB

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb10.png

Click **MSSQLSERVER-UPTICK-WebsiteDB**, and you will see the design Details

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb11.png

Click **< Back** to go back to the **Design Templates** view

Prepare **Xtract Master** VM
.................

In **Prism > VM**, click ** VM**, then click **Table**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb01.png

Click **+ Create VM**

Fill out the following fields and click **Save**:

- **Name** - Xtract-DB-2012r2-Master
- **Description** - Xtract-DB win2012r2 Master VM
- **VCPU(S)** - 2
- **Cores** - 1
- **Memory** - 8GiB
- **Disks** - **+ Add New Disk**
- **Disk Image (From Image Service)** - Windows2012
- **Network** - Primary

Now Power on the **Xtract-DB-2012r2-Master** VM

Launch Console session to **Xtract-DB-2012r2-Master** VM

Set password to **nutanix/4u**

Install Nutanix Guest Tools, and Restart

Log in and run Windows Update to get the latest updates, and reboot

shutdown the VM

Makes sure the **MS SQL Server 2016 ISO** is in **Image Service**

.. Note:: For DHCP based Target VM, use non SysPrepped Template. For Static IP based Target VM, put template in a SysPrepped state.

Deploy new Database VM
.................

In Xtract for DBs, click **Proceed to Deploy**

Click **...** under **Actions**, and select **Deploy**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb12.png

Ensure you have all the Pre-Requisites, and click **Proceed to Deploy**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb13.png

 Fill out the following fields for **Prism Credentials**, and click **Connect**:

 - **IP Address** - 10.21.XX.37
 - **Port** - 9440
 - **Username** - admin
 - **Password** - Prism Password

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb14.png

After Hypervisor connection is made, click **Configure VMs**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb15.png

Fill out the following fields and click **Next**:

- **Name** - MSSQL
- **Container Name** - Databases
- **Retain clone of master VM on the Container** - Unchecked
- **Network** - Primary
- **DHCP** - Selected

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb16.png

Fill out the following fields and click **Next**:

- **Target VM Master Image** - Xtract-DB-2012r2-Master
- **Target VM Password** - nutanix/4u

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb17.png

Fill out the following fields and click **Review**:

- **SQL Server Image** - MS SQL Server 2016 ISO
- **Service Pack (Optional)** - \\\\POCFS\\ISO\\Microsoft\\SQL\\SQLServer2016-KB3210089-x64.exe

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb18.png

Ensure everything is correct, and click **Deploy**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb19.png

You will see the status of deployment

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb20.png

Once complete, click **Proceed to Migrate**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb21.png

Migrate Database
.................

Click **Create a Migration Plan**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb22.png

Click the :fa:`pencil` to update the Plane names

- **Plane Name** - UptickDB Plan

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb24.png

Click the :fa:`plus-circle` to select **MSSQLSERVER\MSSQLSERVER**, and click **Next**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb23.png

If\When it asks you for a File Share add the following, and click **Save and Start the Plan**

- **Server File Path** - \\\\10.21.64.53\\xdb

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb25.png

Click **Proceed** to launch the **Migration**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb26.png

You may see a pop-up stating that the versions do not match, and it is proceeding (will use the service pack you uploaded)

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb27.png

 When you see the status change to **Ready for Cutover**, Click the **Action** dropdown and click **Cutover Databases**

 .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb28.png

 Click **Proceed** to launch the **Cutover**

 .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb29.png

 You may see some pop-up messages like these, go ahead and close them.

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb30.png

 When you see the status change to **Ready for Re-Balancing**, Click the **Action** dropdown and click **Initiate Post Cutover Processing**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb31.png

Check **Re-Balance Data in Databases**, and click **Start**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb32.png

 When you see the status change to **Ready for Final Processing**, Click the **Action** dropdown and click **Initiate Data Cleanup**

 .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb33.png

 Click **Proceed** to launch the **Cleanup**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb34.png

When everything is done, you will see status of **Completed**

 .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-db/xtractdb35.png

Conclusions
+++++++++++

- Nutanix provides tools for migrating databases

- Mirating databases is done in a very easy Nutanix way
