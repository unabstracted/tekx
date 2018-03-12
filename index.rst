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
            <h2>Awards and Prizes</h2>
            <p>In addition to bragging rights and special recognition at SKO there will be prizes for the winning team. There will be awards for most Jira ticket submissions and special contributions.</p>
        </div>
    </div>
    <hr>

Getting Started
===============

.. note::

  Due to resource limitations, many labs are designed to be completed as a group. The Overview section of each lab will indicate whether the lab should be completed once per group/cluster or if it can be performed individually. **Do Not Start Labs Before Electing a Team Lead and Consulting Your Team Coach**

Following presentations on Tuesday, you will have approximately 4 hours to complete the **Required Labs**.

Beginning on Wednesday you will be provided with a customer challenge. Your goal is to build and propose a solution using Nutanix and optional 3rd party technologies. The **Optional Labs** provide step by step guides for additional technologies you may find useful for your proposed solution. Bonus points can be earned by incorporating additional technologies (Chef, Puppet, Jenkins, etc.) not covered in **Optional Labs**.

Each team has been provided a four node cluster running AHV and AOS 5.5.1. **Upon Electing a Team Lead and Consulting Your Team Coach Please Exam Your Cluster.** Each cluster has been pre-staged with the following:

**Networks**

- **Network information is located on your team spreadsheet** - https://drive.google.com/drive/folders/1-8vVrC7Ad9uFeWnY1LcaffQQEoD-Eris
- **Link-Local** Network - **DO NOT ENABLE IPAM**

**Images**

- **All required images are pre-loaded onto your team's cluster**

**Virtual Machines**

- **PC** VM - 10.21.XX.39 - Nutanix Prism Central 5.5.1
- **DC** VM - 10.21.XX.40 - ntnxlab.local Domain Controller
- **XD** VM - 10.21.XX.41 - Citrix XenDesktop 7.15 Delivery Controller/StoreFront/License Server
- **HYCU** VM - 10.21.XX.44 - Comtrade HYCU 2.0.0
- **X-Ray** VM - 10.21.XX.45 - Nutanix X-Ray 2.2

.. note::

  Due to resource limitations, many labs are designed to be completed as a group. The Overview section of each lab will indicate whether the lab should be completed once per group/cluster or if it can be performed individually. **Do Not Start Labs Before Electing a Team Lead and Consulting Your Team Coach**
