
    
    

select
    LOCATION_ID as unique_field,
    count(*) as n_records

from DEV_DB.data_mart.dim_location
where LOCATION_ID is not null
group by LOCATION_ID
having count(*) > 1

