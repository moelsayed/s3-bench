#! /bin/sh
set -euo pipefail

REGION=${AWS_REGION:-eu-central-1}
ENDPOINT=${S3_ENDPOINT:-"s3.${REGION}.amazonaws.com"}

ACCESS_KEY=${AWS_ACCESS_KEY:-""}
SECRET_KEY=${AWS_SECRET_KEY:-""}
BUCKET=${S3_BUCKET:-""}

DURATION=${TEST_DURATION:-"5m"}
OBJECT_COUNT=${TEST_OBJECT_COUNT:-"2500"}

DBUSER=${MYSQL_USER:-""}
DBPASS=${MYSQL_PASSWORD:-""}
DBNAME=${MYSQL_DATABASE:-""}

# TODO SHOULD BE CONFIGURABLE
DBHOST="mysql-s3-bench"
# quick and dirty validation
[[ -z ${ACCESS_KEY} ]] || [[ -z ${SECRET_KEY} ]] || [[ -z ${BUCKET} ]] && (echo "AWS_ACCESS_KEY, AWS_SECRET_KEY or S3_BUCKET can not be empty"; exit 1)

[[ -z ${DBUSER} ]] || [[ -z ${DBPASS} ]] || [[ -z ${DBNAME} ]] && (echo "MYSQL_USER, MYSQL_PASSWORD or MYSQL_DATABASE can not be empty"; exit 1)

# run the test 
warp mixed --host=${ENDPOINT} --region=${REGION} \
    --access-key=${ACCESS_KEY} --secret-key=${SECRET_KEY} \
    --bucket=${BUCKET} --duration=${DURATION} --objects=${OBJECT_COUNT}

warp analyze  warp-mixed*.csv.zst  --analyze.out=results.tab

cat results.tab | grep -v '#'|   tr '\t' ',' > results.csv
csvcut results.csv  -Cindex > cut.csv
head -1 cut.csv > data.csv

cat cut.csv | grep -v ops_started >> data.csv

cat table.sql | mysql -h ${DBHOST} -u ${DBUSER} -p"${DBPASS}" ${DBNAME}
csvsql --db "mysql+mysqlconnector://${DBUSER}:${DBPASS}@${DBHOST}/${DBNAME}" --tables s3bench --insert data.csv --no-create