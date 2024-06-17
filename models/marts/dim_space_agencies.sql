with stg_spag as(
    select * from {{ref('stg_space_agencies')}}
),

stg_spm as(
    select company_name from {{ref('stg_space_missions')}}
),

dim_space_agencies as(
    select
        agency_name_id as agency_id,
        agency_name,
        first_launch_date,
        last_launch_date,
        years_of_service,
        loaded_at
    from stg_spag
    union
    select distinct 
        {{dbt_utils.generate_surrogate_key(['company_name'])}},
        company_name,
        null,
        null,
        null,
        null
    from stg_spm
    where company_name not in (select agency_name from stg_spag)
)

select * from dim_space_agencies