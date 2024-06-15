with stg_mas as(
    select * from {{ref('stg_mission_astronauts')}}
),

stg_space_missions as(
    select * from {{ref('stg_space_missions')}}
),

int_mission_astronauts as(
    select
        {{dbt_utils.generate_surrogate_key(['stgmas.astronaut_name', 'stgmas.world_astronaut_number', 'stgmas.nation_astronaut_number', 'stgmas.astronaut_mission_count'])}} as astronaut_id,
        {{dbt_utils.generate_surrogate_key(['stgspm.mission_name', 'stgspm.mission_date'])}} as mission_id,
        stgmas.astronaut_name,
        stgmas.world_astronaut_number,
        stgmas.nation_astronaut_number,
        stgspm.mission_name,
        stgspm.mission_date,
        stgspm.company_name,
        stgspm.mission_location,
        stgspm.mission_time,
        stgspm.mission_rocket,
        stgspm.mission_price_millions,
        stgspm.mission_status,
        stgmas.mission_role,
        stgmas.mission_year,
        stgmas.mission_vehicles_ascent,
        stgmas.mission_vehicles_orbit,
        stgmas.mission_vehicles_descent,
        stgmas.mission_duration_hours,
        stgmas.mission_duration_hours_eva,
        stgmas.astronaut_selection_group,
        stgmas.astronaut_selection_year
    from stg_mas stgmas
    join
    stg_space_missions stgspm
    on stgmas.mission_name = stgspm.mission_name
)

select * from int_mission_astronauts