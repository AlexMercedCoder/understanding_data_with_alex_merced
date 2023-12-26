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

# Read the file
parquet_file_path = "../sampledata/Worker_Coops.csv"
df = spark.read.format("csv").option("header", "true").load(parquet_file_path)

# Create a temporary view using the DataFrame
df.createOrReplaceTempView("wv_view")

## Create a Table with matching schema but no records
spark.sql("CREATE TABLE IF NOT EXISTS nessie.worker_coop AS (SELECT * FROM wv_view LIMIT 0)").show()

## Create a Branch
spark.sql("CREATE BRANCH IF NOT EXISTS dev IN nessie")

## Use Branch
spark.sql("USE REFERENCE dev IN nessie")

## Insert Some Data
spark.sql("INSERT INTO nessie.worker_coop SELECT * FROM wv_view").show()

## Query the Data
spark.sql("SELECT * FROM nessie.worker_coop").show()

## Use Branch
spark.sql("USE REFERENCE main IN nessie")

## Query the Data
spark.sql("SELECT * FROM nessie.worker_coop").show()

## Merge the Data
spark.sql("MERGE BRANCH dev INTO main IN nessie")

#########

## Query the Data
spark.sql("SELECT * FROM nessie.worker_coop").show()
```