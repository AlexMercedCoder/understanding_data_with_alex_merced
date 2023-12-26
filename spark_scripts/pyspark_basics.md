```py
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import Row

conf = (
    pyspark.SparkConf()
        .setAppName('iceberg_with_file_system')
  		#packages
        .set('spark.jars.packages', 'org.apache.iceberg:iceberg-spark-runtime-3.4_2.12:1.4.2')
  		#SQL Extensions
        .set('spark.sql.extensions', 'org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions')
  		#Configuring Catalog
        .set('spark.sql.catalog.iceberg', 'org.apache.iceberg.spark.SparkCatalog')
        .set('spark.sql.catalog.iceberg.type', 'hadoop')
        .set('spark.sql.catalog.iceberg.warehouse', 'iceberg-warehouse')
)

## Start Spark Session
spark = SparkSession.builder.config(conf=conf).getOrCreate()
print("Spark Running")

## Run a Query
spark.sql("CREATE TABLE IF NOT EXISTS iceberg.names (name STRING) USING iceberg;").show()

## Insert a record with SQL
spark.sql("INSERT INTO iceberg.names VALUES ('Alex Merced')")

## Insert a record with dataframe api
df = spark.createDataFrame([Row(name="Tony Merced")])
df.writeTo("iceberg.names").append()

## Querying the table
spark.sql("SELECT * FROM iceberg.names;").show()
```

## Explanation
**SparkSession Initialization:** Creates an instance of SparkSession, which is the entry point for Spark functionality.

**Creating a DataFrame:** A simple DataFrame is created from a list of Row objects. This DataFrame contains two columns, name and age.

**DataFrame Operations:** The DataFrame is shown using show() method.

**Writing DataFrame to Temp View:** The DataFrame is written to a temporary view (in-memory table) named people, allowing it to be queried using SQL syntax.

**Reading with SQL API:** The script uses spark.sql() to run an SQL query on the temporary view, selecting people older than 28.

**Reading with DataFrame API:** The script also demonstrates achieving the same result using the DataFrame API, using the filter() method.

**Stopping SparkSession:** Finally, the script stops the SparkSession, releasing the resources.

This script serves as a basic introduction to using both SQL and DataFrame APIs in PySpark for simple data processing tasks. Make sure you have a Spark environment set up to run this script.