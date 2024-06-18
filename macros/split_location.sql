{% macro split_location(location) %}
    case
        when split_part({{location}}, ',', 3)<>'' or split_part({{location}}, ',', 4)<>'' then split_part({{location}}, ',', 1)
        else null
    end as address,
    case
        when split_part({{location}}, ',', 3)<>'' or split_part({{location}}, ',', 4)<>'' then split_part({{location}}, ',', 2)
        when split_part({{location}}, ',', 2)<>'' then split_part({{location}}, ',', 1)
        else null
    end as place,
    case
        when split_part({{location}}, ',', 4)<>'' then split_part({{location}}, ',', 3)
        when split_part({{location}}, ',', 3)<>'' and split_part({{location}}, ',', 4)='' then null
        when split_part({{location}}, ',', 3)<>'' then split_part({{location}}, ',', 3)
        else null
    end as state_or_city,
    case
        when split_part({{location}}, ',', 4)<>'' then split_part({{location}}, ',', 4)
        when split_part({{location}}, ',', 3)<>'' then split_part({{location}}, ',', 3)
        else split_part({{location}}, ',', 2)
    end as country
{% endmacro %}