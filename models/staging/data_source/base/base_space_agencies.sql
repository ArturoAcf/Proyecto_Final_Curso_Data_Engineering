with base_sag as(
    select * from {{source('data_sources', 'space_agencies')}}
),

base_s_agencies as(
    select
        _row,
        replace(agency, 'Arm??e de l''Air', 'Armée de l''Air') agency_name,
        first_launch as first_launch_date,
        last_launch as last_launch_date,
        years_of_service,
        loaded_at
    from base_sag
)

select * from base_s_agencies