MATCH(d:date_dim{d_moy:11}) WITH d
MATCH(d:date_dim)<-[:ON_Date]-(ss:store_sales) WITH ss, d
MATCH(i:item{i_manufact_id:427}) WITH i, ss, d
MATCH(ss:store_sales)-[:OF_Item]->(i:item) WITH i, ss, d
RETURN d.d_year, i.i_brand_id AS brand_id, i.i_brand AS brand, SUM(ss.ss_ext_discount_amt) as sum_agg
ORDER BY d.d_year, sum_agg DESC, brand_id LIMIT 100;
