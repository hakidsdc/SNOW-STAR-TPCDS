create database snow_data_X;\
use snow_data_X;\
create table customer_address\
(\
    ca_address_sk             integer               not null,\
    ca_address_id             char(16)              not null,\
    ca_street_number          char(10)                      ,\
    ca_street_name            varchar(60)                   ,\
    ca_street_type            char(15)                      ,\
    ca_suite_number           char(10)                      ,\
    ca_city                   varchar(60)                   ,\
    ca_county                 varchar(30)                   ,\
    ca_state                  char(2)                       ,\
    ca_zip                    char(10)                      ,\
    ca_country                varchar(20)                   ,\
    ca_gmt_offset             decimal(5,2)                  ,\
    ca_location_type          char(20)                      ,\
    primary key (ca_address_sk)\
);\
create table customer_demographics\
(\
    cd_demo_sk                integer               not null,\
    cd_gender                 char(1)                       ,\
    cd_marital_status         char(1)                       ,\
    cd_education_status       char(20)                      ,\
    cd_purchase_estimate      integer                       ,\
    cd_credit_rating          char(10)                      ,\
    cd_dep_count              integer                       ,\
    cd_dep_employed_count     integer                       ,\
    cd_dep_college_count      integer                       ,\
    primary key (cd_demo_sk)\
);\
create table customer\
(\
    c_customer_sk             integer               not null,\
    c_customer_id             char(16)              not null,\
    c_current_cdemo_sk        integer                       ,\
    c_current_hdemo_sk        integer                       ,\
    c_current_addr_sk         integer                       ,\
    c_first_shipto_date_sk    integer                       ,\
    c_first_sales_date_sk     integer                       ,\
    c_salutation              char(10)                      ,\
    c_first_name              char(20)                      ,\
    c_last_name               char(30)                      ,\
    c_preferred_cust_flag     char(1)                       ,\
    c_birth_day               integer                       ,\
    c_birth_month             integer                       ,\
    c_birth_year              integer                       ,\
    c_birth_country           varchar(20)                   ,\
    c_login                   char(13)                      ,\
    c_email_address           char(50)                      ,\
    c_last_review_date        char(10)                      ,\
    primary key (c_customer_sk)\
);\
ALTER TABLE customer DROP COLUMN c_first_sales_date_sk;\
ALTER TABLE customer DROP COLUMN c_first_shipto_date_sk;\
create table cust_addr select distinct(ca_address_sk), ca_address_id, ca_street_number, ca_street_name, ca_street_type, ca_suite_number, ca_city, ca_county, ca_state, ca_zip, ca_country, ca_gmt_offset, ca_location_type  from customer c left join customer_address ca on c.c_current_addr_sk=ca.ca_address_sk;\
create table cust_demo select distinct(cd_demo_sk), cd_gender, cd_marital_status, cd_education_status, cd_purchase_estimate, cd_credit_rating ,  cd_dep_count, cd_dep_employed_count, cd_dep_college_count from customer c left join customer_demographics cd on c.c_current_cdemo_sk=cd_demo_sk;\
create table store_sales\
(\
    ss_sold_date_sk           integer                       ,\
    ss_sold_time_sk           integer                       ,\
    ss_item_sk                integer               not null,\
    ss_customer_sk            integer                       ,\
    ss_cdemo_sk               integer                       ,\
    ss_hdemo_sk               integer                       ,\
    ss_addr_sk                integer                       ,\
    ss_store_sk               integer                       ,\
    ss_promo_sk               integer                       ,\
    ss_ticket_number          integer               not null,\
    ss_quantity               integer                       ,\
    ss_wholesale_cost         decimal(7,2)                  ,\
    ss_list_price             decimal(7,2)                  ,\
    ss_sales_price            decimal(7,2)                  ,\
    ss_ext_discount_amt       decimal(7,2)                  ,\
    ss_ext_sales_price        decimal(7,2)                  ,\
    ss_ext_wholesale_cost     decimal(7,2)                  ,\
    ss_ext_list_price         decimal(7,2)                  ,\
    ss_ext_tax                decimal(7,2)                  ,\
    ss_coupon_amt             decimal(7,2)                  ,\
    ss_net_paid               decimal(7,2)                  ,\
    ss_net_paid_inc_tax       decimal(7,2)                  ,\
    ss_net_profit             decimal(7,2)                  ,\
    primary key (ss_item_sk, ss_ticket_number)\
);\
create table store\
(\
    s_store_sk                integer               not null,\
    s_store_id                char(16)              not null,\
    s_rec_start_date          date                          ,\
    s_rec_end_date            date                          ,\
    s_closed_date_sk          integer                       ,\
    s_store_name              varchar(50)                   ,\
    s_number_employees        integer                       ,\
    s_floor_space             integer                       ,\
    s_hours                   char(20)                      ,\
    s_manager                 varchar(40)                   ,\
    s_market_id               integer                       ,\
    s_geography_class         varchar(100)                  ,\
    s_market_desc             varchar(100)                  ,\
    s_market_manager          varchar(40)                   ,\
    s_division_id             integer                       ,\
    s_division_name           varchar(50)                   ,\
    s_company_id              integer                       ,\
    s_company_name            varchar(50)                   ,\
    s_street_number           varchar(10)                   ,\
    s_street_name             varchar(60)                   ,\
    s_street_type             char(15)                      ,\
    s_suite_number            char(10)                      ,\
    s_city                    varchar(60)                   ,\
    s_county                  varchar(30)                   ,\
    s_state                   char(2)                       ,\
    s_zip                     char(10)                      ,\
    s_country                 varchar(20)                   ,\
    s_gmt_offset              decimal(5,2)                  ,\
    s_tax_precentage          decimal(5,2)                  ,\
    primary key (s_store_sk)\
);\
create table promotion\
(\
    p_promo_sk                integer               not null,\
    p_promo_id                char(16)              not null,\
    p_start_date_sk           integer                       ,\
    p_end_date_sk             integer                       ,\
    p_item_sk                 integer                       ,\
    p_cost                    decimal(15,2)                 ,\
    p_response_target         integer                       ,\
    p_promo_name              char(50)                      ,\
    p_channel_dmail           char(1)                       ,\
    p_channel_email           char(1)                       ,\
    p_channel_catalog         char(1)                       ,\
    p_channel_tv              char(1)                       ,\
    p_channel_radio           char(1)                       ,\
    p_channel_press           char(1)                       ,\
    p_channel_event           char(1)                       ,\
    p_channel_demo            char(1)                       ,\
    p_channel_details         varchar(100)                  ,\
    p_purpose                 char(15)                      ,\
    p_discount_active         char(1)                       ,\
    primary key (p_promo_sk)\
);\
ALTER TABLE promotion DROP COLUMN p_end_date_sk;
ALTER TABLE promotion DROP COLUMN p_item_sk;\
ALTER TABLE promotion DROP COLUMN p_start_date_sk;\
ALTER TABLE store DROP COLUMN s_closed_date_sk;\
