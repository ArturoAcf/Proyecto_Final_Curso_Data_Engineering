with stg_mas as(
    select * from {{ref('stg_mission_astronauts')}}
),

dim_astronauts_roles as(
    select distinct
        {{dbt_utils.generate_surrogate_key(['mission_role'])}} as role_id,
        mission_role
    from stg_mas 
)

select * from dim_astronauts_roles