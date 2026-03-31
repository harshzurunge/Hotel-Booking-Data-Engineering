create database hotel_db;

create or replace file format ff_csv
    type = "CSV"
    field_optionally_enclosed_by = '"'
    skip_header = 1
    null_if = ('null', 'NULL', '');


create or replace stage stg_hotel_bookings
    file_format = (format_name = ff_csv);

-- Create Table BRONZE_HOTEL_BOOKING
CREATE or replace TABLE BRONZE_HOTEL_BOOKING (
    booking_id STRING,
    hotel_id STRING,
    hotel_city STRING,
    customer_id STRING,
    customer_name STRING,
    customer_email STRING,
    check_in_date STRING,
    check_out_date STRING,
    room_type STRING,
    num_guests STRING,
    total_amount STRING,
    currency STRING,
    booking_status STRING
);

copy into bronze_hotel_booking
from @stg_hotel_bookings
file_format = (format_name = ff_csv)
on_error = 'continue';


select * from bronze_hotel_booking limit 50;