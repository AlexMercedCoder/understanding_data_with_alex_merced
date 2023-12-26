```py
from pyspark.sql import SparkSession
from pyspark.sql import Row

# Initialize a SparkSession
spark = SparkSession.builder \
    .appName("PySpark SQL and DataFrame API Example") \
    .getOrCreate()

# Create a simple DataFrame
data = [Row(name="Alice", age=25),
        Row(name="Bob", age=30),
        Row(name="Charlie", age=35)]

df = spark.createDataFrame(data)

# Show the DataFrame
print("DataFrame:")
df.show()

# Writing DataFrame to a temporary view
df.createOrReplaceTempView("people")

# Using SQL API to query the DataFrame
print("SQL API output:")
spark.sql("SELECT * FROM people WHERE age > 28").show()

# Alternatively, using DataFrame API to perform the same query
print("DataFrame API output:")
df.filter(df.age > 28).show()

# Stop the SparkSession
spark.stop()
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