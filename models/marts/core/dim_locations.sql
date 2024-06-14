with stg_loc as(
    select * from {{ref('stg_space_missions')}}
),

stg_location as(
    select distinct
        {{dbt_utils.generate_surrogate_key(['mission_location'])}} as location_id,
        mission_location,
        SPLIT_PART(mission_location, ',', 1) AS address,
        SPLIT_PART(mission_location, ',', 2) AS place,
        CASE
            WHEN SPLIT_PART(mission_location, ',', 4) = '' THEN NULL
            ELSE SPLIT_PART(mission_location, ',', 3)
        END AS state_or_city,
        CASE
            WHEN SPLIT_PART(mission_location, ',', 4) = '' THEN SPLIT_PART(mission_location, ',', 3)
            ELSE SPLIT_PART(mission_location, ',', 4)
        END AS country
    from stg_loc
)

select * from stg_location