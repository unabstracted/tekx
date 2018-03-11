.. title:: Tech Summit 2018

.. _intro-docs:

.. toctree::
  :maxdepth: 2
  :caption:     Required Labs
  :name: _req-labs
  :hidden:

  .. example/index
  ssp/ssp
  calm_mysql/calm_mysql
  calm_lamp/calm_lamp
  calm_mrkt_p1/calm_marketplace_p1
  calm_mrkt_p2/calm_marketplace_p2
  calm_mssql/calm_mssql
  git/gitlab
  github/github
  xtract-vm/xtract-vm
  xtract-db/xtract-db
  xray/index

.. toctree::
  :maxdepth: 2
  :caption:     Optional Labs
  :name: _opt-labs
  :hidden:

  afs/index
  citrix/index
  hycu/index
  docker/calm_workshop_lab7_docker
  .. k8s/index
  ansible/calm_workshop_lab6
  rest/calm/calm_workshop_lab5_api
  .. terraform/index

.. toctree::
  :maxdepth: 2
  :caption:     Other Resources
  :name: _resources
  :hidden:

  .. jenkins/index
  .. chef/index
  .. puppet/index

.. raw:: html

    <div class="row">
        <div class="col-md-6">
            <h2>Need Support?</h2>
            <p>Join us in #techsummit2018 on Slack for questions, comments, and important announcements.</p>
            <p><a class="btn btn-secondary" href="slack://channel?id=C7ELNM1KL&amp;team=T0252CLM8" role="button">Join Channel &raquo;</a></p>
        </div>
        <div class="col-md-6">
            <h2>The Grand Prize</h2>
            <p>A description of the lavish prizes that will drive people to blood, sweat, and tears to beat out their co-workers.</p>
        </div>
    </div>

Get Started
===========

Following presentations on Tuesday, you will have approximately 5 hours to complete the **Required Labs**.

Beginning on Wednesday you will be provided with a customer challenge. Your goal is to build and propose a solution using Nutanix and optional 3rd party technologies. The **Optional Labs** provide step by step guides for additional technologies you may find useful for your proposed solution. Bonus points can be earned by incorporating additional technologies (Chef, Puppet, Jenkins, etc.) not covered in **Optional Labs**.

Each team has been provided a four node cluster running AHV and AOS 5.5.1. Each cluster has been pre-staged with the following:

**Networks**

- **Primary** Network - 10.21.XX.1/25 - IPAM DHCP Pool 10.21.XX.50-10.21.XX.124
- **Secondary** Network - 10.21.XX.129/25 - IPAM DHCP Pool 10.21.XX.132-10.21.XX.253
- **Link-Local** Network - **DO NOT ENABLE IPAM**

**Images**

- **Windows2012** Disk Image - Windows Server 2012 R2 Standard
- **Windows10** Disk Image - Windows 10 Enterprise
- **CentOS** Disk Image - CentOS 6.?
- **Xtract-VM** Disk Image - Nutanix Xtract 1.1.3
- **Xtract-DB** Disk Image - Nutanix Xtract for Databases 1.5.0
- **XenDesktop-7.15-ISO** ISO Image - Citrix XenDesktop 7.15 Installation
- **MSSQL-2014SP2-ISO** ISO Image - Microsoft SQL Server 2014 SP2 Installation

**Virtual Machines**

- **PC** VM - 10.21.XX.39 - Nutanix Prism Central 5.5.1
- **DC** VM - 10.21.XX.40 - ntnxlab.local Domain Controller
- **XD** VM - 10.21.XX.41 - Citrix XenDesktop 7.15 Delivery Controller/StoreFront/License Server
- **HYCU** VM - 10.21.XX.44 - Comtrade HYCU 2.0.0
- **X-Ray** VM - 10.21.XX.45 - Nutanix X-Ray 2.2

.. note::

  Due to resource limitations, many labs are designed to be completed as a group. The Overview section of each lab will indicate whether the lab should be completed once per group/cluster or if it can be performed individually.
