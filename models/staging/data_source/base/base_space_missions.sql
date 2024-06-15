with base_spm as(
    select * from {{source('data_sources', 'space_missions')}}
),

base_space_missions as(
    select
        mission as mission_name,
        company as company_name,
        location as mission_location,
        date as mission_date,
        time as mission_time,
        rocket as mission_rocket,
        rocketstatus as mission_rocket_status,
        price as mission_price_millions,
        missionstatus as mission_status
    from base_spm
)

select * from base_space_missions