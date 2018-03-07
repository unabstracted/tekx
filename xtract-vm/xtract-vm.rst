-------------------
Xtract for VMs
-------------------

Overview
++++++++

.. note::

  This lab should be completed **AFTER** the :ref:`ssp` lab.

  Estimated time to complete: **1 HOUR**

In this exercise you will deploy, and use the Xtract tools to migrate a VM.

Getting Engaged with the Product Team
.....................................

- **Slack** - #xtract
- **Product Manager** - Jeremy Launier, jeremy.launier@nutanix.com
- **Product Marketing Manager** - Marc Trouard-Riolle, marc.trouardriolle@nutanix.com
- **Technical Marketing Engineer** - Mike McGhee, michael.mcghee@nutanix.com

Deploy Xtract for VMs from Prism
+++++++++++++++++

In **Prism Central > Explore*, click **VMs**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm01.png

Click **Create VM**.

Fill out the following fields and click **Save**:

- **Name** - Xtract-VM
- **Description** - Xtract for VMs
- **VCPU(S)** - 2
- **Cores** - 2
- **Memory** - 4GiB
- **Disks** - **+ Add New Disk**
- **Disk Image (From Image Service)** - Xtract-VM
- **Disks** - **Remove CD-ROM**
- **Network** - Primary
- **IP Address** - 10.21.XX.42
- **Custom Script** - Select the Box
Select **Type or Paste Script**

  .. literalinclude:: xtract-vm-cloudinit-script

Now Power on the **Xtract-VM** VM.

When it completes open a browser window to the **Xtract for VMs** Dashboard http://10.21.XX.42.

Accept the EULA, and click **Continue**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm05.png

Click **OK** on the **Nutanix Customer Experience Program**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm06.png

Set **Password** to "nutanix/4u".

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm07.png

Login with the following credentials:

- **Username** - nutanix
- **Password** - nutanix/4u

Migrate VM with Xtract for VMs
+++++++++++++

In this portion of the lab we will configure source and target environments, create a migration plan, and finally perform a cutover operation.

Configure **Source** and **Targets** environements.
.................

In **Xtract**, click **+ Add Source Environment**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm08.png

Fill out the following fields and click **Add**:

- **Source Name** - Tech Summit 2018 vCenter
- **vCenter Server** - *Tech Summit vCenter Server*
- **User Name** - administrator@vsphere.local
- **Passwrod** - *vCenter Password*

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm09.png

In **Xtract**, click **+ Add Target Environment**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm08.png

Fill out the following fields and click **Add**:

- **Target Name** - *POCXXX*
- **vCenter Server** - 10.21.XX.37
- **User Name** - admin
- **Passwrod** - *Prism Password*

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm10.png

Now you should have **Source** and **Target** environments configured.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm11.png

Create a Migration Plan
.................

In **Xtract**, click **Create a Migration Plan**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm12.png

Enter Migration Plan Name, and click **OK**:

- **Migration Plan Name** - View-Win10-GoldenImage Migration.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm13.png

Enter Migration Plan Name, and click **Next**:

- **Select Target** - *POCXXX*
- **Target Container** - *CONTAINER-NAME*

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm14.png

Select **View-Win10-GoldenImage** VM, and click **Next**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm15.png

Fill out the following fields and click **Next**:

- **Common Windows Credentials**
- **User Name** - administrator
- **Password** - nutanix/4u
- **Target Network** - Primary

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm16.png

Click **Save and Start**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm17.png

Now you can watch the Migration process in the dashboard.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm18.png

Once the migrated data reaches the data size, or the migration completes, you can **Perform Cutover Operation**.

Perform Cutover Operation
.................

In **Xtract**, click **Migration In Progress**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm19.png

Select the box for **View-Win10-GoldenImage**, and click **Cutover**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm20.png

Click **Continue**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm21.png

After it is completed you can view it in Prism

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm22.png

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm23.png

Takeaways
+++++++++++

- Nutanix provides tools for migrating VMs off of existing VMware ESXi environments onto AHV.

- There are different ways to setup **Xtract for VMs**, so you have choice.

- Mirating VMs is done in a very easy Nutanix way.
