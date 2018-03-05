#!/bin/bash

function remote_exec {
    sshpass -e ssh -o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null nutanix@10.21.${MY_OCTET}.39 "$@"
}

function ncli {
    remote_exec /home/nutanix/prism/cli/ncli "$@"
}

export SSHPASS='nutanix/4u'

for MY_LINE in `cat pocs.txt`
do
    set -f                      # avoid globbing (expansion of *).
    array=(${MY_LINE//|/ })
    MY_HOST=${array[0]}
    MY_PASS=${array[1]}
    MY_IP=(${MY_HOST//./ })
    MY_OCTET=${MY_IP[2]}

    echo CONFIGURING PRISM CENTRAL - 10.21.${MY_OCTET}.39

    # Set Prism Central Password to Prism Element Password
    ncli user reset-password user-name="admin" password="${MY_PASS}"

    # Add NTP Server
    ncli cluster add-to-ntp-servers servers=10.21.253.10

    # Accept Prism Central EULA
    curl -u admin:${MY_PASS} -k -H 'Content-Type: application/json' -X POST \
      https://10.21.${MY_OCTET}.39:9440/PrismGateway/services/rest/v1/eulas/accept \
      -d '{
        "username": "SE",
        "companyName": "NTNX",
        "jobTitle": "SE"
    }'

    # Disable Prism Element Pulse
    curl -u admin:${MY_PASS} -k -H 'Content-Type: application/json' -X PUT \
      https://10.21.${MY_OCTET}.39:9440/PrismGateway/services/rest/v1/pulse \
      -d '{
        "emailContactList":null,
        "enable":false,
        "verbosityType":null,
        "enableDefaultNutanixEmail":false,
        "defaultNutanixEmail":null,
        "nosVersion":null,
        "isPulsePromptNeeded":false,
        "remindLater":null
    }'

    echo FINISHED CONFIGURING PRISM CENTRAL - 10.21.${MY_OCTET}.39
done
