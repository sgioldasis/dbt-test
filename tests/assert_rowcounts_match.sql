-- tests/assert_rowcounts_match.sql
select *
from (
    select abs(
             (select count(*) from {{ source('raw', 'test1') }}) -
             (select sum(user_count) from {{ ref('test1_age_groups') }})
           ) as diff
) t
where diff <> 0
