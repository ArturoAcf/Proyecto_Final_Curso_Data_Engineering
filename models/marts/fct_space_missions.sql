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
        -- imas.mission_id,
        imas.astronaut_name,
        -- imas.mission_name,
        -- imas.mission_date,
        -- imas.company_name,
        -- imas.mission_location,
        -- imas.misison_time,
        -- imas.mission_rocket,
        -- imas.mission_price_millions,
        -- imas.mission_status,
        imas.mission_role,
        -- imas.mission_year,
        imas.mission_vehicles_ascent,
        imas.mission_vehicles_orbit,
        imas.mission_vehicles_decent,
        imas.mission_duration_hours,
        imas.mission_duration_hours_eva,

        ispm.mission_id,
        ispm.mission_name,
        ispm.mission_date,
        ispm.company_name,
        ispm.mission_location,
        ispm.misison_time,
        ispm.mission_rocket,
        ispm.mission_price_millions,
        ispm.mission_status
    from int_space_missions ispm
    full outer join int_mission_astronauts imas
    on ispm.mission_name = imas.mission_name
)

select * from fct_space_missions