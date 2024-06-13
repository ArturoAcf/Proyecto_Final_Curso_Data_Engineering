with base_sag as(
    select * from {{source('data_sources', 'space_agencies')}}
),

base_s_agencies as(
    select
        _row,
        agency as agency_name,
        first_launch,
        last_launch,
        years_of_service
    from base_sag
)

select * from base_s_agencies