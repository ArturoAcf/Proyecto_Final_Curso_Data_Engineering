with stg_spag as(
    select * from {{ref('stg_space_agencies')}}
),

dim_space_agencies as(
    select
        agency_name_id as agency_id,
        agency_name,
        first_launch_date,
        last_launch_date,
        years_of_service
    from stg_spag
)

select * from dim_space_agencies