{%- set yaml_metadata -%}

source_model: 'raw_location'
derived_columns:
  RECORD_SOURCE: 'SOURCE_FILE'
  LOCATION_KEY: 'LOCATION_ID'
  LOAD_DATE: 'LDTS'
--   EFFECTIVE_FROM: 'TRANSACTION_DATE'

hashed_columns:
    LOCATION_HK: 'LOCATION_ID'

    LOCATION_HASHDIFF:
        is_hashdiff: true
        columns: []
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{# Example: Dynamically fetch columns from the raw_location model #}
{% set dynamic_columns = get_filtered_columns(ref('raw_location'), except=['LOCATION_ID', 'LDTS', 'SOURCE_FILE' ,'RECORD_SOURCE', 'LOCATION_KEY', 'LOAD_DATE']) %}

{# Populate the columns in LOCATION_HASHDIFF dynamically #}
{% set _ = metadata_dict['hashed_columns']['LOCATION_HASHDIFF'].update({
    'columns': dynamic_columns
}) %}


{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     hashed_columns=hashed_columns,
                     ranked_columns=none) }}
