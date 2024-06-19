{% snapshot rockets %}

{{
    config(
      target_schema='snapshots',
      unique_key='rocket_id',
      strategy='timestamp',
      updated_at='loaded_at',
    )
}}

select 
    {{dbt_utils.generate_surrogate_key(['rocket_name'])}} as rocket_id,
    rocket_name,
    company_name,
    rocket_status,
    liftoff_thrust,
    payload_to_leo,
    stages,
    strap_ons,
    rocket_height,
    rocket_price,
    payload_to_gto,
    fairing_diameter,
    fairing_height,
    loaded_at
from {{ref('base_rockets')}}

{% endsnapshot %}

{% if is_incremental() %}
    where loaded_at >= (select max(loaded_at) from {{ this }})
{% endif %}