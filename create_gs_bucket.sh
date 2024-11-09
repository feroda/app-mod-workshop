#!/bin/bash

set -euo pipefail

# Your Cloud Run Service Name, eg php-amarcord-dev
SERVICE_NAME='php-amarcord-dev'
BUCKET="${PROJECT_ID}-public-images"
GS_BUCKET="gs://${BUCKET}"

GCP_REGION=europe-west8

# Create bucket
gsutil mb -l "$GCP_REGION" -p "$PROJECT_ID" "$GS_BUCKET/"

# Copy original pictures there - better if you add an image of YOURS before.
gsutil cp ./uploads/*.png "$GS_BUCKET/"
