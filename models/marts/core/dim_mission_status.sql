with stg_ms as(
    select * from {{ref('stg_space_missions')}}
),

stg_mission_status as(
    select distinct
        {{dbt_utils.generate_surrogate_key(['mission_status'])}} as mission_status_id,
        mission_status
    from stg_ms
)

select * from stg_mission_status