## Spark/Iceberg Writing Tables to Local Filesystem

```py
import pyspark
from pyspark.sql import SparkSession
import os

conf = (
    pyspark.SparkConf()
        .setAppName('app_name')
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
spark.sql("CREATE TABLE iceberg.names (name STRING) USING iceberg;").show()
```

The provided Python script is for setting up and using Apache Spark with Iceberg, an open-source table format for huge analytic datasets.

```python
import pyspark
from pyspark.sql import SparkSession
import os
```

The script starts by importing necessary modules:

- pyspark: The main PySpark package.
- SparkSession: Used for initializing the main entry point for DataFrame and SQL functionality.
- os: This module provides a way of using operating system-dependent functionality (though it's not used in the script).

```python
conf = (
    pyspark.SparkConf()
        .setAppName('app_name')
        #packages
        .set('spark.jars.packages', 'org.apache.iceberg:iceberg-spark-runtime-3.4_2.12:1.4.2')
        #SQL Extensions
        .set('spark.sql.extensions', 'org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions')
        #Configuring Catalog
        .set('spark.sql.catalog.iceberg', 'org.apache.iceberg.spark.SparkCatalog')
        .set('spark.sql.catalog.iceberg.type', 'hadoop')
        .set('spark.sql.catalog.iceberg.warehouse', 'iceberg-warehouse')
)
```

This section creates a Spark configuration object (SparkConf):

- `.setAppName('app_name')`: Sets the name of the application.
- `.set('spark.jars.packages', ...)`: Specifies the Iceberg package for Spark runtime.
- `.set('spark.sql.extensions', ...)`: Sets SQL extensions for Iceberg integration.
- `.set('spark.sql.catalog.iceberg', ...)`: Configures the Spark catalog to use Iceberg.
- `.set('spark.sql.catalog.iceberg.type', 'hadoop')`: Specifies that Iceberg uses the Hadoop catalog type.
- `.set('spark.sql.catalog.iceberg.warehouse', 'iceberg-warehouse')`: Sets the location of the Iceberg warehouse.

```python
Copy code
## Start Spark Session
spark = SparkSession.builder.config(conf=conf).getOrCreate()
print("Spark Running")
```

- Initializes a SparkSession with the above configuration. If a session already exists, it retrieves that session.

- Prints "Spark Running" to confirm the Spark session is active.

```python
## Run a Query
spark.sql("CREATE TABLE iceberg.names (name STRING) USING iceberg;").show()
```

- Executes a SQL query using Spark's SQL capabilities.

- The query creates a new table named iceberg.names with a single column name of type STRING, using the Iceberg format.

- `.show()` displays the results of the query (if any). In this case, it might show the status of the table creation.
