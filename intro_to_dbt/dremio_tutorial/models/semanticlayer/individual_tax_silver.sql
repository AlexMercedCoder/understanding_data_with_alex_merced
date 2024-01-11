{{ config(database='tax_collections', schema='silver')}}

SELECT
    taxpayer_id,
    full_name,
    COALESCE(income, 0) AS income, -- Replacing NULL income with 0
    GREATEST(tax_paid, 0) AS tax_paid -- Correcting negative tax_paid
FROM {{ ref('individual_tax_bronze') }}