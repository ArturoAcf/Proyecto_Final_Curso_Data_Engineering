-- Staging
{% set models_to_generate = codegen.get_models(directory="models/staging/data_source", prefix="stg_") %}
{{
    codegen.generate_model_yaml(
        model_names=[
            "stg_astronauts",
            "stg_mission_astronauts",
            "stg_rockets",
            "stg_space_agencies",
            "stg_space_missions",
        ]
    )
}}

-- Base
{{ codegen.generate_model_yaml(
    model_names=['base_mission_astronauts']
) }}
{{ codegen.generate_model_yaml(
    model_names=['base_rockets']
) }}
{{ codegen.generate_model_yaml(
    model_names=['base_space_agencies']
) }}
{{ codegen.generate_model_yaml(
    model_names=['base_space_missions']
) }}

-- Marts
{% set models_to_generate = codegen.get_models(directory="models/marts") %}
{{
    codegen.generate_model_yaml(
        model_names=[
            "dim_astronauts",
            "dim_rockets",
            "dim_space_agencies",
            "dim_astronaut_roles",
            "dim_vehicle",
            "fct_space_missions"
        ]
    )
}}

-- Core
{% set models_to_generate = codegen.get_models(directory="models/marts/core") %}
{{
    codegen.generate_model_yaml(
        model_names=[
            "dim_mission_status",
            "dim_rocket_status",
            "dim_locations",
            "dim_time",
        ]
    )
}}

-- Intermediate
{% set models_to_generate = codegen.get_models(directory="models/intermediate") %}
{{
    codegen.generate_model_yaml(
        model_names=[
            "int_mission_astronauts",
            "int_space_missions"
        ]
    )
}}