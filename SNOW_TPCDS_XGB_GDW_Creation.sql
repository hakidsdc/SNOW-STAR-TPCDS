USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/income_band.csv' AS line FIELDTERMINATOR '|' CREATE (:income_band {ib_income_band_sk: toInteger(line[0]), ib_lower_bound  : toInteger(line[1]), ib_upper_bound: toInteger(line[2])});



USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/household_demographics.csv' AS line FIELDTERMINATOR '|' CREATE (:household_demographics { hd_demo_sk: toInteger(line[0]),  hd_income_band_sk : toInteger(line[1]), hd_buy_potential : line[2], hd_dep_count : toInteger(line[3]), hd_vehicle_count  : toInteger(line[4])});

USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/customer_address1.csv' AS line FIELDTERMINATOR '|' CREATE (:customer_address { ca_address_sk: toInteger(line[0]), ca_address_id: line[1], ca_street_number: line[2], ca_street_name : line[3], ca_street_type: line[4], ca_suite_number: line[5],  ca_city : line[6], ca_county : line[7], ca_state : line[8], ca_zip : line[9], ca_country : line[10],  ca_gmt_offset: toFloat(line[11]),  ca_location_type: line[12]});


USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/customer_demographics1.csv' AS line FIELDTERMINATOR '|' CREATE (:customer_demographics { cd_demo_sk: toInteger(line[0]), cd_gender : line[1], cd_marital_status: line[2], cd_education_status : line[3], cd_purchase_estimate: toInteger(line[4]), cd_credit_rating : line[5],  cd_dep_count : toInteger(line[6]), cd_dep_count : toInteger(line[7]),  cd_dep_employed_count : toInteger(line[8]), cd_dep_college_count : toInteger(line[9])});




USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/date_dim.csv' AS line FIELDTERMINATOR '|' CREATE (:date_dim { d_date_sk: toInteger(line[0]),  d_date_id  : line[1], d_date: date(line[2]), d_month_seq : toInteger(line[3]), d_week_seq : toInteger(line[4]), d_quarter_seq : toInteger(line[5]),  d_year : toInteger(line[6]), d_dow : toInteger(line[7]),  d_moy : toInteger(line[8]), d_dom : toInteger(line[9]), d_qoy : toInteger(line[10]), d_fy_year : toInteger(line[11]),  d_fy_quarter_seq :  toInteger(line[12]), d_fy_week_seq : toInteger(line[13]), d_day_name : line[14], d_quarter_name : line[15], d_holiday :  line[16], d_weekend:  line[17], d_following_holiday:  line[18], d_first_dom:  toInteger(line[19]),  d_last_dom:  toInteger(line[20]), d_same_day_ly:  toInteger(line[21]), d_same_day_lq : toInteger(line[22]), d_current_day: line[23], d_current_week : line[24], d_current_month :  line[25], d_current_quarter : line[26], d_current_year :  line[27]});


USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/time_dim1.csv' AS line FIELDTERMINATOR '|' CREATE (:time_dim {t_time_sk: toInteger(line[0]),   t_time_id  : line[1], t_time: toInteger(line[2]), t_hour : toInteger(line[3]),  t_minute : toInteger(line[4]), t_second  : toInteger(line[5]), t_am_pm : line[6], t_shift : line[7],  t_sub_shift : line[8], t_meal_time : line[9]});


USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/item1.csv' AS line FIELDTERMINATOR '|' CREATE (:item { i_item_sk: toInteger(line[0]),  i_item_id  : line[1], i_rec_start_date: toInteger(line[2]),  i_rec_end_date : toInteger(line[3]), i_item_desc: line[4], i_current_price : toFloat(line[5]),  i_wholesale_cost : toFloat(line[6]), i_brand_id : toInteger(line[7]),  i_brand : line[8],  i_class_id  : toInteger(line[9]), i_class : line[10], i_category_id : toInteger(line[11]),  i_category:  line[12], i_manufact_id  : toInteger(line[13]),  i_manufact : line[14], i_size : line[15], i_formulation :  line[16], i_color:  line[17], i_units:  line[18], i_container:  line[19],   i_manager_id :  toInteger(line[20]),  i_product_name :  line[21]});


 USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/store1.csv' AS line FIELDTERMINATOR '|' CREATE (:store { s_store_sk: toInteger(line[0]),  s_store_id  : line[1], s_rec_start_date : toInteger(line[2]),  s_rec_end_date : toInteger(line[3]), s_store_name : line[4],  s_number_employees  : toInteger(line[5]), s_floor_space : toInteger(line[6]), s_hours : line[7],  s_manager:  line[8], s_market_id  : toInteger(line[9]),  s_geography_class : line[10], s_market_desc  : line[11], s_market_manager :  line[12], s_division_id:  toInteger(line[13]), s_division_name :  line[14], s_company_id :  toInteger(line[15]),   s_company_name  :  line[16],  s_street_number :  line[17],  s_street_name  :  line[18], s_street_type  :  line[19], s_suite_number  :  line[20], s_city : line[21], s_county : line[22], s_state: line[23], s_zip: line[24], s_country : line[25],  s_gmt_offset : toFloat(line[26]),  s_tax_precentage : toFloat(line[27])});

USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/promotion1.csv' AS line FIELDTERMINATOR '|' CREATE (:promotion { p_promo_sk: toInteger(line[0]),  p_promo_id  : line[1], p_cost  : toFloat(line[2]), p_response_target  : toInteger(line[3]), p_promo_name : line[4],  p_channel_dmail:  line[5], p_channel_email : line[6],  p_channel_catalog : line[7], p_channel_tv  : line[8], p_channel_radio:  line[9],  p_channel_press:  line[10], p_channel_event :  line[11], p_channel_demo :  line[12],   p_channel_details  :  line[13],  p_purpose :  line[14], p_discount_active:  line[15] });

USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/customer1.csv' AS line FIELDTERMINATOR '|' CREATE (:customer { c_customer_sk: toInteger(line[0]),  c_customer_id  : line[1],  c_current_cdemo_sk : toInteger(line[2]), c_current_hdemo_sk: toInteger(line[3]), c_current_addr_sk : toInteger(line[4]), c_salutation : line[5],  c_first_name:  line[6], c_last_name  : toInteger(line[7]),  c_preferred_cust_flag : line[8], c_birth_day  : toInteger(line[9]), c_birth_month :  toInteger(line[10]),  c_birth_year:  toInteger(line[11]), c_birth_country :  line[12], c_login :  line[13],   c_email_address  :  line[14],  c_last_review_date :  line[15]});


USING PERIODIC COMMIT LOAD CSV FROM 'file:///home//tpcds/snow/snow_data/store_sales.csv' AS line FIELDTERMINATOR '|' CREATE (:store_sales {ss_sold_date_sk: toInteger(line[0]),  ss_sold_time_sk  : toInteger(line[1]), ss_item_sk: toInteger(line[2]), ss_customer_sk : toInteger(line[3]), ss_store_sk : toInteger(line[4]),  ss_promo_sk : toInteger(line[5]), ss_ticket_number : toInteger(line[6]), ss_quantity : toInteger(line[7]), ss_wholesale_cost : toFloat(line[8]),  ss_list_price :  toFloat(line[9]), ss_sales_price : toFloat(line[10]), ss_ext_discount_amt : toFloat(line[11]), ss_ext_sales_price : toFloat(line[12]), ss_ext_wholesale_cost :  toFloat(line[13]), ss_ext_list_price:  toFloat(line[14]), ss_ext_tax:  toFloat(line[15]), ss_coupon_amt:  toFloat(line[16]), ss_net_paid:  toFloat(line[17]), ss_net_paid_inc_tax:  toFloat(line[18]), ss_net_profit : toFloat(line[19])});




CREATE CONSTRAINT ON (ib:income_band) ASSERT ib.ib_income_band_sk IS UNIQUE;
CREATE CONSTRAINT ON (hd:household_demographics) ASSERT hd.hd_demo_sk IS UNIQUE;
CREATE CONSTRAINT ON (ca:customer_address) ASSERT ca.ca_address_sk IS UNIQUE;
CREATE CONSTRAINT ON (cd:customer_demographics) ASSERT cd.cd_demo_sk IS UNIQUE;
CREATE CONSTRAINT ON (d:date_dim) ASSERT d.d_date_sk IS UNIQUE;
CREATE CONSTRAINT ON (c:customer) ASSERT c.c_customer_sk IS UNIQUE;
CREATE CONSTRAINT ON (s:store) ASSERT s.s_store_sk IS UNIQUE;
CREATE CONSTRAINT ON (i:item) ASSERT i.i_item_sk IS UNIQUE;
CREATE CONSTRAINT ON (p:promotion) ASSERT p.p_promo_sk IS UNIQUE;
CREATE CONSTRAINT ON (t:time_dim) ASSERT t.t_time_sk IS UNIQUE;
CREATE INDEX ON :store_sales(ss_item_sk, ss_ticket_number);



MATCH (ca:customer_address) WITH ca MATCH (c:customer) WHERE ca.ca_address_sk=c.c_current_addr_sk CREATE (c)-[:Current_Addr]->(ca);
MATCH (hd:household_demographics) WITH hd MATCH (c:customer) WHERE c.c_current_hdemo_sk=hd.hd_demo_sk CREATE (c)-[:Current_HDemo]->(hd);
MATCH (cd:customer_demographics) WITH cd MATCH (c:customer) WHERE cd.cd_demo_sk=c.c_current_cdemo_sk CREATE (c)-[:Current_CDemo]->(cd);
MATCH (hd:household_demographics) WITH hd MATCH (ib:income_band) WHERE hd.hd_income_band_sk=ib.ib_income_band_sk CREATE (hd)-[:Has]->(ib);
MATCH (c:customer) WITH c MATCH (ss:store_sales) WHERE c.c_customer_sk=ss.ss_customer_sk CREATE (ss)-[:BY_Customer]->(c);
MATCH (i:item) WITH i MATCH (ss:store_sales) WHERE i.i_item_sk=ss.ss_item_sk CREATE (ss)-[:OF_Item]->(i);
MATCH (p:promotion) WITH p MATCH (ss:store_sales) WHERE p.p_promo_sk=ss.ss_promo_sk CREATE (ss)-[:ON_Promo]->(p);
MATCH (d:date_dim) WITH d MATCH (ss:store_sales) WHERE d.d_date_sk=ss.ss_sold_date_sk CREATE (ss)-[:ON_Date]->(d);
MATCH (t:time_dim) WITH t MATCH (ss:store_sales) WHERE t.t_time_sk=ss.ss_sold_time_sk CREATE (ss)-[:At_Time]->(t);
MATCH (s:store) WITH s MATCH (ss:store_sales) WHERE s.s_store_sk=ss.ss_store_sk CREATE (ss)-[:AT_Store]->(s);
