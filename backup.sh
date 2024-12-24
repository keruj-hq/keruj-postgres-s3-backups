#!/bin/bash

set -o errexit -o nounset -o pipefail

export AWS_PAGER=""

s3() {
    aws s3 --endpoint "$AWS_ENDPOINT_URL_S3" "$@"
}

s3api() {
    aws s3api "$1" --endpoint "$AWS_ENDPOINT_URL_S3" --bucket "$S3_BUCKET_NAME" "${@:2}"
}

pg_dump_database() {
    pg_dump --jobs=1 --no-owner --no-privileges --clean --if-exists --quote-all-identifiers "$DATABASE_URL"
}

upload_to_bucket() {
    # if the zipped backup file is larger than 50 GB add the --expected-size option
    # see https://docs.aws.amazon.com/cli/latest/reference/s3/cp.html
    s3 cp - "s3://$S3_BUCKET_NAME/$(date +%Y/%m/%d/backup-%H-%M-%S.sql.gz)"
}

main() {
    pg_dump_database | gzip | upload_to_bucket
    echo "Done."
}

main
