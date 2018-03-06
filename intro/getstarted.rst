.. role:: raw-html(raw)
   :format: html

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
