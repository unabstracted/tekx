-------------------
Xtract for VMs
-------------------

Overview
++++++++

In this exercise you will deploy, and use the Xtract tools to migrate a VM.

.. note:: You can choose to deploy **Xtract for VMs** via the CLI or from Prism. Directions for both below.

Deploy Xtract for VMs from CLI
+++++++++++++++++

Downloaded, and unzip **xtract-vm-1.1.2-release.zip** from the Nutanix Portal

Open a Shell on your laptop, and navigate to the unzipped xtract directory.

Run **"ls -l"**, and you will see the 3 different cli options

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm02.png

You will launch the utility for your OS (Windows or OS X), and point to your teams HPOC

  .. code-block:: bash

    ./cli-darwin-amd64-1.1.2 -c 10.21.xx.37

Next you will be promted to enter the **admin** Password

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm03.png

Now you can deploy the **Xtract** VM.

To do this you will need the name of your **storage container**, **Network**, and **IP Address**.

For this exercise we will use a static IP, you will need this information:

- **IP Address** - 10.21.XX.42
- **Netmask** - 255.255.255.128
- **Gateway** - 10.21.XX.1
- **DNS1** - 10.21.253.10
- **DNS2** - 10.21.253.11
- **Search Domains** - nutanixdc.local

  .. code-block:: bash

    deploy-vm vm-container CONTAINER-NAME vm-network Primary ip-address 10.21.XX.42 netmask 255.255.255.128 gateway 10.21.XX.1 dns1 10.21.253.10 dns2 10.21.253.11 searchdomains nutanixdc.local

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm04.png

When it completes it will open a browser window to the **Xtract for VMs** Dashboard

Accept the EULA, and click **Continue**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm05.png

Click **OK** on the **Nutanix Customer Experience Program**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm06.png

Set **Password** to "nutanix/ru"

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm07.png

Login with the following credentials:

- **Username** - nutanix
- **Password** - nutanix/4u

Deploy Xtract for VMs from Prism
+++++++++++++++++

In **Prism > VM**, click **VM**, then click **Table**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm01.png

Click **+ Create VM**

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
- **Custom Script** - Check the Box
Select **Type or Paste Script**

  .. literalinclude:: xtract-vm-cloudinit-script

Now Power on the **Xtract-VM** VM

When it completes it will open a browser window to the **Xtract for VMs** Dashboard

Accept the EULA, and click **Continue**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm05.png

Click **OK** on the **Nutanix Customer Experience Program**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm06.png

Set **Password** to "nutanix/ru"

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm07.png

Login with the following credentials:

- **Username** - nutanix
- **Password** - nutanix/4u

Migrate VM with Xtract for VMs
+++++++++++++

In this portion of the lab we will configure source and target environments, create a migration plan, and finally perform a cutover operation.

Configure **Source** and **Targets** environements
.................

In **Xtract **, click **+ Add Source Environment**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm08.png

Fill out the following fields and click **Add**:

- **Source Name** - Tech Summit 2018 vCenter
- **vCenter Server** - 10.21.64.40
- **User Name** - administrator@vsphere.local
- **Passwrod** - techX2018!

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm09.png

In **Xtract **, click **+ Add Source Environment**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm08.png

Fill out the following fields and click **Add**:

- **Target Name** - POCXXX
- **vCenter Server** - 10.21.XX.37
- **User Name** - admin
- **Passwrod** - techX2018!

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm10.png

Now you should have **Source** and **Target** environments condfigured

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm11.png

Create a Migration Plan
.................

In **Xtract **, click **Create a Migration Plan**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm12.png

Enter Migration Plan Name, and click **OK**:

- **Migration Plan Name** - View-Win10-GoldenImage Migration

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm13.png

Enter Migration Plan Name, and click **Next**:

- **Select Target** - POCXXX
- **Target Container** - CONTAINER-NAME

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm14.png

Select **View-Win10-GoldenImage** VM, and click **Next**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm15.png

Fill out the following fields and click **Next**:

- **Common Windows Credentials*
- **User Name** - administrator
- **Password** - nutanix/4u
- **Target Network** - Primary

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm16.png

Click **Save and Start**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm17.png

Now you can watch the Migration process in the dashboard

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm18.png

Once the migration completes, you can **Perform Cutover Operation**

Perform Cutover Operation
.................

In **Xtract **, click **Migration In Progress**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm19.png

Check the box for **View-Win10-GoldenImage**, and click **Cutover**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm20.png

Click **Continue**

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm21.png

After it is completed you can view it in Prism

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm22.png

.. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/xtract-vm/xtractvm23.png

Conclusions
+++++++++++

- Nutanix provides tools for migrating VMs off of existing VMware ESXi environments onto AHV

- There are different ways to setup **Xtract for VMs**, so you have choice

- Mirating VMs is done in a very easy Nutanix way
