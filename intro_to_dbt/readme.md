## DBT - Data Build Tool

[More dbt-dremio reference](https://github.com/developer-advocacy-dremio/quick-guides-from-dremio/blob/main/guides/dbt.md)

- Setup Dremio Locally on our Laptop
- Configure our DBT Profile

## Setup Dremio

- Create a `docker-compose.yml`

```yml
version: "3"

services:
  # Nessie Catalog Server Using In-Memory Store
  catalog:
    image: projectnessie/nessie:0.76.0
    container_name: catalog
    networks:
      dremio-laptop-lakehouse:
    ports:
      - 19120:19120
  # Minio Storage Server
  storage:
    image: minio/minio:RELEASE.2024-01-01T16-36-33Z
    container_name: storage
    environment:
      - MINIO_ROOT_USER=admin
      - MINIO_ROOT_PASSWORD=password
      - MINIO_DOMAIN=storage
      - MINIO_REGION_NAME=us-east-1
      - MINIO_REGION=us-east-1
    networks:
      dremio-laptop-lakehouse:
    ports:
      - 9001:9001
      - 9000:9000
    command: ["server", "/data", "--console-address", ":9001"]
  # Dremio
  dremio:
    platform: linux/x86_64
    image: dremio/dremio-oss:latest
    ports:
      - 9047:9047
      - 31010:31010
      - 32010:32010
    container_name: dremio
    networks:
      dremio-laptop-lakehouse:
networks:
  dremio-laptop-lakehouse:

```

- [Directions for Dremio Setup](https://github.com/developer-advocacy-dremio/quick-guides-from-dremio/blob/main/guides/nessie_dremio.md)

## Setup Python Environment, install dbt

- `python -m venv venv`

- `source ./venv/bin/activate`

- `pip install dbt-dremio`

## Create a dbt project

- `dbt init <projectname>`

- select dremio

- select dremio with software username/password

- put `127.0.0.1` as host

- use `9047` as port

- put username and password

- use the name of a nessie/metastore/object storage source for "object_storage_soure"

- write a path to a subfolder in that source for "object_storage_path"

- write the name of a space for "dremio_space"

- write the path to a subfolder in your space for "dremio_space_path"

- select 1 thread

## dbt function

**{{ config() }}**

Configures the behavior for the following model.

Example Arguments:

- `materialized`: `view` to create a sql view or `table` to create a table

- `database`: The dremio space (view) or source (table) to create the result in

- `schema`: the path to a subfolder in the source to out the results.

**{{ ref() }}**

Reference to a source model. This ensure that the referenced model will be run before this model.

### Example SQL

```sql
-- Creating bronze tables for local tax data
-- Bronze Table 1: Individual Tax Records
CREATE TABLE individual_tax (
    taxpayer_id INT,
    full_name VARCHAR,
    income FLOAT,
    tax_paid FLOAT
);

-- Bronze Table 2: Business Tax Records
CREATE TABLE business_tax (
    business_id INT,
    business_name VARCHAR,
    revenue FLOAT,
    tax_paid FLOAT
);

-- Inserting flawed data into bronze tables
-- Inserting data into Individual Tax Records
INSERT INTO individual_tax (taxpayer_id, full_name, income, tax_paid) VALUES
(1, 'John Doe', 50000, 5000),
(2, 'Jane Smith', NULL, 4500), -- Missing income
(3, 'Alice Johnson', 70000, -700); -- Negative tax paid (flawed)

-- Inserting data into Business Tax Records
INSERT INTO business_tax (business_id, business_name, revenue, tax_paid) VALUES
(101, 'ABC Corp', 200000, 20000),
(102, 'XYZ Inc', NULL, 18000), -- Missing revenue
(103, 'Acme LLC', 150000, -1500); -- Negative tax paid (flawed)

-- Creating silver views to clean up the data
-- Silver View 1: Cleaned Individual Tax Records
CREATE VIEW individual_tax AS
SELECT
    taxpayer_id,
    full_name,
    COALESCE(income, 0) AS income, -- Replacing NULL income with 0
    GREATEST(tax_paid, 0) AS tax_paid -- Correcting negative tax_paid
FROM arctic."Tax Collections".bronze.individual_tax;

-- Silver View 2: Cleaned Business Tax Records
CREATE VIEW business_tax AS
SELECT
    business_id,
    business_name,
    COALESCE(revenue, 0) AS revenue, -- Replacing NULL revenue with 0
    GREATEST(tax_paid, 0) AS tax_paid -- Correcting negative tax_paid
FROM arctic."Tax Collections".bronze.business_tax;

-- Creating a gold view: Consolidated Tax Records
CREATE VIEW tax_records AS
SELECT
    'Individual' AS taxpayer_type,
    taxpayer_id AS id,
    full_name AS name,
    income,
    tax_paid
FROM individual_tax
UNION ALL
SELECT
    'Business' AS taxpayer_type,
    business_id AS id,
    business_name AS name,
    revenue AS income,
    tax_paid
FROM business_tax;
```