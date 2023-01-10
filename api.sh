#!/bin/bash

MOD_DIR=$( dirname -- "$0"; )

SCHEDULE=$(cat $MOD_DIR/schedule.json)

read -r -d '' PAYLOAD <<EOF
{
    "tenant_id": "${TENANT_ID}",
    "name": "${SCHEDULE_NAME}",
    "cloud_provider": "AWS",
    "cloud_account_id": "${ACCOUNT_ID}",
    "tag_search": "${MATCHING_TAGS}",
    "paused": ${SCHEDULE_PAUSED},
    "days": ${SCHEDULE}
}
EOF

echo $PAYLOAD > $MOD_DIR/payload.json

curl -s -0 -X POST ${API_ENDPOINT}/schedules/${TENANT_ID}/${ACCOUNT_ID}/:ensure \
-H "Authorization: Bearer ${API_KEY}" \
-H 'Content-Type: application/json; charset=utf-8' \
-d @$MOD_DIR/payload.json
