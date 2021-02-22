MATCH(d:date_dim{d_year:2001})<-[:ON_Date]-(ss:store_sales)
WITH ss MATCH(s:store)<-[:AT_Store]-(ss:store_sales) WITH ss 
MATCH(ss:store_sales)-[:BY_Customer]->(c) WITH ss, c
MATCH(c)-[:Current_Addr]->(ca:customer_address) WITH ss, c, ca
MATCH (c)-[:Current_HDemo]->(hd:household_demographics) WITH ss, ca, c, hd
MATCH (c)-[:Current_CDemo]->(cd:customer_demographics) WITH ss, ca, c, hd, cd  
WHERE ((cd.cd_marital_status = 'U' AND cd.cd_education_status = 'Advanced Degree' AND ss.ss_sales_price>=100.00 AND ss.ss_sales_price<=150.00 AND hd.hd_dep_count = 3) OR (cd.cd_marital_status = 'M' AND cd.cd_education_status = 'Primary' AND ss.ss_sales_price>=50.00 AND ss.ss_sales_price<=100.00 AND hd.hd_dep_count = 1) OR (cd.cd_marital_status = 'D' AND cd.cd_education_status = 'Secondary' AND ss.ss_sales_price>= 150.00 AND ss.ss_sales_price<=200.00 AND hd.hd_dep_count = 1 )) 
AND ((ca.ca_country = 'United States' AND ca.ca_state IN ['AZ','NE','IA'] AND ss.ss_net_profit>=100 AND ss.ss_net_profit<=200) OR (ca.ca_country ='United States' AND ca.ca_state IN ['MS','CA','NV'] AND ss.ss_net_profit>=150 AND ss.ss_net_profit<=300)  OR (ca.ca_country = 'United States' AND ca.ca_state IN ['GA','TX','NJ'] AND ss.ss_net_profit>=50 AND ss.ss_net_profit<=250))
RETURN Avg(ss.ss_quantity), Avg(ss.ss_ext_sales_price), Avg(ss.ss_ext_wholesale_cost), Sum(ss.ss_ext_wholesale_cost); 
