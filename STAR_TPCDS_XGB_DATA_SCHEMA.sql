create database star_XGB_data;
use star_XGB_data;
create table income_band
(
    ib_income_band_sk         integer               not null,
    ib_lower_bound            integer                       ,
    ib_upper_bound            integer                       ,
    primary key (ib_income_band_sk)
);
create table household_demographics
(
    hd_demo_sk                integer               not null,
    hd_income_band_sk         integer                       ,
    hd_buy_potential          char(15)                      ,
    hd_dep_count              integer                       ,
    hd_vehicle_count          integer                       ,
    primary key (hd_demo_sk)
);
create table customer_address
(
    ca_address_sk             integer               not null,
    ca_address_id             char(16)              not null,
    ca_street_number          char(10)                      ,
    ca_street_name            varchar(60)                   ,
    ca_street_type            char(15)                      ,
    ca_suite_number           char(10)                      ,
    ca_city                   varchar(60)                   ,
    ca_county                 varchar(30)                   ,
    ca_state                  char(2)                       ,
    ca_zip                    char(10)                      ,
    ca_country                varchar(20)                   ,
    ca_gmt_offset             decimal(5,2)                  ,
    ca_location_type          char(20)                      ,
    primary key (ca_address_sk)
);
create table customer_demographics
(
    cd_demo_sk                integer               not null,
    cd_gender                 char(1)                       ,
    cd_marital_status         char(1)                       ,
    cd_education_status       char(20)                      ,
    cd_purchase_estimate      integer                       ,
    cd_credit_rating          char(10)                      ,
    cd_dep_count              integer                       ,
    cd_dep_employed_count     integer                       ,
    cd_dep_college_count      integer                       ,
    primary key (cd_demo_sk)
);
create table customer
(
    c_customer_sk             integer               not null,
    c_customer_id             char(16)              not null,
    c_current_cdemo_sk        integer                       ,
    c_current_hdemo_sk        integer                       ,
    c_current_addr_sk         integer                       ,
    c_salutation              char(10)                      ,
    c_first_name              char(20)                      ,
    c_last_name               char(30)                      ,
    c_preferred_cust_flag     char(1)                       ,
    c_birth_day               integer                       ,
    c_birth_month             integer                       ,
    c_birth_year              integer                       ,
    c_birth_country           varchar(20)                   ,
    c_login                   char(13)                      ,
    c_email_address           char(50)                      ,
    c_last_review_date        char(10)                      ,
    primary key (c_customer_sk)
);
create table date_dim
(
    d_date_sk                 integer               ,
    d_date_id                 char(16)              not null,
    d_date                    date                          ,
    d_month_seq               integer                       ,
    d_week_seq                integer                       ,
    d_quarter_seq             integer                       ,
    d_year                    integer                       ,
    d_dow                     integer                       ,
    d_moy                     integer                       ,
    d_dom                     integer                       ,
    d_qoy                     integer                       ,
    d_fy_year                 integer                       ,
    d_fy_quarter_seq          integer                       ,
    d_fy_week_seq             integer                       ,
    d_day_name                char(9)                       ,
    d_quarter_name            char(6)                       ,
    d_holiday                 char(1)                       ,
    d_weekend                 char(1)                       ,
    d_following_holiday       char(1)                       ,
    d_first_dom               integer                       ,
    d_last_dom                integer                       ,
    d_same_day_ly             integer                       ,
    d_same_day_lq             integer                       ,
    d_current_day             char(1)                       ,
    d_current_week            char(1)                       ,
    d_current_month           char(1)                       ,
    d_current_quarter         char(1)                       ,
    d_current_year            char(1)                       ,
    primary key (d_date_sk)
);

alter table  customer add constraint c_a foreign key  (c_current_addr_sk) references  customer_address (ca_address_sk);
alter table  customer add constraint c_hd foreign key  (c_current_hdemo_sk) references  household_demographics (hd_demo_sk);
alter table  customer add constraint c_cd foreign key  (c_current_cdemo_sk) references  customer_demographics (cd_demo_sk);
alter table  household_demographics add constraint hd_ib foreign key  (hd_income_band_sk) references  income_band (ib_income_band_sk);


LOAD DATA LOCAL INFILE '/home/tpcds/snow/snow_data/income_band.csv' INTO TABLE income_band FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' ;
LOAD DATA LOCAL INFILE '/home/tpcds/snow/snow_data/household_demographics.csv' INTO TABLE household_demographics FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' ;
LOAD DATA LOCAL INFILE '/home/tpcds/snow/snow_data/customer_address.csv' INTO TABLE customer_address FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' ;
LOAD DATA LOCAL INFILE '/home/tpcds/snow/snow_data/customer_demographics.csv' INTO TABLE customer_demographics FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' ;
LOAD DATA LOCAL INFILE '/home/tpcds/snow/snow_data/customer.csv' INTO TABLE customer FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' ;

create table house_income select * from household_demographics hd left join income_band ib on hd.hd_income_band_sk=ib.ib_income_band_sk;

ALTER TABLE house_income DROP COLUMN hd_income_band_sk;
ALTER TABLE house_income add primary key (hd_demo_sk);
ALTER table customer drop foreign key c_hd;
ALTER table customer add constraint c_hd foreign key  (c_current_hdemo_sk) references house_income (hd_demo_sk);


CREATE TABLE cust_houseinc select * from customer c left join house_income hi on hi.hd_demo_sk=c.c_current_hdemo_sk ;
ALTER TABLE cust_houseinc DROP COLUMN c_current_hdemo_sk;
ALTER TABLE cust_houseinc add primary key (c_customer_sk);


Alter table customer drop foreign key c_a;
alter table cust_houseinc add constraint c_a foreign key  (c_current_addr_sk) references customer_address (ca_address_sk);


CREATE TABLE cust_houseincadr select * from cust_houseinc ch left join customer_address ca on ch.c_current_addr_sk =ca.ca_address_sk;

ALTER TABLE cust_houseincadr DROP COLUMN c_current_addr_sk;
Drop table customer;

CREATE TABLE customer select * from cust_houseincadr ch left join customer_demographics cd on ch.c_current_cdemo_sk=cd.cd_demo_sk;
ALTER TABLE customer DROP COLUMN c_current_cdemo_sk;

ALTER TABLE customer DROP COLUMN hd_demo_sk;
ALTER TABLE customer DROP COLUMN ib_income_band_sk;
ALTER TABLE customer DROP COLUMN ca_address_sk;
ALTER TABLE customer DROP COLUMN cd_demo_sk;

create table item
(
    i_item_sk                 integer               not null,
    i_item_id                 char(16)              not null,
    i_rec_start_date          date                          ,
    i_rec_end_date            date                          ,
    i_item_desc               varchar(200)                  ,
    i_current_price           decimal(7,2)                  ,
    i_wholesale_cost          decimal(7,2)                  ,
    i_brand_id                integer                       ,
    i_brand                   char(50)                      ,
    i_class_id                integer                       ,
    i_class                   char(50)                      ,
    i_category_id             integer                       ,
    i_category                char(50)                      ,
    i_manufact_id             integer                       ,
    i_manufact                char(50)                      ,
    i_size                    char(20)                      ,
    i_formulation             char(20)                      ,
    i_color                   char(20)                      ,
    i_units                   char(10)                      ,
    i_container               char(10)                      ,
    i_manager_id              integer                       ,
    i_product_name            char(50)                      ,
    primary key (i_item_sk)
);
create table store
(
    s_store_sk                integer               not null,
    s_store_id                char(16)              not null,
    s_rec_start_date          date                          ,
    s_rec_end_date            date                          ,
    s_store_name              varchar(50)                   ,
    s_number_employees        integer                       ,
    s_floor_space             integer                       ,
    s_hours                   char(20)                      ,
    s_manager                 varchar(40)                   ,
    s_market_id               integer                       ,
    s_geography_class         varchar(100)                  ,
    s_market_desc             varchar(100)                  ,
    s_market_manager          varchar(40)                   ,
    s_division_id             integer                       ,
    s_division_name           varchar(50)                   ,
    s_company_id              integer                       ,
    s_company_name            varchar(50)                   ,
    s_street_number           varchar(10)                   ,
    s_street_name             varchar(60)                   ,
    s_street_type             char(15)                      ,
    s_suite_number            char(10)                      ,
    s_city                    varchar(60)                   ,
    s_county                  varchar(30)                   ,
    s_state                   char(2)                       ,
    s_zip                     char(10)                      ,
    s_country                 varchar(20)                   ,
    s_gmt_offset              decimal(5,2)                  ,
    s_tax_precentage          decimal(5,2)                  ,
    primary key (s_store_sk)
);
create table promotion
(
    p_promo_sk                integer               not null,
    p_promo_id                char(16)              not null,
    p_cost                    decimal(15,2)                 ,
    p_response_target         integer                       ,
    p_promo_name              char(50)                      ,
    p_channel_dmail           char(1)                       ,
    p_channel_email           char(1)                       ,
    p_channel_catalog         char(1)                       ,
    p_channel_tv              char(1)                       ,
    p_channel_radio           char(1)                       ,
    p_channel_press           char(1)                       ,
    p_channel_event           char(1)                       ,
    p_channel_demo            char(1)                       ,
    p_channel_details         varchar(100)                  ,
    p_purpose                 char(15)                      ,
    p_discount_active         char(1)                       ,
    primary key (p_promo_sk)
);
create table store_sales
(
    ss_sold_date_sk           integer                       ,
    ss_sold_time_sk           integer                       ,
    ss_item_sk                integer               not null,
    ss_customer_sk            integer                       ,
    ss_store_sk               integer                       ,
    ss_promo_sk               integer                       ,
    ss_ticket_number          integer               not null,
    ss_quantity               integer                       ,
    ss_wholesale_cost         decimal(7,2)                  ,
    ss_list_price             decimal(7,2)                  ,
    ss_sales_price            decimal(7,2)                  ,
    ss_ext_discount_amt       decimal(7,2)                  ,
    ss_ext_sales_price        decimal(7,2)                  ,
    ss_ext_wholesale_cost     decimal(7,2)                  ,
    ss_ext_list_price         decimal(7,2)                  ,
    ss_ext_tax                decimal(7,2)                  ,
    ss_coupon_amt             decimal(7,2)                  ,
    ss_net_paid               decimal(7,2)                  ,
    ss_net_paid_inc_tax       decimal(7,2)                  ,
    ss_net_profit             decimal(7,2)                  ,
    primary key (ss_item_sk, ss_ticket_number)
);

LOAD DATA LOCAL INFILE '/home/tpcds/snow/snow_data_XGB/store.csv' INTO TABLE store FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' ;
LOAD DATA LOCAL INFILE '/home/tpcds/snow/snow_data_XGB/item.csv' INTO TABLE item FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' ;
LOAD DATA LOCAL INFILE '/home/tpcds/snow/snow_data_XGB/promotion.csv' INTO TABLE promotion FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' ;
LOAD DATA LOCAL INFILE '/home/tpcds/snow/snow_data_XB/store_sales.csv' INTO TABLE store_sales FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' ;
select * into outfile '/var/lib/mysql/customer.csv' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' FROM customer;
