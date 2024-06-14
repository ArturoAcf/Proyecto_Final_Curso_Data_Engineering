with stg_rs as(
    select * from {{ref('stg_rockets')}}
),

stg_rocket_status as(
    select distinct
        {{dbt_utils.generate_surrogate_key(['rocket_status'])}} as rocket_status_id,
        rocket_status
    from stg_rs
)

select * from stg_rocket_status