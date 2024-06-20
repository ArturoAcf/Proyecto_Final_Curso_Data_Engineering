with stg_rockets as(
    select * from {{ref('stg_rockets')}}
),

stg_spm as(
    select mission_rocket from {{ref('stg_space_missions')}}
),

dim_rockets as(
    select
        rocket_id,
        rocket_name,
        company_name,
        rocket_status,
        liftoff_thrust,
        payload_to_leo,
        stages,
        strap_ons,
        rocket_height,
        rocket_price_millon_dollars,
        payload_to_gto,
        fairing_diameter,
        fairing_height,
        loaded_at,
        dbt_valid_from,
        dbt_valid_to
    from stg_rockets
    where stg_rockets.dbt_valid_to is null
    union 
    select 
        {{dbt_utils.generate_surrogate_key(['mission_rocket'])}},
        mission_rocket,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
    from stg_spm 
    where mission_rocket not in (select rocket_name name from stg_rockets)
)

select * from dim_rockets
