{{ config(database='tax_collections', schema='bronze')}}

SELECT * from warehouse.output."business_tax"