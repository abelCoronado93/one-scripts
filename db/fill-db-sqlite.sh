#!/bin/bash

if [ -z $1 ]; then
	echo "Parameter does not exist"
	echo "Please select a SQLite database"

# Fill SQLite DB w/ 600000 records -> basic ONE template
else
    echo 'Inserting rows into vm_pool...'
    for (( i=0; i<600000; i++ ))
        do
            sqlite3 $1 'INSERT INTO vm_pool
            (
                oid,
                name,
                body,
                uid,
                gid,
                last_poll,
                state,
                lcm_state,
                owner_u,
                group_u,
                other_u
            )
            VALUES
            (
                '$i',
                "test",
                "<VM>
                    <ID>1</ID>
                    <UID>0</UID>
                    <GID>0</GID>
                    <UNAME>oneadmin</UNAME>
                    <GNAME>oneadmin</GNAME>
                    <NAME>test</NAME>
                    <PERMISSIONS>
                        <OWNER_U>1</OWNER_U>
                        <OWNER_M>1</OWNER_M>
                        <OWNER_A>0</OWNER_A>
                        <GROUP_U>0</GROUP_U>
                        <GROUP_M>0</GROUP_M>
                        <GROUP_A>0</GROUP_A>
                        <OTHER_U>0</OTHER_U>
                        <OTHER_M>0</OTHER_M>
                        <OTHER_A>0</OTHER_A>
                    </PERMISSIONS>
                    <LAST_POLL>0</LAST_POLL>
                    <STATE>1</STATE>
                    <LCM_STATE>0</LCM_STATE>
                    <PREV_STATE>0</PREV_STATE>
                    <PREV_LCM_STATE>0</PREV_LCM_STATE>
                    <RESCHED>0</RESCHED>
                    <STIME>1518522674</STIME>
                    <ETIME>0</ETIME>
                    <DEPLOY_ID/>
                    <MONITORING/>
                    <TEMPLATE>
                        <AUTOMATIC_REQUIREMENTS><![CDATA[!(PUBLIC_CLOUD = YES)]]></AUTOMATIC_REQUIREMENTS>
                        <CONTEXT>
                        <DISK_ID><![CDATA[0]]></DISK_ID>
                        <NETWORK><![CDATA[YES]]></NETWORK>
                        <SSH_PUBLIC_KEY><![CDATA[]]></SSH_PUBLIC_KEY>
                        <TARGET><![CDATA[hda]]></TARGET>
                        </CONTEXT>
                        <CPU><![CDATA[0.01]]></CPU>
                        <GRAPHICS>
                        <LISTEN><![CDATA[0.0.0.0]]></LISTEN>
                        <TYPE><![CDATA[VNC]]></TYPE>
                        </GRAPHICS>
                        <MEMORY><![CDATA[1024]]></MEMORY>
                        <OS>
                        <BOOT><![CDATA[]]></BOOT>
                        </OS>
                        <TEMPLATE_ID><![CDATA[1]]></TEMPLATE_ID>
                        <VMID><![CDATA[1]]></VMID>
                    </TEMPLATE>
                    <USER_TEMPLATE>
                        <HYPERVISOR><![CDATA[kvm]]></HYPERVISOR>
                        <MEMORY_UNIT_COST><![CDATA[MB]]></MEMORY_UNIT_COST>
                    </USER_TEMPLATE>
                    <HISTORY_RECORDS/>
                </VM>",
                0,
                0,
                1518161113,
                8,
                0,
                1,
                0,
                0
            );'
        done
fi
