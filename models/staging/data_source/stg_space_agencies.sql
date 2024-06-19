{{config(
    materialized = 'incremental',
    unique_key = ['agency_name_id', 'dbt_valid_to']
)}}

with snap_spag as(
    select * from {{ref('space_agencies')}}
),

stg_space_agencies as(
    select
        agency_name_id,
        agency_name,
        first_launch_date,
        last_launch_date,
        years_of_service,
        loaded_at,
        dbt_valid_from,
        dbt_valid_to
    from snap_spag
)

select * from stg_space_agencies

{% if is_incremental() %}
    where loaded_at >= (select max(loaded_at) from {{ this }})
{% endif %}