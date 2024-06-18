with location_source as(
    select country from {{ref('int_locations')}}
),

stg_as as(
    select astronaut_nationality from {{ref('stg_astronauts')}}
),

location_data as(
    select distinct
        {{dbt_utils.generate_surrogate_key(['country'])}} as country_id,
        country
    from location_source
    union
    select distinct
        {{dbt_utils.generate_surrogate_key(['astronaut_nationality'])}} as country_id,
        astronaut_nationality 
    from stg_as
)

select * from location_data
