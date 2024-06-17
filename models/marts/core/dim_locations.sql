with stg_loc as(
    select * from {{ref('stg_space_missions')}}
),

stg_location as(
    select distinct
        {{dbt_utils.generate_surrogate_key(['mission_location'])}} as location_id,
        mission_location,
        split_part(mission_location, ',', 1) as address,
        split_part(mission_location, ',', 2) as place,
        case
            when split_part(mission_location, ',', 4) = '' then null
            else split_part(mission_location, ',', 3)
        end as state_or_city,
        case
            when split_part(mission_location, ',', 4) = '' then split_part(mission_location, ',', 3)
            else split_part(mission_location, ',', 4)
        end as country
    from stg_loc
)

select * from stg_location