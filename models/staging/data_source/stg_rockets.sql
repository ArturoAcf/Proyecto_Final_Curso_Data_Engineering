with snap_rockets as(
    select * from {{ref('rockets')}}
),

stg_rockets as(
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
        cast(replace(replace(replace(rocket_price, '$', ''), 'million', ''), ',', '') as decimal) as rocket_price_millon_dollars,
        payload_to_gto,
        fairing_diameter,
        fairing_height,
        loaded_at,
        dbt_valid_from,
        dbt_valid_to
    from snap_rockets
)

select * from stg_rockets
