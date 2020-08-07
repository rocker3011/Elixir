#!/bin/bash
echo "Starting the test..."
 seq 1 1000 | xargs -n1 -P 150 bash -c "curl --request POST \
    --url http://localhost:4001/images/upload \
    --header 'content-type: multipart/form-data;' \
    --form device_id=999 \
    --form image=new_image"