with 

int_space_missions as(
    select * from {{ref('int_space_missions')}}
),

int_mission_astronauts as(
    select * from {{ref('int_mission_astronauts')}}
),

fct_space_missions as(
    select
        imas.astronaut_id,
        {{dbt_utils.generate_surrogate_key(['imas.mission_role'])}} as astronaut_role_id,
        {{dbt_utils.generate_surrogate_key(['imas.mission_vehicles_ascent'])}} as ascent_vehicle_id,
        {{dbt_utils.generate_surrogate_key(['imas.mission_vehicles_orbit'])}} as orbit_vehicle_id,
        {{dbt_utils.generate_surrogate_key(['imas.mission_vehicles_descent'])}} as descent_vehicle_id,
        imas.mission_duration_hours,
        imas.mission_duration_hours_eva,
        ispm.mission_id,
        ispm.mission_name,
        ispm.mission_date,
        {{dbt_utils.generate_surrogate_key(['ispm.company_name'])}} as company_name_id,
        {{dbt_utils.generate_surrogate_key(['ispm.mission_location'])}} as mission_location_id,
        ispm.mission_time,
        {{dbt_utils.generate_surrogate_key(['ispm.mission_rocket'])}} as mission_rocket_id,
        ispm.mission_price_millions,
        {{dbt_utils.generate_surrogate_key(['ispm.mission_status'])}} as mission_status_id,
        imas.astronaut_selection_group,
        imas.astronaut_selection_year,
        ispm.loaded_at
    from int_space_missions ispm
    full outer join int_mission_astronauts imas
    on ispm.mission_name = imas.mission_name
)

select * from fct_space_missions