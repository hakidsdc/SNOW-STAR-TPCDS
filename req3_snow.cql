MATCH(d:date_dim{d_moy:11})<-[:ON_Date]-(ss:store_sales)-[:OF_Item]->(i:item{i_manufact_id:427}) RETURN d.d_year, i.i_brand_id AS brand_id, i.i_brand AS brand, SUM(ss.ss_ext_discount_amt) as sum_agg
ORDER BY d.d_year, sum_agg DESC, brand_id LIMIT 100;
