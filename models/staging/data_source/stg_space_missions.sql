with base_spm as(
    select * from {{ref('base_space_missions')}}
),

base_space_missions as(
    select
        {{dbt_utils.generate_surrogate_key(['mission_name', 'mission_date', 'mission_time'])}} as mission_id,
        replace(mission_name, '�', 'é') as mission_name,
        mission_date,
        replace(company_name, 'Arm�e de l''Air', 'Armée de l''Air') as company_name,
        mission_location,
        mission_time,
        mission_rocket,
        mission_price_millions,
        mission_status,
        loaded_at
    from base_spm
)

select * from base_space_missions