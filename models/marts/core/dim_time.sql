{{
    config(
        materialized="table"
    )
}}
{{ dbt_date.get_date_dimension("1957-01-01", "2027-05-28") }}