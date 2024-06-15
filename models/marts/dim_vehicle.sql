with stg_mas as(
    select * from {{ref('stg_mission_astronauts')}}
),

combined_values as(
    select mission_vehicles_ascent as value from stg_mas
    union
    select mission_vehicles_orbit as value from stg_mas
    union
    select mission_vehicles_descent as value from stg_mas
),

dim_vehicle as(
    select distinct value from combined_values
)

select
    {{dbt_utils.generate_surrogate_key(['value'])}} as vehicle_id, 
    value
from dim_vehicle
