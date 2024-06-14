with base_as as(
    select * from {{source('data_sources', 'mission_astronauts')}}
),

base_astronauts as(
    select
        profile_astronaut_numbers_overall as world_astronaut_number,
        profile_astronaut_numbers_nationwide as nation_astronaut_number,
        profile_name as astronaut_name,
        profile_gender as astronaut_gender,
        profile_birth_year as astronaut_birth_year,
        profile_nationality as astronaut_nationality,
        profile_military as astronaut_is_militar,
        profile_selection_group as astronaut_selection_group,
        profile_selection_year as astronaut_selection_year,
        profile_lifetime_statistics_mission_count as astronaut_mission_count,
        mission_role,
        mission_year,
        mission_name,
        mission_vechicles_ascent as mission_vehicles_ascent,
        mission_vechicles_orbit as mission_vehicles_orbit,
        mission_vechicles_decent as mission_vehicles_decent,
        mission_durations_mission_duration as mission_duration_hours,
        profile_lifetime_statistics_mission_duration as astronaut_total_hours_in_space,
        mission_durations_eva_duration as mission_duration_hours_eva,
        profile_lifetime_statistics_eva_duration as astronaut_total_hours_in_space_eva
    from base_as
)

select * from base_astronauts