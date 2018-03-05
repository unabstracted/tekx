#!/bin/bash

DEPLOYERIZER_IP=10.21.64.50
set -x               #echo on

function remote_exec {
    sshpass -p $MY_PASS ssh -o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null nutanix@$MY_HOST "$@"
}


function acli {
    remote_exec /usr/local/nutanix/bin/acli "$@"
}

function ncli {
    remote_exec /home/nutanix/prism/cli/ncli "$@"
}

function clustercurl {
    remote_exec /usr/bin/curl "$@"
}

function allssh {
    CMD=$@
    SVMIPS="$(remote_exec /usr/local/nutanix/cluster/bin/svmips)"
    CVMIPS=($SVMIPS)

    remote_exec bash -c "'
      for i in ${CVMIPS[@]}
      do
          echo ======\${i}=====
          ssh nutanix@\${i} $CMD
      done
'"
}

for MY_LINE in `cat pocs.txt`
do
    set -f                      # avoid globbing (expansion of *).
    array=(${MY_LINE//|/ })
    MY_HOST=${array[0]}
    MY_PASS=${array[1]}
    MY_IP=(${MY_HOST//./ })
    MY_OCTET=${MY_IP[2]}

    echo BEGIN DEPLOYING ${MY_HOST} CLUSTER
    date

    # Accept EULA
  	curl -u admin:${MY_PASS} -k -H 'Content-Type: application/json' -X POST \
  	  https://${MY_HOST}:9440/PrismGateway/services/rest/v1/eulas/accept \
  	  -d '{
  	    "username": "SE",
  	    "companyName": "NTNX",
  	    "jobTitle": "SE"
  	}'

  	# Disable Prism Element Pulse
  	curl -u admin:${MY_PASS} -k -H 'Content-Type: application/json' -X PUT \
  	  https://${MY_HOST}:9440/PrismGateway/services/rest/v1/pulse \
  	  -d '{
  		"defaultNutanixEmail": null,
  		"emailContactList": null,
  		"enable": false,
  		"enableDefaultNutanixEmail": false,
  		"isPulsePromptNeeded": false,
  		"nosVersion": null,
  		"remindLater": null,
  		"verbosityType": null
  	}'

    # Open Port 2222 in CVM Firewall
  	allssh /usr/local/nutanix/cluster/bin/modify_firewall -f -o open -i eth0 -p 2222 -a

  	# Provision Prism Central binary
    clustercurl -O http://${DEPLOYERIZER_IP}/images/euphrates-5.5.1-stable-prism_central_metadata.json
    clustercurl -O http://${DEPLOYERIZER_IP}/images/euphrates-5.5.1-stable-prism_central.tar
    ncli software upload file-path=/home/nutanix/euphrates-5.5.1-stable-prism_central.tar \
    meta-file-path=/home/nutanix/euphrates-5.5.1-stable-prism_central_metadata.json software-type=PRISM_CENTRAL_DEPLOY
    remote_exec rm -fv /home/nutanix/euphrates*

    # Provision AFS binary
    clustercurl -O http://${DEPLOYERIZER_IP}/images/nutanix-afs-el7.3-release-afs-3.0.0-stable-95f331342bb288e7d3cdd1bba697e8f937ce0ee1-metadata.json
    clustercurl -O http://${DEPLOYERIZER_IP}/images/nutanix-afs-el7.3-release-afs-3.0.0-stable-95f331342bb288e7d3cdd1bba697e8f937ce0ee1.qcow2
    ncli software upload file-path=/home/nutanix/nutanix-afs-el7.3-release-afs-3.0.0-stable-95f331342bb288e7d3cdd1bba697e8f937ce0ee1.qcow2 \
    meta-file-path=/home/nutanix/nutanix-afs-el7.3-release-afs-3.0.0-stable-95f331342bb288e7d3cdd1bba697e8f937ce0ee1-metadata.json software-type=FILE_SERVER
    remote_exec rm -fv /home/nutanix/nutanix-afs*

    # Provision Networks
    ncli cluster edit-params external-data-services-ip-address=10.21.${MY_OCTET}.38

    acli net.create Primary vlan=0 ip_config=10.21.${MY_OCTET}.1/25
    acli net.update_dhcp_dns Primary servers=10.21.${MY_OCTET}.40 domains=POCLAB
    acli net.add_dhcp_pool Primary start=10.21.${MY_OCTET}.50 end=10.21.${MY_OCTET}.125

    acli net.create Secondary vlan=${MY_OCTET}1 ip_config=10.21.${MY_OCTET}.129/25
    acli net.update_dhcp_dns Secondary servers=10.21.${MY_OCTET}.40 domains=POCLAB
    acli net.add_dhcp_pool Secondary start=10.21.${MY_OCTET}.132 end=10.21.${MY_OCTET}.253

    acli net.create Link-Local-DO-NOT-TOUCH vlan=752

    # Provision DC
    acli image.create AutoDC container=Images image_type=kDiskImage source_url=http://${DEPLOYERIZER_IP}/images/AutoDC.qcow2
    acli vm.create DC num_vcpus=2 num_cores_per_vcpu=1 memory=4G
    acli vm.disk_create DC cdrom=true empty=true
    acli vm.disk_create DC clone_from_image=AutoDC
    acli vm.nic_create DC network=Primary ip=10.21.${MY_OCTET}.40
    acli vm.affinity_set DC host_list=10.21.${MY_OCTET}.26,10.21.${MY_OCTET}.27
    acli vm.on DC

    # Provision XenDesktop
    acli image.create AutoXD container=Images image_type=kDiskImage source_url=http://${DEPLOYERIZER_IP}/images/AutoXD.qcow2
    acli image.create XenDesktop-7.15-ISO container=Images image_type=kIsoImage source_url=http://${DEPLOYERIZER_IP}/images/XD715.iso
    acli vm.create XD num_vcpus=4 num_cores_per_vcpu=1 memory=6G
    acli vm.disk_create XD cdrom=true clone_from_image=XenDesktop-7.15-ISO
    acli vm.disk_create XD clone_from_image=AutoXD
    acli vm.nic_create XD network=Primary ip=10.21.${MY_OCTET}.41
    acli vm.affinity_set XD host_list=10.21.${MY_OCTET}.26,10.21.${MY_OCTET}.27
    acli vm.on XD

    # Provision X-Ray
    acli image.create XRay container=Images image_type=kDiskImage source_url=http://${DEPLOYERIZER_IP}/images/xray.qcow2
    acli vm.create X-Ray num_vcpus=4 num_cores_per_vcpu=1 memory=4G
    acli vm.disk_create X-Ray cdrom=true empty=true
    acli vm.disk_create X-Ray clone_from_image=XRay
    acli vm.nic_create X-Ray network=Primary ip=10.21.${MY_OCTET}.45
    acli vm.nic_create X-Ray network=Link-Local-DO-NOT-TOUCH
    acli vm.affinity_set X-Ray host_list=10.21.${MY_OCTET}.26,10.21.${MY_OCTET}.27
    acli vm.on X-Ray

    # Provision HYCU
    acli image.create HYCU container=Images image_type=kDiskImage source_url=http://${DEPLOYERIZER_IP}/images/hycu-2.0.0-2823.qcow2
    acli vm.create HYCU num_vcpus=2 num_cores_per_vcpu=2 memory=4G
    acli vm.disk_create HYCU cdrom=true empty=true
    acli vm.disk_create HYCU clone_from_image=HYCU
    acli vm.nic_create HYCU network=Primary ip=10.21.${MY_OCTET}.44
    acli vm.affinity_set HYCU host_list=10.21.${MY_OCTET}.26,10.21.${MY_OCTET}.27
    acli vm.on HYCU

    # Provision local Prism account for XD MCS Plugin
    ncli user create user-name=xd user-password=nutanix/4u first-name=XenDesktop last-name=Service email-id=no-reply@nutanix.com
    ncli user grant-cluster-admin-role user-name=xd

    # Provision Reverse Lookup Zone
    sshpass -p nutanix/4u ssh -o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null \
    root@10.21.${MY_OCTET}.40 "samba-tool dns zonecreate dc1 ${MY_OCTET}.21.10.in-addr.arpa; service samba-ad-dc restart"

    # Provision Prism Central
    CONTAINER_UUID=$(ncli "container ls name=Images" | grep "Uuid" | grep -v "Pool" | cut -f 2 -d ':' | xargs)
    NET_UUID=$(acli "net.get Primary" | grep "uuid" | cut -f 2 -d ':' | xargs)
    DEPLOY_BODY=$(cat <<EOF
	{
	  "resources": {
	      "should_auto_register":true,
	      "version":"5.5.1",
	      "pc_vm_list":[{
	          "data_disk_size_bytes":2684354560000,
	          "nic_list":[{
	              "network_configuration":{
	                  "subnet_mask":"255.255.255.128",
	                  "network_uuid":"${NET_UUID}",
	                  "default_gateway":"10.21.${MY_OCTET}.1"
	              },
	              "ip_list":["10.21.${MY_OCTET}.39"]
	          }],
	          "dns_server_ip_list":["10.21.253.10"],
	          "container_uuid":"${CONTAINER_UUID}",
	          "num_sockets":8,
	          "memory_size_bytes":34359738368,
	          "vm_name":"PC"
	      }]
	  }
	}
EOF
)
curl -u admin:${MY_PASS} -k -H 'Content-Type: application/json' -X POST https://${MY_HOST}:9440/api/nutanix/v3/prism_central -d "${DEPLOY_BODY}"

echo FINISHED DEPLOYING ${MY_HOST} CLUSTER
done
