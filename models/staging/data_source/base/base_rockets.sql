with base_rockets as(
    select * from {{source('data_sources', 'rockets_from_1957')}}
),

base_rc as(
    select
        _row,
        name as rocket_name,
        cmp as company_name,
        wiki,
        status as rocket_status,
        liftoff_thrust,
        payload_to_leo,
        stages,
        strap_ons,
        rocket_height,
        price as rocket_price,
        payload_to_gto,
        fairing_diameter,
        fairing_height,
        loaded_at
    from base_rockets
)

select * from base_rc