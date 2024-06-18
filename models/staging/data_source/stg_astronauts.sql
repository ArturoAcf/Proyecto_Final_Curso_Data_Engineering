with stg_as as(
    select * from {{ref('base_mission_astronauts')}}
),

stg_astronauts as(
    select distinct
        {{dbt_utils.generate_surrogate_key(['astronaut_name', 'world_astronaut_number', 'nation_astronaut_number', 'astronaut_mission_count'])}} as astronaut_id,
        astronaut_name,
        world_astronaut_number,
        nation_astronaut_number,
        astronaut_gender,
        astronaut_birth_year,
        replace(astronaut_nationality, 'U.S.', 'USA') as astronaut_nationality,
        astronaut_is_militar,
        astronaut_mission_count,
        astronaut_total_hours_in_space,
        astronaut_total_hours_in_space_eva,
        loaded_at
    from stg_as
)

select * from stg_astronauts