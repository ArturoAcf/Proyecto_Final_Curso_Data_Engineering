with int_loc as(
    select * from {{ref('int_locations')}}
),

int_location as(
    select distinct
        location_id,
        mission_location,
        address,
        place,
        state_or_city, 
        {{dbt_utils.generate_surrogate_key(['country'])}} as country_id
    from int_loc
)

select * from int_location