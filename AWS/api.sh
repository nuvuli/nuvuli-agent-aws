#!/bin/bash

MOD_DIR=$( dirname -- "$0"; )

SCHEDULE=$(cat $MOD_DIR/schedule.json)


curl -0 -v -X POST ${API_URL}/schedules/${TENANT_ID}/${ACCOUNT_ID}/:ensure \
-H "Authorization: ${API_KEY}" \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF
{
    "tenant_id": "${TENANT_ID}",
    "name": "${SCHEDULE_NAME}",
    "cloud_provider": "AWS",
    "cloud_account_id": "${ACCOUNT_ID}",
    "tag_search": "${MATCHING_TAGS}",
    "paused": ${SCHEDULE_PAUSED},
    "schedule": ${SCHEDULE}
}
EOF
