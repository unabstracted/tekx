-----------------------
Acropolis File Services
-----------------------

Overview
++++++++

.. note::

  This lab should be completed **AFTER** the :ref:`citrix_lab` lab.

  Estimated time to complete: **1 HOUR**

  **Due to limited resources, this lab should be completed as a group.**

In this exercise you will use Prism to deploy Acropolis File Services (AFS), a native, distributed file server solution for Nutanix clusters. You will configure both SMB and NFS shares, and familiarize yourself with new features of the AFS offering.

Getting Engaged with the Product Team
.....................................

- **Slack** - #afs
- **Product Manager** - Shubhankar Chatterjee, shubhan.chatter@nutanix.com
- **Product Marketing Manager** - Shubhika Taneja, shubhika.taneja@nutanix.com
- **Technical Marketing Engineer** - Dwayne Lessner, dwayne@nutanix.com

Deploy Acropolis File Services
++++++++++++++++++++++++++++++

In **Prism > File Server**, click **+ File Server**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/vdi_ahv/lab7/1.png

The AFS 3.0.0 package has been already been uploaded and the Data Services IP has been configured as 10.21.XXX.38. Click **Continue**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/vdi_ahv/lab7/7.png

Fill out the following fields and click **Next**:

  - **Name** - AFS
  - **Domain** - ntnxlab.local
  - **File Server Size** - 1 TiB

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/8b.png

.. note:: Clicking **Custom Configuration** will allow you to alter the scale up and scale out sizing of the AFS VMs based on User and Throughput targets.

Select the **Primary - Managed** VLAN for the Client Network. Ensure the **DNS Resolver IP** is configured as the IP of your **DC** VM and **NOT** the cluster Name Server IP. Click **Next**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/9c.png

Select the **Primary - Managed** VLAN for the Storage Network. Click **Next**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/10b.png

.. note::

  It is typically desirable to deploy AFS with dedicated networks for client and storage. By design, however, AFS does not allow client connections from the storage network in this configuration. As the Hosted POC environment only provides 2 subnets per cluster, a single network deployment of AFS provides the most flexibility to connect to shares/exports via the Primary or Secondary networks.

Fill out the following fields and click **Next**:

  - Select **Use SMB Protocol**
  - **Username** - Administrator
  - **Password** - nutanix/4u
  - Select **Make this user a File Server admin**
  - Select **Use NFS Protocol**
  - **User Management and Authentication** - Unmanaged

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/11b.png

.. note:: Similar to NFSv3, in Unmanaged mode, users are only identified by UID/GID. NFS connections will still require an NFSv4 capable client.

Review the configuration and click **Create**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/12b.png

Monitor deployment progress in **Prism > Tasks**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/vdi_ahv/lab7/13.png

Upon completion, select the **AFS** server and click **Protect**.

Observe the default Self Service Restore schedules, this feature controls the snapshot schedule for Windows' Previous Versions functionality. Supporting Previous Versions allows end users to roll back changes to files without engaging storage or backup administrators. Note these local snapshots do not protect the file server cluster from local failures and that replication of the entire file server cluster can be performed to remote Nutanix clusters. Click **Close**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/vdi_ahv/lab7/16.png

Configuring SMB Home Share
++++++++++++++++++++++++++

In **Prism > File Server**, click **+ Share/Export**. Fill out the following fields and click **Next**:

  - **Name** - home
  - **Protocol** - SMB
  - **Share/Export Type** - Home directory and User Profiles

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/14.png

Select **Enable Access Based Enumeration** and **Self Service Restore** and click **Create**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/15.png

In the **XD** VM console, open ``\\AFS.ntnxlab.local`` in **File Explorer**.

Right-click **home > Properties**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/vdi_ahv/lab7/19.png

Select the **Security** tab and click **Advanced**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/vdi_ahv/lab7/20.png

Select **Users (AFS\\Users)** and click **Remove**.

Click **Add**.

Click **Select a principal** and specify **Everyone** in the **Object Name** field. Click **OK**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/vdi_ahv/lab7/21b.png

Fill out the following fields and click **OK**:

  - **Type** - *Allow*
  - **Applies to** - *This folder only*
  - Select **Read & execute**
  - Select **List folder contents**
  - Select **Read**
  - Select **Write**

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/vdi_ahv/lab7/22.png

Click **OK > OK > OK**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/23b.png

In the **XD** VM console, open **Control Panel > Administrative Tools > Active Directory Users & Computers**.

Under **ntnxlab.local > Users**, right-click **devuser01 > Properties**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/17.png

Click **Profile**. Under **Home folder**, select **Connect** and specify ``\\afs.ntnxlab.local\home\%username%`` as the path. Click **OK**. Repeat for the following user accounts: **devuser02**, **devuser03**, **devuser04**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/18.png

In **Prism > File Server > Share > home**, click **+ Add Quota Policy**. Fill out the following fields and click **Save**:

  - Select **Groups**
  - **Users or Group** - SSP Developers
  - **Quota** - 10 GiB
  - **Enforcement Type** - Hard Limit

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/20.png

Open \http://<*XD-VM-IP*>/Citrix/StoreWeb in a browser on the same L3 LAN as your XD VM.

Log in as **NTNXLAB\\devuser01**.

Select the **Desktops** tab and click your **Personal Windows 10 Desktop** to launch the session.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/vdi_ahv/lab5/31.png

Open ``Z:\`` in **File Explorer** and create multiple files, with at least one populated text file.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/19.png

Open ``\\afs.ntnxlab.local\home`` and observe your **%username%** directory is the only directory visible. Disable **Access Based Enumeration (ABE)** in **Prism > File Server > Share > home > Update** and try again.

After ~2 hours, validate the presense of **Self Service Restore Snapshots** in **Prism > File Server > Share > home**.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/21a.png

From **NTNXLAB\\devuser01's Personal Windows 10 Desktop** session, browse to your home directory. Open, modify, and save a text file. Right-click that file and select **Restore previous versions**. Open a previous version of the document corresponding to AFS snapshots and save as a new file.

Configuring NFS Export
++++++++++++++++++++++

In **Prism > File Server**, click **+ Share/Export**. Fill out the following fields and click **Next**:

  - **Name** - logs
  - **Protocol** - NFS
  - **Share/Export Type** - Non-Shared Directories

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/22.png

Fill out the following fields and click **Create**:

  - **Authentication** - System
  - **Default Access** - No Access
  - **Clients with Read-Write Access** - *Cluster IP Range* (10.21.XX.*)

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/23.png

In **Prism > VM**, click **+ Create VM** and fill out the following fields:

- **Name** - NFS-Client
- **Description** - CentOS VM for testing AFS NFS export
- **vCPU** - 2
- **Number of Cores per vCPU** - 1
- **Memory** - 4

Click **+ Add New Disk**, fill out the following fields, and click **Add**:

- **Type** - DISK
- **Operation** - Clone from Image Service
- **Bus Type** - SCSI
- **Image** - *CentOS Disk Image*

Click **Add New NIC**. fill out the following fields, and click **Add**:

  - **VLAN Name** - Secondary

Click **Save**.

In **Prism > VM > Table**, select the **NFS-Client** VM and click **Power on**.

Once the VM has started, click **Launch Console** and log in as **root** or connect via SSH.

Execute the following:

  .. code-block:: bash

    yum -y install nfs-utils
    mkdir /afsmnt
    mount.nfs4 afs.ntnxlab.local:/ /afsmnt
    df -kh
    ls /afsmnt

Observe that the **logs** directory is mounted in ``/afsmnt/logs``.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/24.png

Reboot the VM and observe the export is no longer mounted. To persist the mount, add it to ``/etc/fstab`` by executing the following:

  .. code-block:: bash

    echo 'afs.ntnxlab.local:/ /afsmnt nfs4' >> /etc/fstab

The following command will add 2000 2MB files filled with random data to ``/afsmnt/logs``:

  .. code-block:: bash

    for i in {1..2000}; do dd if=/dev/urandom bs=8k count=256 of=/afsmnt/logs/file$i; done

Return to **Prism > File Server > Share > logs** to monitor performance and usage.

  .. figure:: https://s3.amazonaws.com/s3.nutanixworkshops.com/ts18/afs/25.png

Takeaways
+++++++++

  - Nutanix provides file services suitable for storing user profiles and application data via SMB or NFSv4.

  - AFS is capable of scaling up and out to meet workload requirements.

  - AFS has data protection built-in by leveraging native snapshots and replication. AFS 3.0 will also feature integration with 3rd party backup solutions.

  - AFS can be deployed on the same Nutanix cluster as your virtual desktops, resulting in better utilization of storage capacity and the elimination of an additional storage silo.

  - Supporting mixed workloads (e.g. virtual desktops and file services) is further enhanced by Nutanix's ability to mix different node configurations within a single cluster, such as:

    - Mixing storage heavy and compute heavy nodes
    - Expanding a cluster with Storage Only nodes to increase storage capacity without incurring additional virtualization licensing costs
    - Mixing different generations of hardware (e.g. NX-3460-G6 + NX-6235-G5)
    - Mixing all flash nodes with hybrid nodes
    - Mixing NVIDIA GPU nodes with non-GPU nodes
