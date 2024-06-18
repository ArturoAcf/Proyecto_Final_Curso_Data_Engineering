with stg_spm as(
    select * from {{ref('stg_space_missions')}}
),

int_space_missions as(
    select
        mission_id,
        mission_name,
        mission_date,
        company_name,
        {{dbt_utils.generate_surrogate_key(['company_name'])}} as company_name_id,
        mission_location,
        mission_time,
        mission_rocket,
        mission_price_millions,
        mission_status,
        loaded_at
    from stg_spm
)

select * from int_space_missions