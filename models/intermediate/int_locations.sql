with stg_loc as(
    select mission_location from {{ref('stg_space_missions')}}
),

stg_location as(
    select distinct
        {{dbt_utils.generate_surrogate_key(['mission_location'])}} as location_id,
        mission_location,
        {{split_location('mission_location')}}
    from stg_loc
)

select * from stg_location