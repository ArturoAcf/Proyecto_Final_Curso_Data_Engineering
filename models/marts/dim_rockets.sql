with stg_rockets as(
    select * from {{ref('stg_rockets')}}
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
        fairing_height
    from stg_rockets
)

select * from dim_rockets