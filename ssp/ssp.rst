-------------------
Self-Service Portal
-------------------

Overview
++++++++

.. note::
  This lab should be done first.

  Estimated time to complete: **45 Minutes**

  **Due to limited resources, this lab should be completed as a group.**

In this exercise you will use Prism Central to configure Self Service Portal (SSP) from Prism Element, and create multiple projects for different groups of users. This lab should be completed **BEFORE** the Calm lab.

Getting Engaged with the Product Team
.....................................
- **Slack** - #ssp
- **Product Manager** - Constantine Kousoulis, constantine.kousouli@nutanix.com
- **Product Marketing Manager** - Shubhika Taneja, shubhika.taneja@nutanix.com

Setup Authentication and Role Mapping in Prism Central
+++++++++++++++++

In **Prism Central**, click :fa:`cog` **> Authentication**

Click **+ New Directory**

Fill out the following fields and click **Save**:

- **Directory Type** - Active Directory
- **Name** - NTNXLAB
- **Domain** - ntnxlab.local
- **Directory URL** - ldaps://10.21.XX.40
- **Service Account Name** - administrator@ntnxlab.local
- **Service Account Password** - nutanix/4u

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp01.png

Click on the yellow ! next to **NTNXLAB**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp28.png

Click on the **Click Here** to go to the Role Mapping screen

Click **+ New Mapping**

Fill out the following fields and click **Save**:

- **Directory** - NTNXLAB
- **LDAP Type** - user
- **Role** - Cluster Admin
- **Values** - administrator

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp29.png

Close the Role Mapping and Authentication windows

Configure Self Service Portal
+++++++++++++++++

We will use the following user information

+-----------------+-----------------------+--------------------------------+
| **Group**       | **Usernames**         | **Password**                   |
+-----------------+-----------------------+--------------------------------+
| SSP Admins      | adminuser01-25        | nutanix/4u                     |
+-----------------+-----------------------+--------------------------------+
| SSP Developers  | devuser01-25          | nutanix/4u                     |
+-----------------+-----------------------+--------------------------------+
| SSP Power Users | poweruser01-25        | nutanix/4u                     |
+-----------------+-----------------------+--------------------------------+
| SSP Basic Users | basicuser01-25        | nutanix/4u                     |
+-----------------+-----------------------+--------------------------------+

In **Prism Central**, click :fa:`cog` **> Self-Service Admin Management**.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp02.png

Fill out the following fields and click **Next**:

- **Domain** - ntnxlab.local
- **Username** - administrator@ntnxlab.local
- **Passord** - nutanix/4u

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp03.png

Click **+Add Admins**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp04.png

Enter **SSP Admins**, and Click **Save**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp05.png

Click **Save**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp06.png

Create Projects
+++++++++++++

In this section of the exercise we will create 3 Projects. Each project will have permissions set for different Active Directory groups.

In **Prism Central**, click **Explore**

Click **Projects**

Create **Developers** Project
.................

Click **Create Project**

Fill out the following fields:

- **Project Name** - Developers
- **Description** - SSP Developers
- **AHV Cluster** - *Assigned HPOC*

Click **+User** under **Users, Groups, and Roles**

Fill out the following fields and click **Save**:

- **NAME** - SSP Developers
- **ROLE** - Developer

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp08.png

Under **Network** check the appropriate network, and make it default.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp09.png

Check the box for **Quotas**

Fill out the following fields:

- **VCPUS** - 10 VCPUs
- **Storage** - 200 GiB
- **Memory** - 40 GiB

Confirm everything is filled out, and click **Save**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp10.png

Create **Power Users** Project
.................

Click **Create Project**

Fill out the following fields:

- **Project Name** - Power Users
- **Description** - SSP Power Users
- **AHV Cluster** - *Assigned HPOC*

Click **+User** under **Users, Groups, and Roles**

Fill out the following fields and click **Save**:

- **NAME** - SSP Power Users
- **ROLE** - Developer

Under **Network** check the appropriate network, and make it default.

Check the box for **Quotas**

Fill out the following fields:

- **VCPUS** - 10 VCPUs
- **Storage** - 200 GiB
- **Memory** - 40 GiB

Confirm everything is filled out, and click **Save**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp11.png

Create **Calm** Project
.................

Click **Create Project**

Fill out the following fields:

- **Project Name** - Calm
- **Description** - Calm
- **AHV Cluster** - *Assigned HPOC*

Click **+User** under **Users, Groups, and Roles**

Fill out the following fields and click **Save**:

- **NAME** - SSP Admins
- **ROLE** - Project Admin

Fill out the following fields and click **Save**:

- **NAME** - SSP Developers
- **ROLE** - Developer

Fill out the following fields and click **Save**:

- **NAME** - SSP Power Users
- **ROLE** - Consumer

Fill out the following fields and click **Save**:

- **NAME** - SSP Basic Users
- **ROLE** - Operator

Under **Network** check the appropriate network, and make it default.

.. Note:: Select both **Primary** and **Secondary**

Confirm everything is filled out, and click **Save**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp12.png

Use Self Service Portal
+++++++++++++

In this exercise we will login into Prism Central as different users from different AD groups. Then we can compare what we see in SSP, and what we can do.

Lets Start by logging out of Prism Central

Use Self Service Portal as a SSP Admin
.................

Log into Prism Central with the following credentials:

- **Username** - adminuserXX@ntnxlab.local (replace XX with 01-05)
- **Password** - nutanix/4u

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp13.png

After you login you only have two tabs inthe top ribbon, **Explore** & **Apps**

You start on **VMs**, and should see all VMs the **adminuserXX** has access Tools

Click on **Projects**, and you will see what Projects **adminuserXX** is a member of

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp14.png

Now lets add some images to a **Catalog**, click on **Images**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp15.png

Select the box for **Windows2012**, and click **Add Image to Catalog** from the **Actions** dropdown

  .. figure:: http://s3.nutanixtechsummit.com/ssp/ssp16.png

Fill out the following fields and click **Save**:

- **NAME** - Windows2012 Image
- **Description** - Windows2012 Image

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp17.png

Repeat these steps for the CentOS Image

Click on **Catalog Items**, and you will see the two images you just added:

- CentOS Image
- Windows2012 Image

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp18.png

Use Self Service Portal as a Developer
.................

Log into Prism Central with the following credentials:

- **Username** - devuserXX@ntnxlab.local (replace XX with 01-05)
- **Password** - nutanix/4u

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp19.png

After you login you only have two tabs inthe top ribbon, **Explore** & **Apps**

You start on **VMs**, and should see all VMs the **devuserXX** has access Tools

Click on **Projects**, and you will see what Projects **devuserXX** is a member of

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp20.png

Click on **VMs**, then click **Create VM**

Verify **Disk Images** is selected, and click **Next**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp21.png

Select **CentOS Image**, and click **Next**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp22.png

Fill out the following fields and click **Save**:

- **Name** - Developer VM 001
- **Target Project** - Developers
- **Disks** - Select **Boot From**
- **Network** - Select **Primary**
- **Advance Settings** - Check **Manually Configure CPU & Memory**
- **CPU** - 1 VCPU
- **Memory** - 2 GB

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp23.png

You should now see VM **Developer VM 001** listed

Lets see what happens when we log in as a user from a different group

Use Self Service Portal as a Power User
.................

Log into Prism Central with the following credentials:

- **Username** - poweruserXX@ntnxlab.local (replace XX with 01-05)
- **Password** - nutanix/4u

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp24.png

After you login you only have two tabs inthe top ribbon, **Explore** & **Apps**

You start on **VMs**, and should see all VMs the **poweruserXX** has access Tools

Notice you do not see **Developer VM 001**, that is because **SSP Power Users** is not a memeber of that project.

click **Create VM**

Verify **Disk Images** is selected, and click **Next**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp21.png

Select **CentOS Image**, and click **Next**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp22.png

Fill out the following fields and click **Save**:

- **Name** - Calm VM 001
- **Target Project** - Calm
- **Disks** - Select **Boot From**
- **Network** - Select **Secondary**
- **Advance Settings** - Check **Manually Configure CPU & Memory**
- **CPU** - 1 VCPU
- **Memory** - 2 GB

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp25.png

You should now see VM **Calm VM 001** listed

Logout, and log back in as **devuserXX@ntnxlab.local**

You should see both **Developer VM 001** & **Calm VM 001**. That is because **SSP Developers** is a member of both **Projects**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp26.png

Click on **Projects**, and you will see the resource usage of **Developer VM 001** against the **Developer** project quota.

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp27.png

Configure App Management
+++++++++++++++++

In **Prism Central**, click :fa:`cog` **> Enable App Management**

Check the box for **Enable App Management**

Verify the box is checked for **Enable Nutanix Seeded Blueprints**

Click **Save**

  .. figure:: https://s3.us-east-2.amazonaws.com/s3.nutanixtechsummit.com/ssp/ssp30.png

Monitor Recent Tasks, and watch for the "Volume Group", "Volume Disk", and "Batch Configure" Tasks to complete

Click on the **Apps** Tab in the Top Navigation Ribbon

If you see the Calm UI you are done

.. Note:: You should see the projects you created in the **SSP** Module

Takeaways
+++++++++++

- Nutanix provides a native service to seperate out resources for different groups, while giving them a Self-Service approach to using those resources.

- Easy to assign resources to different projects using directory groups

- Easy to assign a set of resources (quotas) to better manage cluster resources, or for show back
