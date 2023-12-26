The Following Environmental Variables are needed on your spark container:

```bash
# AWS_REGION is used by Spark
AWS_REGION=us-east-1
# Used by pyIceberg
AWS_DEFAULT_REGION=us-east-1
# AWS Credentials (this can use minio credential, to be filled in later)
AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXX
AWS_SECRET_ACCESS_KEY=xxxxxxx
```

AND THE FOLLOWING ENVIRONMENT VARIABLES IN THE MINIO CONTAINER

```bash
MINIO_ROOT_USER=admin
MINIO_ROOT_PASSWORD=password
MINIO_REGION=us-east-1
MINIO_REGION_NAME=us-east-1
```

```py
import pyspark
from pyspark.sql import SparkSession
import os


## DEFINE SENSITIVE VARIABLES
NESSIE_URI = "http://172.17.0.4:19120/api/v1"
WAREHOUSE = "s3a://warehouse/"
AWS_ACCESS_KEY = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")
AWS_S3_ENDPOINT= "http://172.17.0.3:9000"





conf = (
    pyspark.SparkConf()
        .setAppName('app_name')
        .set('spark.jars.packages', 'org.apache.iceberg:iceberg-spark-runtime-3.4_2.12:1.4.2,org.projectnessie.nessie-integrations:nessie-spark-extensions-3.4_2.12:0.75.0,software.amazon.awssdk:bundle:2.17.178,software.amazon.awssdk:url-connection-client:2.17.178')
        .set('spark.sql.extensions', 'org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions')
        .set('spark.sql.catalog.nessie', 'org.apache.iceberg.spark.SparkCatalog')
        .set('spark.sql.catalog.nessie.uri', NESSIE_URI)
        .set('spark.sql.catalog.nessie.ref', 'main')
        .set('spark.sql.catalog.nessie.authentication.type', 'NONE')
        .set('spark.sql.catalog.nessie.catalog-impl', 'org.apache.iceberg.nessie.NessieCatalog')
        .set('spark.sql.catalog.nessie.s3.endpoint', AWS_S3_ENDPOINT)
        .set('spark.sql.catalog.nessie.warehouse', WAREHOUSE)
        .set('spark.sql.catalog.nessie.io-impl', 'org.apache.iceberg.aws.s3.S3FileIO')
)


## Start Spark Session
spark = SparkSession.builder.config(conf=conf).getOrCreate()
print("Spark Running")


## Create a Table
spark.sql("CREATE TABLE nessie.testnames (name STRING) USING iceberg;").show()


## Insert Some Data
spark.sql("INSERT INTO nessie.testnames VALUES ('Alex Merced'), ('Tomer Shiran'), ('Jason Hughes')").show()


## Query the Data
spark.sql("SELECT * FROM nessie.testnames;").show()
```