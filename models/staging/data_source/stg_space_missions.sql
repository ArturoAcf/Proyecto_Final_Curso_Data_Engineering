with base_spm as(
    select * from {{ref('base_space_missions')}}
),

base_space_missions as(
    select
        {{dbt_utils.generate_surrogate_key(['mission_name', 'mission_date'])}}
        mission_name,
        company_name,
        mission_location,
        mission_date,
        misison_time,
        mission_rocket,
        -- mission_rocket_status, -- Desaparecerá
        mission_price_millions,
        mission_status
    from base_spm
)

select * from base_space_missions