with base_mas as(
    select * from {{ref('base_mission_astronauts')}}
),

base_space_missions as(
    select * from {{ref('base_space_missions')}}
),

stg_mission_astronauts as(
    select
        {{dbt_utils.generate_surrogate_key(['basemas.astronaut_name', 'basemas.world_astronaut_number', 'basemas.nation_astronaut_number', 'basemas.astronaut_mission_count'])}} as astronaut_id,
        {{dbt_utils.generate_surrogate_key(['basespm.mission_name', 'basespm.mission_date'])}} as mission_id,
        basemas.astronaut_name,
        basemas.world_astronaut_number,
        basemas.nation_astronaut_number,
        basemas.astronaut_mission_count,
        basespm.mission_name,
        basespm.mission_date,
        basespm.company_name,
        basespm.mission_location,
        basespm.mission_time,
        basespm.mission_rocket,
        basespm.mission_price_millions,
        basespm.mission_status,
        basemas.mission_role,
        basemas.mission_year,
        basemas.mission_vehicles_ascent,
        basemas.mission_vehicles_orbit,
        basemas.mission_vehicles_descent,
        basemas.mission_duration_hours,
        basemas.mission_duration_hours_eva,
        basemas.astronaut_selection_group,
        basemas.astronaut_selection_year,
    from base_mas basemas
    join
    base_space_missions basespm
    on basemas.mission_name = basespm.mission_name
)

select * from stg_mission_astronauts