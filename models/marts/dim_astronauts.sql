with stg_as as(
    select * from {{ref('stg_astronauts')}}
),

dim_astronauts as(
    select distinct
        astronaut_id,
        astronaut_name,
        world_astronaut_number,
        nation_astronaut_number,
        astronaut_gender,
        astronaut_birth_year,
        astronaut_nationality,
        astronaut_is_militar,
        astronaut_mission_count,
        astronaut_total_hours_in_space,
        astronaut_total_hours_in_space_eva
    from stg_as
)

select * from dim_astronauts