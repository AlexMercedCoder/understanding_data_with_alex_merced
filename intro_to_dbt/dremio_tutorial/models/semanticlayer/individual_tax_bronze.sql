{{ config(database='tax_collections', schema='bronze')}}

SELECT * from warehouse.output."individual_tax"