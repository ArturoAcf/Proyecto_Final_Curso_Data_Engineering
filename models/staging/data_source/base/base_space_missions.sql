with stg_space_missions as(
    select * from {{source('data_sources', 'space_missions')}}
),

base_space_missions as(
    select
        company,
        location,
        date,
        time,
        rocket,
        mission,
        rocketstatus,
        price,
        missionstatus
    from stg_space_missions
)

select * from base_space_missions