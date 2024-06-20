{{config(
    materialized = 'incremental',
    unique_key = ['agency_name_id', 'agency_name']
)}}

with base_spag as(
    select * from {{ref('base_space_agencies')}}
),

stg_space_agencies as(
    select
        {{dbt_utils.generate_surrogate_key(['agency_name'])}} as agency_name_id,
        agency_name,
        first_launch_date,
        last_launch_date,
        years_of_service,
        loaded_at
    from base_spag
)

select * from stg_space_agencies

{% if is_incremental() %}
    where loaded_at >= (select max(loaded_at) from {{ this }})
{% endif %}