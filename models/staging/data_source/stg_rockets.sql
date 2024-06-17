with base_rockets as(
    select * from {{ref('base_rockets')}}
),

stg_rockets as(
    select
        {{dbt_utils.generate_surrogate_key(['rocket_name'])}} as rocket_id,
        rocket_name,
        company_name,
        rocket_status,
        liftoff_thrust,
        payload_to_leo,
        stages,
        strap_ons,
        rocket_height,
        cast(replace(replace(replace(rocket_price, '$', ''), 'million', ''), ',', '') as decimal) as rocket_price_millon_dollars,
        payload_to_gto,
        fairing_diameter,
        fairing_height,
        loaded_at
    from base_rockets
)

select * from stg_rockets