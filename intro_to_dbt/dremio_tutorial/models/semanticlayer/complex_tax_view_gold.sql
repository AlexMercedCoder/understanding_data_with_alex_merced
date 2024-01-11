{{ config(database='tax_collections', schema='gold')}}

SELECT
    'Individual' AS taxpayer_type,
    taxpayer_id AS id,
    full_name AS name,
    income,
    tax_paid
FROM {{ ref('individual_tax_silver') }}
UNION ALL
SELECT
    'Business' AS taxpayer_type,
    business_id AS id,
    business_name AS name,
    revenue AS income,
    tax_paid
FROM {{ ref('business_tax_silver') }}