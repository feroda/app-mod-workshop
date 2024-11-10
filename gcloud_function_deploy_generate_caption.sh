#!/bin/bash

set -euo pipefail

# add your logic here, for instance:
source .env || exit 2 

SERVICE_NAME="php-amarcord-dev"
PROJECT_ID="php-amarcord-441108"
BUCKET="${PROJECT_ID}-public-images"
GS_BUCKET="gs://${BUCKET}"
GCP_REGION=europe-west8

echo "Pushing ☁️ f(x)☁ to 🪣 $GS_BUCKET, along with DB config.. (DB_PASS=$DB_PASS)"

gcloud --project "$PROJECT_ID" functions deploy php_amarcord_generate_caption \
    --runtime python310 \
    --region "$GCP_REGION" \
    --trigger-event google.cloud.storage.object.v1.finalized \
    --trigger-resource "$BUCKET" \
    --set-env-vars "DB_HOST=$DB_HOST,DB_NAME=$DB_NAME,DB_PASS=$DB_PASS,DB_USER=$DB_USER" \
    --source ./triggera_gemini/ \
    --entry-point generate_caption \
    --memory 512M \
    --gen2
