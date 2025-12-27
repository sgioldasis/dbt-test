{{ config(
    materialized='table',
    alias='test1_age_groups'
) }}

with age_buckets as (
    select
        case
            when age < 20 then 'under 20'
            when age between 20 and 29 then '20-30'
            when age between 30 and 39 then '30-40'
            when age >= 40 then 'over 40'
        end as age_group
    from {{ source('raw', 'test1') }}   -- ← fixed reference
)

select
    age_group,
    count(*) as user_count
from age_buckets
group by age_group
order by age_group
