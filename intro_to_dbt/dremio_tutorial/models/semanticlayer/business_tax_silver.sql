{{ config(database='tax_collections', schema='silver')}}

SELECT
    business_id,
    business_name,
    COALESCE(revenue, 0) AS revenue, -- Replacing NULL revenue with 0
    GREATEST(tax_paid, 0) AS tax_paid -- Correcting negative tax_paid
FROM {{ ref('business_tax_bronze') }}