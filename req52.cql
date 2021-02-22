MATCH(d:date_dim{d_moy:12, d_year:1998})<-[:ON_Date]-(ss:store_sales) WITH d, ss MATCH(i:item{i_manager_id:1})<-[:OF_Item]-(ss) 
WITH i, d, ss RETURN d.d_year, i.i_brand_id as brand_id, i.i_brand as brand, Sum(ss.ss_ext_sales_price) as ext_price order by d.d_year, ext_price DESC, brand_id LIMIT 100;
