select distinct * from {{ source('samples_data', 'STG_LOCATION_RAW') }}
