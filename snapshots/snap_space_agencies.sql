{{config(
    materialized= 'incremental',
    unique_key = ['agency_name_id']
)}}

{% snapshot space_agencies %}

{{
    config(
      target_schema='snapshots',
      unique_key='agency_name_id',
      strategy='timestamp',
      updated_at='loaded_at',
    )
}}

select 
    {{dbt_utils.generate_surrogate_key(['agency_name'])}} as agency_name_id,
    agency_name,
    first_launch_date,
    last_launch_date,
    years_of_service,
    loaded_at
from {{ref('base_space_agencies')}}

{% if is_incremental() %}
  where loaded_at >= (select max(loaded_at) from {{ this }})
{% endif %}

{% endsnapshot %}

